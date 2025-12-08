
part of 'tasks_bloc.dart';

sealed class TasksEvent {}

final class LoadTasksEvent extends TasksEvent {}

final class AddTaskEvent extends TasksEvent {
  final TaskEntity task;

  AddTaskEvent({required String title, required String description})
      : task = TaskEntity(
    id: DateTime.now().millisecondsSinceEpoch,
    title: title,
    description: description,
    isCompleted: false,
    userId: 20,
  );
}

final class UpdateTaskEvent extends TasksEvent {
  final TaskEntity task;

  UpdateTaskEvent(this.task);
}

class LoadSingleTaskEvent extends TasksEvent {
  final int id;
  LoadSingleTaskEvent(this.id);
}
final class DeleteTaskEvent extends TasksEvent {
  final int id;

  DeleteTaskEvent(this.id);
}

final class RefreshTasksEvent extends TasksEvent {}

