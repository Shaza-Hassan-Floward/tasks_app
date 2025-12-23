import '../../entities/task_firestore.dart';
import '../../repo/task_firestore_repository.dart';

class FetchTaskUseCase {
  final TaskFireStoreRepository repository;

  FetchTaskUseCase(this.repository);

  Future<TaskFirestoreEntity> call(String id) {
    return repository.getTaskById(id);
  }
}