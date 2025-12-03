
import 'dart:ffi';

import 'package:get_it/get_it.dart';

import '../../data/repository/task_repository_impl.dart';
import '../../domain/repo/task_repository.dart';
import '../../domain/usecase/add_task_usecase.dart';
import '../../domain/usecase/fetch_tasks_usecase.dart';
import '../../domain/usecase/update_task_usecase.dart';
import '../../presentation/bloc/tasks_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {

  sl.registerLazySingleton<TaskRepository>(
        () => TaskRepositoryImpl(),
  );

  // 2) Use cases
  sl.registerLazySingleton<AddTaskUseCase>(
        () => AddTaskUseCase(sl()),
  );

  sl.registerLazySingleton<FetchTasksUseCase>(
        () => FetchTasksUseCase(sl()),
  );

  sl.registerLazySingleton<UpdateTaskUseCase>(
        () => UpdateTaskUseCase(sl()),
  );

  // 3) BLoC
  sl.registerFactory<TasksBloc>(
        () => TasksBloc(
      addTaskUseCase: sl(),
      fetchTasksUseCase: sl(),
      updateTaskUseCase: sl(),
    ),
  );

}