
part of 'tasks_bloc.dart';

sealed class TasksState {
  const TasksState();
}

class TasksInitial extends TasksState {
  const TasksInitial();
}

class Loading extends TasksState {
  const Loading();
}

class TasksLoaded extends TasksState {
  final List<TaskEntity> tasks;

  const TasksLoaded(this.tasks);
}

class TasksError extends TasksState {
  final String message;

  const TasksError(this.message);
}

class TaskDetailLoaded extends TasksState {
  final TaskEntity task;
  TaskDetailLoaded(this.task);
}
class TaskDetailError extends TasksState {
  final String message;
  TaskDetailError(this.message);
}