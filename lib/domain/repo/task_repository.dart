import 'package:tasks_app/domain/entities/task.dart';

abstract class TaskRepository {
  Future<List<TaskEntity>> fetchTasks();
  Future<void> addTask(TaskEntity task);
  Future<void> updateTask(TaskEntity task);
  Future<void> deleteTask(TaskEntity task);
}
