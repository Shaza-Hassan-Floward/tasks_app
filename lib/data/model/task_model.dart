import '../../domain/entities/task.dart';

class TaskModel {
  final int id;
  final String todo;
  final bool completed;
  final int userId;

  TaskModel({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as int,
      todo: json['todo'] as String,
      completed: json['completed'] as bool,
      userId: json['userId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'todo': todo,
      'completed': completed,
      'userId': userId,
    };
  }

  TaskEntity toEntity() {
    return TaskEntity(
      id: id,
      title: todo,
      description: todo, // or null, or custom
      isCompleted: completed,
      userId: userId,
    );
  }

  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      todo: entity.title,
      completed: entity.isCompleted,
      userId: entity.userId,
    );
  }
}