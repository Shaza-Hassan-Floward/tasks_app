import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/add_task_screen/add_task_screen.dart';
import '../../presentation/auth/login/login_screen.dart';
import '../../presentation/auth/regestiration/signup_screen.dart';
import '../../presentation/auth/start_screen/start_screen.dart';
import '../../presentation/bloc/auth/auth_bloc.dart';
import '../../presentation/bloc/task_details/task_details_bloc.dart';
import '../../presentation/homescreen/home_screen.dart';
import '../../presentation/settingscreen/setting_screen.dart';
import '../../presentation/task_details/task_details_screen_by_task_id.dart';
import '../auth/auth_notifier.dart';
import '../di/service_locator.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _settingsNavigatorKey = GlobalKey<NavigatorState>();

final _routes = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/start',
    refreshListenable: sl<AuthNotifier>(),
    redirect: authRedirect,
    routes: [
      GoRoute(
        path: '/start',
        name: 'start',
        builder: (_, __) => const StartScreen(),
        routes: [
          GoRoute(
            path: 'signup',
            name: "signup",
            builder: (context, state) => BlocProvider(
              create: (_) => sl<AuthBloc>(),
              child: const SignUpScreen(),
            ),
          ),
          GoRoute(
            path: "login",
            name: "login",
            builder: (context, state) => BlocProvider(
                create: (_) => sl<AuthBloc>(),
                child: const LoginScreen()
            ),
          ),
        ]
      ),

      StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return ScaffoldWithNavbar(navigationShell);
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: "/home",
                  name: "home",
                  builder: (context, state) => const HomeScreen(),
                  routes: [
                    GoRoute(
                      path: "add-task",
                      name: "add-task",
                      builder: (context, state) => const AddTaskScreen(),
                    ),
                    // GoRoute(
                    //     path: "details",
                    //     name: "task-details",
                    //     builder: (context, state) {
                    //       final task = state.extra as TaskEntity;
                    //       return TaskDetailsScreen(taskEntity: task);
                    //     }),
                    GoRoute(
                        path: "details/:id",
                        name: "task-details",
                        builder: (context, state) {
                          final idStr = state.pathParameters['id']!;
                          final taskId = int.tryParse(idStr) ?? -1; // fallback
                          return BlocProvider(
                            create: (_) =>
                            sl<TaskDetailsBloc>()..add(LoadTaskDetailsEvent(taskId)),
                            child: TaskDetailsScreenByTaskId(taskId: taskId),
                          );
                        }),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(navigatorKey: _settingsNavigatorKey, routes: [
              GoRoute(
                path: "/settings",
                builder: (context, state) => const SettingScreen(),
              )
            ])
          ])
    ]);

final routes = _routes;

class ScaffoldWithNavbar extends StatelessWidget {
  const ScaffoldWithNavbar(this.navigationShell, {super.key});

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
        ],
        onTap: _onTap,
      ),
    );
  }

  void _onTap(index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

String? authRedirect(BuildContext context, GoRouterState state) {
  final auth = sl<AuthNotifier>();
  final loggedIn = auth.isLoggedIn;

  final location = state.matchedLocation;

  final isAuthRoute = location.startsWith('/start');


  // 🔒 Not logged in → force auth flow
  if (!loggedIn && !isAuthRoute) {
    return '/start';
  }

  // ✅ Logged in → block auth pages
  if (loggedIn && isAuthRoute) {
    return '/home';
  }

  return null;
}