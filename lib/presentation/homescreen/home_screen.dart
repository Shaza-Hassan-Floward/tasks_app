import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/space/space.dart';
import '../../data/repository/task_repository_impl.dart';
import '../../domain/entities/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final repo = TaskRepositoryImpl();
  List<TaskEntity> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    tasks = await repo.fetchTasks();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (_, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tasks[index].title),
                  Space.hSm,
                  Text(tasks[index].description)
                ],
              )),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          context.go("/home/add-task");
          loadTasks(); // refresh after returning
        },
      ),
    );
  }
}
