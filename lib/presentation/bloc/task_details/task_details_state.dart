part of 'task_details_bloc.dart';

abstract class TaskDetailsState extends Equatable {
  const TaskDetailsState();

  @override
  List<Object?> get props => [];
}

class TaskDetailsLoading extends TaskDetailsState {
  const TaskDetailsLoading();
}

class TaskDetailsLoaded extends TaskDetailsState {
  final TaskEntity task;
  const TaskDetailsLoaded(this.task);

  @override
  List<Object?> get props => [task];
}

class TaskDetailsError extends TaskDetailsState {
  final String message;
  const TaskDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}