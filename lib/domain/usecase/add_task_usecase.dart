import 'package:tasks_app/domain/entities/task.dart';

import '../repo/task_repository.dart';

class AddTaskUseCase {
  final TaskRepository repository;

  AddTaskUseCase(this.repository);

  Future<TaskEntity> call(TaskEntity task) {
    return repository.addTask(task);
  }
}