
part of 'tasks_bloc.dart';

sealed class TasksEvent {}

final class LoadTasksEvent extends TasksEvent {}

final class AddTaskEvent extends TasksEvent {
  final TaskEntity task;

  AddTaskEvent({required String title, required String description})
      : task = TaskEntity(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: title,
          description: description,
          isCompleted: false,
        );
}

final class UpdateTaskEvent extends TasksEvent {
  final TaskEntity task;

  UpdateTaskEvent(this.task);
}

class LoadSingleTaskEvent extends TasksEvent {
  final String id;
  LoadSingleTaskEvent(this.id);
}