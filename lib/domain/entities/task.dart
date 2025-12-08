class TaskEntity {
  final int id;            // DummyJSON uses int IDs
  final String title;      // maps from "todo"
  final String? description; // optional for your UI
  final bool isCompleted;
  final int userId;

  const TaskEntity({
    required this.id,
    required this.title,
    this.description,
    required this.isCompleted,
    required this.userId,
  });

  TaskEntity copyWith({
    int? id,
    String? title,
    String? description,
    bool? isCompleted,
    int? userId,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      userId: userId ?? this.userId,
    );
  }
}