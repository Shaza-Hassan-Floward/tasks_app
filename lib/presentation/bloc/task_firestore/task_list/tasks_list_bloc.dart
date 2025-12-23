import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecase/tasks_firestore/fetch_tasks_usecase.dart';
import 'tasks_list_event.dart';
import 'tasks_list_status.dart';

class TasksListBloc extends Bloc<TasksListEvent, TasksListStatus> {
  final FetchTasksUseCase useCase;

  TasksListBloc({required this.useCase}) : super(TasksListInitial()) {
    on<LoadTasksListEvent>(_fetchTasks);
  }

  Future<void> _fetchTasks(
    LoadTasksListEvent event,
    Emitter<TasksListStatus> emit,
  ) async {
    emit(TasksListLoading());
    try {
      final tasks = await useCase();
      emit(TasksListLoaded(tasks));
    } catch (e) {
      emit(TasksListError(e.toString()));
    }
  }
}
