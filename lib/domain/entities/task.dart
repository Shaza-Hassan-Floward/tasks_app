class TaskEntity {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime? dueDate;
  final TaskPriority priority;
  final bool hasDueDate;

  TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.dueDate,
    this.priority = TaskPriority.medium,
    this.hasDueDate = false,
  });
}

enum TaskPriority { low, medium, high }
