
import '../../../../domain/entities/task_firestore.dart';

sealed class UpdateTaskEvent {
  const UpdateTaskEvent();
}

class SubmitUpdateTaskEvent extends UpdateTaskEvent {
  final TaskFirestoreEntity task;
  const SubmitUpdateTaskEvent(this.task);
}