part of 'tasks_list_bloc.dart';

abstract class TasksListEvent extends Equatable {
  const TasksListEvent();

  @override
  List<Object?> get props => [];
}

class LoadTasksListEvent extends TasksListEvent {
  const LoadTasksListEvent();
}

class AddTaskFromFormEvent extends TasksListEvent {
  final String title;
  final String description;

  const AddTaskFromFormEvent({
    required this.title,
    required this.description,
  });

  TaskEntity toEntity() {
    return TaskEntity(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      description: description,
      isCompleted: false,
      userId: 1,
    );
  }

  @override
  List<Object?> get props => [title, description];
}