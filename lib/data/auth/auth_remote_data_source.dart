import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user_entity.dart';

class AuthRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSource(this.auth, this.firestore);

  Future<UserEntity> signUp({
    required String name,
    required String email,
    required String password,
    required String gender,
    required DateTime birthDate,
  }) async {

    final cred = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = cred.user!.uid;

    await firestore.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'gender': gender,
      'birthDate': birthDate.toIso8601String(),
      'createdAt': FieldValue.serverTimestamp(),
    });

    return UserEntity(
      id: uid,
      name: name,
      email: email,
      gender: gender,
      birthDate: birthDate,
    );
  }

  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final cred = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = cred.user!.uid;

    final doc = await firestore.collection('users').doc(uid).get();
    final data = doc.data()!;

    return UserEntity(
      id: uid,
      name: data['name'],
      email: data['email'],
      gender:data['gender'],
      birthDate: DateTime.parse(data['birthDate'])
    );
  }

  Future<void> logout() async {
    await auth.signOut();
  }

}