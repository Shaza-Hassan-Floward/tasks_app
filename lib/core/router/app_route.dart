import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks_app/presentation/add_task_screen/add_task_screen.dart';
import 'package:tasks_app/presentation/settingscreen/setting_screen.dart';

import '../../presentation/homescreen/home_screen.dart';

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
                          builder: (context, state) => const AddTaskScreen())
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
// A common pattern when using bottom navigation bars is to support
// navigating to the initial location when tapping the item that is
// already active. This example demonstrates how to support this behavior,
// using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
