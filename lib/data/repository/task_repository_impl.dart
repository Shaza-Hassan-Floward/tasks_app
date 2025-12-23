import '../../domain/entities/task.dart';
import '../../domain/error/failures.dart';
import '../../domain/repo/task_repository.dart';
import '../model/task_model.dart';
import '../tasks_data_source/tasks_remote_data_source.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TasksRemoteDataSource remote;

  TaskRepositoryImpl({required this.remote});

  List<TaskEntity>? _cache;

  @override
  Future<List<TaskEntity>> fetchTasks() async {
    try {
      final models = await remote.fetchTasks();
      _cache = models.map((e) => e.toEntity()).toList();
      return _cache!;
    } on Failure {
      rethrow;
    } catch (_) {
      throw const UnexpectedFailure('Unexpected repository error');
    }
  }

  @override
  Future<TaskEntity> getTask(int id) async {
    try {
      // optional cache lookup
      final cached = _cache?.firstWhere(
            (t) => t.id == id,
        orElse: () => null as TaskEntity,
      );
      if (cached != null) return cached;

      final model = await remote.getTask(id);
      final entity = model.toEntity();
      _cache = [..._cache ?? [], entity];
      return entity;
    } on Failure {
      rethrow;
    } catch (_) {
      throw const UnexpectedFailure('Unexpected repository error');
    }
  }

  @override
  Future<TaskEntity> addTask(TaskEntity task) async {
    try {
      final model = TaskModel.fromEntity(task);
      final created = await remote.addTask(model);
      final entity = created.toEntity();
      _cache = [..._cache ?? [], entity];
      return entity;
    } on Failure {
      rethrow;
    } catch (_) {
      throw const UnexpectedFailure('Unexpected repository error');
    }
  }

  @override
  Future<TaskEntity> updateTask(TaskEntity task) async {
    try {
      final model = TaskModel.fromEntity(task);
      final updated = await remote.updateTask(model);
      final entity = updated.toEntity();
      _cache = _cache
          ?.map((t) => t.id == entity.id ? entity : t)
          .toList();
      return entity;
    } on Failure {
      rethrow;
    } catch (_) {
      throw const UnexpectedFailure('Unexpected repository error');
    }
  }

  @override
  Future<void> deleteTask(int id) async {
    try {
      await remote.deleteTask(id);
      _cache = _cache?.where((t) => t.id != id).toList();
    } on Failure {
      rethrow;
    } catch (_) {
      throw const UnexpectedFailure('Unexpected repository error');
    }
  }
}