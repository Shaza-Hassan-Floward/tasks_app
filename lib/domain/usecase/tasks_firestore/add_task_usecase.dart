
import '../../entities/task_firestore.dart';
import '../../repo/task_firestore_repository.dart';

class AddTaskUseCase {
  final TaskFireStoreRepository repository;

  AddTaskUseCase(this.repository);

  Future<TaskFirestoreEntity> call({required String title, String? description}) {
    return repository.addTask(title: title, description: description);
  }
}