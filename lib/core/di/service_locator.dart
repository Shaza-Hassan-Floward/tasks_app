
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../data/data_source/tasks_remote_data_source.dart';
import '../../data/repository/task_repository_impl.dart';
import '../../domain/repo/task_repository.dart';
import '../../domain/usecase/add_task_usecase.dart';
import '../../domain/usecase/delete_task_usecase.dart';
import '../../domain/usecase/fetch_tasks_usecase.dart';
import '../../domain/usecase/get_task_usecase.dart';
import '../../domain/usecase/update_task_usecase.dart';
import '../../presentation/bloc/tasks_bloc.dart';
import '../network/dio_client.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Dio
  sl.registerLazySingleton<Dio>(() => createDioClient());

  // Data sources
  sl.registerLazySingleton<TasksRemoteDataSource>(
        () => TasksRemoteDataSource(sl<Dio>()),
  );

  // Repository
  sl.registerLazySingleton<TaskRepository>(
        () => TaskRepositoryImpl(remote: sl<TasksRemoteDataSource>()),
  );

  // Use cases
  sl.registerLazySingleton<FetchTasksUseCase>(
        () => FetchTasksUseCase(sl<TaskRepository>()),
  );
  sl.registerLazySingleton<GetTaskUseCase>(
        () => GetTaskUseCase(sl<TaskRepository>()),
  );
  sl.registerLazySingleton<AddTaskUseCase>(
        () => AddTaskUseCase(sl<TaskRepository>()),
  );
  sl.registerLazySingleton<UpdateTaskUseCase>(
        () => UpdateTaskUseCase(sl<TaskRepository>()),
  );
  sl.registerLazySingleton<DeleteTaskUseCase>(
        () => DeleteTaskUseCase(sl<TaskRepository>()),
  );

  // Bloc
  sl.registerFactory<TasksBloc>(
        () => TasksBloc(
      fetchTasksUseCase: sl<FetchTasksUseCase>(),
      getTaskUseCase: sl<GetTaskUseCase>(),
      addTaskUseCase: sl<AddTaskUseCase>(),
      updateTaskUseCase: sl<UpdateTaskUseCase>(),
      deleteTaskUseCase: sl<DeleteTaskUseCase>(),
    ),
  );
}