import 'package:tasks_app/data/local_task_storage.dart';

import '../../domain/entities/task.dart';
import '../../domain/repo/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  @override
  Future<void> addTask(TaskEntity task) async {
    LocalTaskStorage.tasks.add(task);
  }

  @override
  Future<void> deleteTask(TaskEntity task) async {
    LocalTaskStorage.tasks.remove(task);
  }

  @override
  Future<List<TaskEntity>> fetchTasks() async {
    return LocalTaskStorage.tasks;
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    final index = LocalTaskStorage.tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      LocalTaskStorage.tasks[index] = task;
    }
  }
}
