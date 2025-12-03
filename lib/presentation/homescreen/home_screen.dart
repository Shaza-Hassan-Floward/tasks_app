import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/space/space.dart';
import '../bloc/tasks_bloc.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TasksError) {
            return Center(child: Text(state.message));
          }
          if (state is TasksLoaded) {
            final tasks = state.tasks;

            if (tasks.isEmpty) {
              return const Center(child: Text("No tasks yet"));
            }

            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (_, index) {
                final task = tasks[index];
                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: InkWell(
                    onTap: () {
                      // context.go("/home/details", extra: task); // send whole object

                      // context.go("/home/details/${task.id}"); // navigate by id send in path

                      // context.goNamed(
                      //   "task-details",
                      //   pathParameters: {"id": task.id},
                      // ); // navigate by name and Id send in the path

                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: double.infinity, // Ensures full width tap area
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(task.title),
                          Space.hXs,
                          Text(task.description),
                        ],
                      ),
                    ),
                  ),
                );
              },
              
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: ()  {
          context.go("/home/add-task");
        },
      ),
    );
  }
}
