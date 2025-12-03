
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/task.dart';
import '../../domain/usecase/add_task_usecase.dart';
import '../../domain/usecase/fetch_tasks_usecase.dart';
import '../../domain/usecase/update_task_usecase.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final AddTaskUseCase addTaskUseCase;
  final FetchTasksUseCase fetchTasksUseCase;
  final UpdateTaskUseCase updateTaskUseCase;

  TasksBloc({
    required this.addTaskUseCase,
    required this.fetchTasksUseCase,
    required this.updateTaskUseCase,
  }) : super(const TasksInitial()) {
    on<LoadTasksEvent>(_onLoadTasks);
    on<AddTaskEvent>(_onAddTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<LoadSingleTaskEvent>(_onLoadSingleTask);
  }

  Future<void> _onLoadTasks(
      LoadTasksEvent event, Emitter<TasksState> emit) async {
    emit(const Loading());
    try {
      final tasks = await fetchTasksUseCase();
      await Future.delayed(const Duration(seconds: 1));
      emit(TasksLoaded(tasks));
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }

  Future<void> _onAddTask(
      AddTaskEvent event, Emitter<TasksState> emit) async {
    emit(const Loading());
    try {
      await addTaskUseCase(event.task);
      await Future.delayed(const Duration(seconds: 1));
      final updatedTasks = await fetchTasksUseCase();
      await Future.delayed(const Duration(seconds: 1));
      emit(TasksLoaded(updatedTasks));
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }

  Future<void> _onUpdateTask(
      UpdateTaskEvent event, Emitter<TasksState> emit) async {
    emit(const Loading());
    try {
      await updateTaskUseCase(event.task);
      await Future.delayed(const Duration(seconds: 1));
      final updatedTasks = await fetchTasksUseCase();
      await Future.delayed(const Duration(seconds: 1));
      emit(TasksLoaded(updatedTasks));
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }

  Future<void> _onLoadSingleTask(
      LoadSingleTaskEvent event,
      Emitter<TasksState> emit,
      ) async {
    emit(const Loading());

    try {
      // Option A — if repository has fetchById()
      // final task = await fetchSingleTaskUseCase(event.id);

      // Option B — reuse all tasks (local only)
      final all = await fetchTasksUseCase();
      final task = all.firstWhere((t) => t.id == event.id);

      emit(TaskDetailLoaded(task));
    } catch (e) {
      emit(TaskDetailError(e.toString()));
    }
  }
}