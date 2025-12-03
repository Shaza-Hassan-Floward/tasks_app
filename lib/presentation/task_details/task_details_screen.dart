
import 'package:flutter/material.dart';

import '../../core/space/space.dart';
import '../../domain/entities/task.dart';

class TaskDetailsScreen extends StatelessWidget {

  final TaskEntity taskEntity;
  const TaskDetailsScreen({super.key, required this.taskEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              taskEntity.title,
              style: Theme.of(context).textTheme.titleMedium
              ),
            Space.hMd,
            Text(
                taskEntity.description,
                style: Theme.of(context).textTheme.bodyMedium
            ),
          ],
        ),
      ),
    );
  }

}