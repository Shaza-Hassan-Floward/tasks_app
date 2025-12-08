
import 'package:dio/dio.dart';

import '../model/task_model.dart';

class TasksRemoteDataSource {
  final Dio dio;

  TasksRemoteDataSource(this.dio);

  Future<List<TaskModel>> fetchTasks() async {
    final response = await dio.get('/todos');
    final list = response.data["todos"] as List;
    return list.map((json) => TaskModel.fromJson(json)).toList();
  }

  Future<TaskModel> getTask(int id) async {
    final res = await dio.get("/todos/$id");
    return TaskModel.fromJson(res.data);
  }

  Future<TaskModel> addTask(TaskModel task) async {
    final res = await dio.post("/todos/add", data: task.toJson());
    return TaskModel.fromJson(res.data);
  }

  Future<TaskModel> updateTask(TaskModel task) async {
    final res = await dio.put("/todos/${task.id}", data: task.toJson());
    return TaskModel.fromJson(res.data);
  }

  Future<void> deleteTask(int id) async {
    await dio.delete("/todos/$id");
  }

}