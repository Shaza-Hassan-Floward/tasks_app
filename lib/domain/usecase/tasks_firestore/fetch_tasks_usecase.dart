
import '../../entities/task_firestore.dart';
import '../../repo/task_firestore_repository.dart';

class FetchTasksUseCase {

  final TaskFireStoreRepository _repository;

  FetchTasksUseCase(this._repository);

  Future<List<TaskFirestoreEntity>> call() {
    return _repository.fetchTasks();
  }
}