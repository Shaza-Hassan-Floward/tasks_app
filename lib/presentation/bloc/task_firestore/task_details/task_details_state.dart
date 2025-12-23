
import '../../../../domain/entities/task_firestore.dart';

sealed class TaskDetailsState {
  const TaskDetailsState();
}

class TaskDetailsLoading extends TaskDetailsState {}
class TaskDetailsLoaded extends TaskDetailsState {
  final TaskFirestoreEntity task;
  const TaskDetailsLoaded(this.task);
}
class TaskDetailsError extends TaskDetailsState {
  final String message;
  const TaskDetailsError(this.message);
}