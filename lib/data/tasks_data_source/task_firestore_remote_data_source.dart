
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/task_firestore_model.dart';

abstract class TaskFirestoreRemoteDataSource {
  Future<List<TaskFirestoreModel>> fetchTasks();
  Future<TaskFirestoreModel> getTaskById(String taskId);
  Future<TaskFirestoreModel> addTask({
    required String title,
    String? description,
  });
  Future<TaskFirestoreModel> updateTask(TaskFirestoreModel task);
  Future<void> deleteTask(String taskId);
}

class TaskFirestoreRemoteDataSourceImpl
    implements TaskFirestoreRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  TaskFirestoreRemoteDataSourceImpl(
      this._firestore,
      this._auth,
      );

  CollectionReference<Map<String, dynamic>> get _tasksRef {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('User not authenticated');

    return _firestore
        .collection('users')
        .doc(uid)
        .collection('tasks');
  }

  @override
  Future<List<TaskFirestoreModel>> fetchTasks() async {
    final snapshot = await _tasksRef
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => TaskFirestoreModel.fromDoc(doc))
        .toList();
  }

  @override
  Future<TaskFirestoreModel> getTaskById(String taskId) async {
    final doc = await _tasksRef.doc(taskId).get();

    if (!doc.exists) {
      throw Exception('Task not found');
    }

    return TaskFirestoreModel.fromDoc(doc);
  }

  @override
  Future<TaskFirestoreModel> addTask({
    required String title,
    String? description,
  }) async {
    final docRef = _tasksRef.doc(); // 🔥 auto ID

    final model = TaskFirestoreModel(
      id: docRef.id,
      title: title,
      description: description,
      isCompleted: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await docRef.set(model.toJson());

    return model;
  }

  @override
  Future<TaskFirestoreModel> updateTask(TaskFirestoreModel task) async {
    await _tasksRef.doc(task.id).update({
      'title': task.title,
      'description': task.description,
      'isCompleted': task.isCompleted,
      'updatedAt': FieldValue.serverTimestamp(),
    });
    final model = TaskFirestoreModel(
      id: task.id,
      title: task.title,
      description: task.description,
      isCompleted: task.isCompleted,
      createdAt: task.updatedAt,
      updatedAt: DateTime.now(),
    );
    return model;
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await _tasksRef.doc(taskId).delete();
  }
}