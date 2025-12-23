import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecase/tasks_firestore/add_task_usecase.dart';
import 'task_add_event.dart';
import 'task_add_state.dart';

class CreateTaskBloc extends Bloc<CreateTaskEvent, CreateTaskState> {
  final AddTaskUseCase addTaskUseCase;

  CreateTaskBloc({required this.addTaskUseCase})
      : super(CreateTaskInitial()) {
    on<SubmitCreateTaskEvent>(_onSubmit);
  }

  Future<void> _onSubmit(
      SubmitCreateTaskEvent event,
      Emitter<CreateTaskState> emit,
      ) async {
    emit(CreateTaskLoading());
    try {
      await addTaskUseCase(
          title: event.title,
          description: event.description,
      );
      emit(CreateTaskSuccess());
    } catch (e) {
      emit(CreateTaskError(e.toString()));
    }
  }
}