import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/task.dart';
import '../../../domain/error/failures.dart';
import '../../../domain/usecase/get_task_usecase.dart';

part 'task_details_event.dart';
part 'task_details_state.dart';

class TaskDetailsBloc extends Bloc<TaskDetailsEvent, TaskDetailsState> {
  final GetTaskUseCase getTaskUseCase;

  TaskDetailsBloc(this.getTaskUseCase) : super(const TaskDetailsLoading()) {
    on<LoadTaskDetailsEvent>(_onLoad);
  }

  Future<void> _onLoad(
      LoadTaskDetailsEvent event,
      Emitter<TaskDetailsState> emit,
      ) async {
    emit(const TaskDetailsLoading());
    try {
      final task = await getTaskUseCase(event.id);
      emit(TaskDetailsLoaded(task));
    } on Failure catch (f) {
      emit(TaskDetailsError(f.message));
    } catch (_) {
      emit(const TaskDetailsError('Unexpected error while loading task'));
    }
  }
}