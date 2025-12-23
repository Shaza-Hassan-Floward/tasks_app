
import 'package:tasks_app/domain/entities/task_firestore.dart';

import '../../domain/repo/task_firestore_repository.dart';
import '../model/task_firestore_model.dart';
import '../tasks_data_source/task_firestore_remote_data_source.dart';

class TaskFirestoreRepositoryImpl  extends TaskFireStoreRepository {

  final TaskFirestoreRemoteDataSource _dataSource;
  TaskFirestoreRepositoryImpl(this._dataSource);

  @override
  Future<TaskFirestoreEntity> addTask({required String title, String? description}) async {
    final task = await _dataSource.addTask(title: title, description: description);
    return _toEntity(task);
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await _dataSource.deleteTask(taskId);
  }

  @override
  Future<List<TaskFirestoreEntity>> fetchTasks() async {
    final tasks = await _dataSource.fetchTasks();

    return tasks.map((model) => _toEntity(model)).toList();
  }

  @override
  Future<TaskFirestoreEntity> getTaskById(String taskId) async {
    // TODO: implement getTaskById
    return await _dataSource.getTaskById(taskId).then((model) => _toEntity(model));
  }

  @override
  Future<TaskFirestoreEntity> updateTask(TaskFirestoreEntity task) async {
    final updatedTask = await _dataSource.updateTask(_toModel(task));
    return _toEntity(updatedTask);
  }

  TaskFirestoreEntity _toEntity(TaskFirestoreModel model) {
    return TaskFirestoreEntity(
      id: model.id,
      title: model.title,
      description: model.description,
      isCompleted: model.isCompleted,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt
    );
  }

  TaskFirestoreModel _toModel(TaskFirestoreEntity entity) {
    return TaskFirestoreModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      isCompleted: entity.isCompleted,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt
    );
  }
}