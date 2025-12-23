
import '../entities/task_firestore.dart';

abstract class TaskFireStoreRepository {
  Future<List<TaskFirestoreEntity>> fetchTasks();
  Future<TaskFirestoreEntity> getTaskById(String taskId);
  Future<TaskFirestoreEntity> addTask({
    required String title,
    String? description,
  });
  Future<TaskFirestoreEntity> updateTask(TaskFirestoreEntity task);
  Future<void> deleteTask(String taskId);
}