import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/task.dart';
import '../../../domain/error/failures.dart';
import '../../../domain/usecase/add_task_usecase.dart';
import '../../../domain/usecase/fetch_tasks_usecase.dart';

part 'tasks_list_event.dart';
part 'tasks_list_state.dart';

class TasksListBloc extends Bloc<TasksListEvent, TasksListState> {
  final FetchTasksUseCase fetchTasksUseCase;
  final AddTaskUseCase addTaskUseCase;

  TasksListBloc({
    required this.fetchTasksUseCase,
    required this.addTaskUseCase,
  }) : super(const TasksListLoading()) {
    on<LoadTasksListEvent>(_onLoad);
    on<AddTaskFromFormEvent>(_onAddTask);
  }

  Future<void> _onLoad(
      LoadTasksListEvent event,
      Emitter<TasksListState> emit,
      ) async {
    emit(const TasksListLoading());
    try {
      final tasks = await fetchTasksUseCase();
      emit(TasksListLoaded(tasks));
    } on Failure catch (f) {
      emit(TasksListError(f.message));
    } catch (_) {
      emit(const TasksListError('Unexpected error while loading tasks'));
    }
  }

  Future<void> _onAddTask(
      AddTaskFromFormEvent event,
      Emitter<TasksListState> emit,
      ) async {
    final current = state;
    if (current is! TasksListLoaded) {
      // if list not loaded, just try and reload everything
      try {
        final entity = await addTaskUseCase(event.toEntity());
        final tasks = await fetchTasksUseCase();
        emit(TasksListLoaded(tasks));
      } on Failure catch (f) {
        emit(TasksListError(f.message));
      } catch (_) {
        emit(const TasksListError('Unexpected error while adding task'));
      }
      return;
    }

    // keep old list visible, no loading spinner for add
    try {
      final created = await addTaskUseCase(event.toEntity());
      final updatedList = [...current.tasks, created];
      emit(TasksListLoaded(updatedList));
    } on Failure catch (f) {
      emit(TasksListError(f.message));
    } catch (_) {
      emit(const TasksListError('Unexpected error while adding task'));
    }
  }
}