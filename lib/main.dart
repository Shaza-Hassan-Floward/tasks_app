
import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks_app/core/theme/app_theme.dart';

import 'core/router/app_route.dart';
import 'data/repository/task_repository_impl.dart';
import 'domain/usecase/add_task_usecase.dart';
import 'domain/usecase/fetch_tasks_usecase.dart';
import 'domain/usecase/update_task_usecase.dart';
import 'presentation/bloc/tasks_bloc.dart';

void main() {
  final repo = TaskRepositoryImpl();

  runApp(
    BlocProvider(
      create: (_) => TasksBloc(
        addTaskUseCase: AddTaskUseCase(repo),
        fetchTasksUseCase: FetchTasksUseCase(repo),
        updateTaskUseCase: UpdateTaskUseCase(repo),
      )..add(LoadTasksEvent()),
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
