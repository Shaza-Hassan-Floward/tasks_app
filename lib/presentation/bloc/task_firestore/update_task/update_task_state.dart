sealed class UpdateTaskState {
  const UpdateTaskState();
}

class UpdateTaskInitial extends UpdateTaskState {}
class UpdateTaskLoading extends UpdateTaskState {}
class UpdateTaskSuccess extends UpdateTaskState {}
class UpdateTaskError extends UpdateTaskState {
  final String message;
  const UpdateTaskError(this.message);
}