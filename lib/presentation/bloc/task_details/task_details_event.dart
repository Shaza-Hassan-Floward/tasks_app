part of 'task_details_bloc.dart';

abstract class TaskDetailsEvent extends Equatable {
  const TaskDetailsEvent();

  @override
  List<Object?> get props => [];
}

class LoadTaskDetailsEvent extends TaskDetailsEvent {
  final int id;
  const LoadTaskDetailsEvent(this.id);

  @override
  List<Object?> get props => [id];
}