
part of 'tasks_bloc.dart';

sealed class TasksState {
  const TasksState();
}

class TasksInitial extends TasksState {
  const TasksInitial();
}

class TasksLoading extends TasksState {
  const TasksLoading();
}

class TasksLoaded extends TasksState {
  final List<TaskEntity> tasks;

  const TasksLoaded(this.tasks);
}

class TasksError extends TasksState {
  final String message;

  const TasksError(this.message);
}
