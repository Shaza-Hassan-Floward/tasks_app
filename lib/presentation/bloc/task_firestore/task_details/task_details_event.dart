sealed class TaskDetailsEvent {
  const TaskDetailsEvent();
}

class LoadTaskDetailsEvent extends TaskDetailsEvent {
  final String taskId;
  const LoadTaskDetailsEvent(this.taskId);
}