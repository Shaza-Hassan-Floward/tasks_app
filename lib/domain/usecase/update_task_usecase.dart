
import '../repo/task_repository.dart';

class UpdateTaskUseCase {
  final TaskRepository taskRepository;

  UpdateTaskUseCase(this.taskRepository);

  Future<void> call(task) async {
    await taskRepository.updateTask(task);
  }

}