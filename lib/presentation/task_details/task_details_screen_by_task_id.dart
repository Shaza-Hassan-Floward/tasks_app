
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/space/space.dart';
import '../bloc/tasks_bloc.dart';

class TaskDetailsScreenByTaskId extends StatefulWidget {
  final int taskId;

  const TaskDetailsScreenByTaskId({super.key, required this.taskId});

  @override
  State<TaskDetailsScreenByTaskId> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreenByTaskId> {
  @override
  void initState() {
    super.initState();

    // dispatch load
    context.read<TasksBloc>().add(LoadSingleTaskEvent(widget.taskId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task Details")),
      body: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TaskDetailError) {
            return Center(child: Text(state.message));
          }

          if (state is TaskDetailLoaded) {
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