import '../entities/task.dart';
import '../repo/task_repository.dart';

class GetTaskUseCase {
  final TaskRepository repository;

  GetTaskUseCase(this.repository);

  Future<TaskEntity> call(int id) {
    return repository.getTask(id);
  }
}