import '../../domain/entities/task.dart';
import '../../domain/repo/task_repository.dart';
import '../data_source/tasks_remote_data_source.dart';
import '../model/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TasksRemoteDataSource remote;

  TaskRepositoryImpl({required this.remote});

  @override
  Future<List<TaskEntity>> fetchTasks() async {
    final models = await remote.fetchTasks();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<TaskEntity> getTask(int id) async {
    final model = await remote.getTask(id);
    return model.toEntity();
  }

  @override
  Future<TaskEntity> addTask(TaskEntity task) async {
    final model = TaskModel.fromEntity(task);
    final created = await remote.addTask(model);
    return created.toEntity();
  }

  @override
  Future<TaskEntity> updateTask(TaskEntity task) async {
    final model = TaskModel.fromEntity(task);
    final updated = await remote.updateTask(model);
    return updated.toEntity();
  }

  @override
  Future<void> deleteTask(int id) async {
    await remote.deleteTask(id);
  }
}