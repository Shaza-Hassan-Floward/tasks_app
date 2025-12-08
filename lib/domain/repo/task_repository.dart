import '../entities/task.dart';

abstract class TaskRepository {
  Future<List<TaskEntity>> fetchTasks();
  Future<TaskEntity> getTask(int id);
  Future<TaskEntity> addTask(TaskEntity task);
  Future<TaskEntity> updateTask(TaskEntity task);
  Future<void> deleteTask(int id);
}