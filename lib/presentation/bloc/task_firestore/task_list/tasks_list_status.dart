import '../../../../domain/entities/task_firestore.dart';

sealed class TasksListStatus {}

final class TasksListInitial extends TasksListStatus {}

final class TasksListLoading extends TasksListStatus {}

final class TasksListLoaded extends TasksListStatus {
  final List<TaskFirestoreEntity> tasks;
  TasksListLoaded(this.tasks);
}

final class TasksListError extends TasksListStatus {
  final String message;
  TasksListError(this.message);
}