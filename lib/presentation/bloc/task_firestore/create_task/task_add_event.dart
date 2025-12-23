sealed class CreateTaskEvent {
  const CreateTaskEvent();
}

class SubmitCreateTaskEvent extends CreateTaskEvent {
  final String title;
  final String description;

  const SubmitCreateTaskEvent({
    required this.title,
    required this.description,
  });
}