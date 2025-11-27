import 'package:tasks_app/domain/entities/task.dart';

import '../repo/task_repository.dart';

class AddTaskUseCase {
  final TaskRepository taskRepository;

  AddTaskUseCase(this.taskRepository);

  Future<void> call(TaskEntity task) async {
    await taskRepository.addTask(task);
  }
}
