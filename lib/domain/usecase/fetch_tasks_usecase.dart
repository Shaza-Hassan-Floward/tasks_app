import 'package:tasks_app/domain/entities/task.dart';

import '../repo/task_repository.dart';

class FetchTasksUseCase {
  final TaskRepository repository;

  FetchTasksUseCase(this.repository);

  Future<List<TaskEntity>> call() {
    return repository.fetchTasks();
  }
}