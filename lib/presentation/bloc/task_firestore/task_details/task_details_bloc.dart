import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecase/tasks_firestore/fetch_task_usecase.dart';
import 'task_details_event.dart';
import 'task_details_state.dart';

class TaskDetailsBloc extends Bloc<TaskDetailsEvent, TaskDetailsState> {
  final FetchTaskUseCase getTaskUseCase;

  TaskDetailsBloc(this.getTaskUseCase)
      : super(TaskDetailsLoading()) {
    on<LoadTaskDetailsEvent>(_onLoad);
  }

  Future<void> _onLoad(
      LoadTaskDetailsEvent event,
      Emitter<TaskDetailsState> emit,
      ) async {
    emit(TaskDetailsLoading());
    try {
      final task = await getTaskUseCase(event.taskId);
      emit(TaskDetailsLoaded(task));
    } catch (e) {
      emit(TaskDetailsError(e.toString()));
    }
  }
}