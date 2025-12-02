import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks_app/core/router/app_route.dart';

import '../../core/space/app_space.dart';
import '../../core/space/space.dart';
import '../bloc/tasks_bloc.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Task Title"),
              Space.hSm,
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Task Title",
                  hintText: "Enter task title",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter a task title";
                  }
                  if (value.length < 3) {
                    return "Title must be at least 3 characters";
                  }
                  return null; // VALID
                },
              ),
              Space.hLg,
              const Text("Task Description"),
              Space.hSm,
              TextFormField(
                  controller: descriptionController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter task Description',
                    labelText: 'Task Description',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter a task Description";
                    }
                    return null; // VALID
                  }),
              Space.hXl,
              TextButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;

                      if (kDebugMode) {
                        print("Title: ${titleController.text}");
                        print("Description: ${descriptionController.text}");
                      }

                      context.read<TasksBloc>().add(AddTaskEvent(
                        title: titleController.text,
                        description: descriptionController.text,
                      ));

                      context.pop();
                  },
                  child: const Text("Add task"))
            ],
          ),
        ),
      ),
    );
  }
}
