import 'package:dio/dio.dart';
import '../../domain/error/failures.dart';
import '../error/dio_failure_mapper.dart';
import '../model/task_model.dart';

class TasksRemoteDataSource {
  final Dio dio;

  TasksRemoteDataSource(this.dio);

  Future<List<TaskModel>> fetchTasks() async {
    try {
      final res = await dio.get('/todos');
      final list = res.data['todos'] as List<dynamic>;
      return list.map((e) => TaskModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw mapDioErrorToFailure(e);
    } catch (_) {
      throw const UnexpectedFailure('Unknown error while fetching tasks');
    }
  }

  Future<TaskModel> getTask(int id) async {
    try {
      final res = await dio.get('/todos/$id');
      return TaskModel.fromJson(res.data);
    } on DioException catch (e) {
      throw mapDioErrorToFailure(e);
    } catch (_) {
      throw const UnexpectedFailure('Unknown error while getting task');
    }
  }

  Future<TaskModel> addTask(TaskModel task) async {
    try {
      final res = await dio.post('/todos/add', data: task.toJson());
      return TaskModel.fromJson(res.data);
    } on DioException catch (e) {
      throw mapDioErrorToFailure(e);
    } catch (_) {
      throw const UnexpectedFailure('Unknown error while adding task');
    }
  }

  Future<TaskModel> updateTask(TaskModel task) async {
    try {
      final res = await dio.put('/todos/${task.id}', data: task.toJson());
      return TaskModel.fromJson(res.data);
    } on DioException catch (e) {
      throw mapDioErrorToFailure(e);
    } catch (_) {
      throw const UnexpectedFailure('Unknown error while updating task');
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      await dio.delete('/todos/$id');
    } on DioException catch (e) {
      throw mapDioErrorToFailure(e);
    } catch (_) {
      throw const UnexpectedFailure('Unknown error while deleting task');
    }
  }
}