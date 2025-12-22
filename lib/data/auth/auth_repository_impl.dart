

import 'package:tasks_app/domain/entities/user_entity.dart';

import '../../domain/repo/auth_repository.dart';
import 'auth_remote_data_source.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity> signUp({required String name, required String email, required String password, required String gender, required DateTime birthDate}) {
    return remoteDataSource.signUp(
      name: name,
      email: email,
      password: password,
      gender: gender,
      birthDate: birthDate,
    );
  }

  @override
  Future<UserEntity> login({required String email, required String password}) {
    return remoteDataSource.login(email: email, password: password);
  }

  @override
  Future<void> logout() async {
    return remoteDataSource.logout();
  }

}