import '../../data/repository/task_repository_impl.dart';
import '../../domain/entities/task.dart';
import '../../domain/usecase/add_task_usecase.dart';

class AddTaskViewModel {
  final AddTaskUseCase addTaskUseCase;

  AddTaskViewModel() : addTaskUseCase = AddTaskUseCase(TaskRepositoryImpl());

  Future<void> addTask(
      {required String title, required String description}) async {
    final task = TaskEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      isCompleted: false,
    );
    await addTaskUseCase(task);
  }
}
