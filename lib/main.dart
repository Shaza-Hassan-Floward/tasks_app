
import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'core/di/service_locator.dart';
import 'core/router/app_route.dart';
import 'core/theme/app_theme.dart';
import 'presentation/bloc/tasks_list/tasks_list_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(
    BlocProvider(
      create: (_) => sl<TasksListBloc>()..add(const LoadTasksListEvent()),
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: lightAppTheme(),
      darkTheme: darkAppTheme(),
      debugShowCheckedModeBanner: false,
      routerConfig: routes,
    );
  }

  final _appLinks = AppLinks();
  @override
  void initState() {
    super.initState();
    _handleInitialDeepLink();
  }

  Future<void> _handleInitialDeepLink() async {
    final uri = await _appLinks.getInitialAppLink();
    if (uri == null || !mounted) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final path = uri.path;  // e.g. /home/add-task

      // Determine correct branch
      final branchIndex = path.startsWith("/settings") ? 1 : 0;
      //
      // // Switch shell branch first
      ScaffoldWithNavbar.shell.goBranch(branchIndex);
      if(kDebugMode) {
        print("Navigating to branch for path $path");
      }

      // Then navigate inside that branch
      context.go(path);
    });
  }

}
