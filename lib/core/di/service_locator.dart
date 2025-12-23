
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../../data/auth/auth_remote_data_source.dart';
import '../../data/auth/auth_repository_impl.dart';
import '../../data/repository/task_firestore_repository_impl.dart';
import '../../data/repository/task_repository_impl.dart';
import '../../data/tasks_data_source/task_firestore_remote_data_source.dart';
import '../../data/tasks_data_source/tasks_remote_data_source.dart';
import '../../domain/repo/auth_repository.dart';
import '../../domain/repo/task_firestore_repository.dart';
import '../../domain/repo/task_repository.dart';
import '../../domain/usecase/add_task_usecase.dart';
import '../../domain/usecase/delete_task_usecase.dart';
import '../../domain/usecase/fetch_tasks_usecase.dart';
import '../../domain/usecase/get_task_usecase.dart';
import '../../domain/usecase/login_usecase.dart';
import '../../domain/usecase/logout_usecase.dart';
import '../../domain/usecase/sign_up_usecase.dart';
import '../../domain/usecase/update_task_usecase.dart';
import '../../presentation/bloc/auth/auth_bloc.dart';
import '../../presentation/bloc/task_details/task_details_bloc.dart';
import '../../presentation/bloc/tasks_list/tasks_list_bloc.dart';
import '../auth/auth_notifier.dart';
import '../network/dio_client.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Dio
  sl.registerLazySingleton<Dio>(() => createDioClient());

  // firebase

  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  // Data sources
  sl.registerLazySingleton<TasksRemoteDataSource>(
        () => TasksRemoteDataSource(sl<Dio>()),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(sl(), sl())
  );
  // Repository
  sl.registerLazySingleton<TaskRepository>(
        () => TaskRepositoryImpl(remote: sl<TasksRemoteDataSource>()),
  );

  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl())
  );

  sl.registerLazySingleton<AuthNotifier>(
        () => AuthNotifier(sl<FirebaseAuth>()),
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
  // UseCase
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));

  // Bloc
  // Bloc registrations
  sl.registerFactory<TasksListBloc>(
        () => TasksListBloc(
      fetchTasksUseCase: sl<FetchTasksUseCase>(),
      addTaskUseCase: sl<AddTaskUseCase>(),
    ),
  );

  sl.registerFactory<TaskDetailsBloc>(
        () => TaskDetailsBloc(
      sl<GetTaskUseCase>(),
    ),
  );

  sl.registerFactory(() => AuthBloc(
      signUpUseCase: sl(),
      logoutUseCase: sl(),
      loginUseCase: sl()
  ));

  sl.registerLazySingleton<TaskFirestoreRemoteDataSource>(
        () => TaskFirestoreRemoteDataSourceImpl(
          sl<FirebaseFirestore>(),
          sl<FirebaseAuth>(),
    ),
  );

  sl.registerLazySingleton<TaskFireStoreRepository>(
        () => TaskFirestoreRepositoryImpl(
          sl<TaskFirestoreRemoteDataSource>(),
    ),
  );
}