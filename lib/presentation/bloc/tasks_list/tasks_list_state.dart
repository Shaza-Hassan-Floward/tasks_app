part of 'tasks_list_bloc.dart';

abstract class TasksListState extends Equatable {
  const TasksListState();

  @override
  List<Object?> get props => [];
}

class TasksListLoading extends TasksListState {
  const TasksListLoading();
}

class TasksListLoaded extends TasksListState {
  final List<TaskEntity> tasks;
  const TasksListLoaded(this.tasks);

  @override
  List<Object?> get props => [tasks];
}

class TasksListError extends TasksListState {
  final String message;
  const TasksListError(this.message);

  @override
  List<Object?> get props => [message];
}