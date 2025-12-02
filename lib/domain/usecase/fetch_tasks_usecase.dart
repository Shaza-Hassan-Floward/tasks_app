import 'package:tasks_app/domain/entities/task.dart';

import '../repo/task_repository.dart';

class FetchTasksUseCase {
  final TaskRepository taskRepository;

  FetchTasksUseCase(this.taskRepository);

  Future<List<TaskEntity>> call() async {
    return await taskRepository.fetchTasks();
  }
}
