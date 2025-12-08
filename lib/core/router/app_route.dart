import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks_app/presentation/task_details/task_details_screen_by_task_id.dart';

import '../../domain/entities/task.dart';
import '../../presentation/add_task_screen/add_task_screen.dart';
import '../../presentation/bloc/tasks_bloc.dart';
import '../../presentation/homescreen/home_screen.dart';
import '../../presentation/settingscreen/setting_screen.dart';
import '../../presentation/task_details/task_details_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _settingsNavigatorKey = GlobalKey<NavigatorState>();

final _routes = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: "/home",
    routes: [
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
                          builder: (context, state) => const AddTaskScreen()),
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
                            return BlocProvider.value(
                              value: context.read<TasksBloc>(),
                              child: TaskDetailsScreenByTaskId(taskId: taskId),
                            );
                          })
                    ])
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
  static late StatefulNavigationShell shell; // ADD THIS

  @override
  Widget build(BuildContext context) {
    shell = navigationShell; // STORE IT

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
