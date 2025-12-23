import 'package:flutter_bloc/flutter_bloc.dart';

import 'update_task_event.dart';
import 'update_task_state.dart';

class UpdateTaskBloc extends Bloc<UpdateTaskEvent, UpdateTaskState> {
  final UpdateTaskUseCase updateTaskUseCase;

  UpdateTaskBloc(this.updateTaskUseCase)
      : super(UpdateTaskInitial()) {
    on<SubmitUpdateTaskEvent>(_onSubmit);
  }

  Future<void> _onSubmit(
      SubmitUpdateTaskEvent event,
      Emitter<UpdateTaskState> emit,
      ) async {
    emit(UpdateTaskLoading());
    try {
      await updateTaskUseCase(event.task);
      emit(UpdateTaskSuccess());
    } catch (e) {
      emit(UpdateTaskError(e.toString()));
    }
  }
}