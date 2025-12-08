
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/task.dart';
import '../../domain/usecase/add_task_usecase.dart';
import '../../domain/usecase/delete_task_usecase.dart';
import '../../domain/usecase/fetch_tasks_usecase.dart';
import '../../domain/usecase/get_task_usecase.dart';
import '../../domain/usecase/update_task_usecase.dart';


part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final FetchTasksUseCase fetchTasksUseCase;
  final GetTaskUseCase getTaskUseCase;
  final AddTaskUseCase addTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;

  TasksBloc({
    required this.fetchTasksUseCase,
    required this.getTaskUseCase,
    required this.addTaskUseCase,
    required this.updateTaskUseCase,
    required this.deleteTaskUseCase,
  }) : super(const TasksInitial()) {
    on<LoadTasksEvent>(_onLoadTasks);
    on<RefreshTasksEvent>(_onRefreshTasks);
    on<LoadSingleTaskEvent>(_onLoadTaskDetails);
    on<AddTaskEvent>(_onAddTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
  }

  Future<void> _onLoadTasks(
      LoadTasksEvent event,
      Emitter<TasksState> emit,
      ) async {
    emit(const Loading());
    try {
      final tasks = await fetchTasksUseCase();
      emit(TasksLoaded(tasks));
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }

  Future<void> _onRefreshTasks(
      RefreshTasksEvent event,
      Emitter<TasksState> emit,
      ) async {
    try {
      final tasks = await fetchTasksUseCase();
      emit(TasksLoaded(tasks));
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }

  Future<void> _onLoadTaskDetails(
      LoadSingleTaskEvent event,
      Emitter<TasksState> emit,
      ) async {
    emit(const Loading());
    try {
      final task = await getTaskUseCase(event.id);
      emit(TaskDetailLoaded(task));
    } catch (e) {
      emit(TaskDetailError(e.toString()));
    }
  }

  Future<void> _onAddTask(
      AddTaskEvent event,
      Emitter<TasksState> emit,
      ) async {
    emit(const Loading());
    try {
      final created = await addTaskUseCase(event.task);
      final tasks = await fetchTasksUseCase();
      emit(TasksLoaded(tasks));
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }

  Future<void> _onUpdateTask(
      UpdateTaskEvent event,
      Emitter<TasksState> emit,
      ) async {
    emit(const Loading());
    try {
      final updated = await updateTaskUseCase(event.task);
      final tasks = await fetchTasksUseCase();
      emit(TasksLoaded(tasks));
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }

  Future<void> _onDeleteTask(
      DeleteTaskEvent event,
      Emitter<TasksState> emit,
      ) async {
    emit(const Loading());
    try {
      await deleteTaskUseCase(event.id);
      final tasks = await fetchTasksUseCase();
      emit(TasksLoaded(tasks));
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }
}