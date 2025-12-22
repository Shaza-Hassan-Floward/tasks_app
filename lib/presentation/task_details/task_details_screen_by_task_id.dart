
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/space/space.dart';
import '../bloc/task_details/task_details_bloc.dart';

class TaskDetailsScreenByTaskId extends StatelessWidget {
  final int taskId;

  const TaskDetailsScreenByTaskId({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task Details")),
      body: BlocBuilder<TaskDetailsBloc, TaskDetailsState>(
        builder: (context, state) {
          if (state is TaskDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TaskDetailsError) {
            return Center(child: Text(state.message));
          }

          if (state is TaskDetailsLoaded) {
            final task = state.task;

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.title, style: Theme.of(context).textTheme.titleLarge),
                  Space.hMd,
                  Text(task.description ?? "", style: Theme.of(context).textTheme.bodyMedium),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      // future: add edit page
                    },
                    child: const Text("Edit task"),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}