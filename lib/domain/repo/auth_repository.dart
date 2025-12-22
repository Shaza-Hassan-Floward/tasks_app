import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signUp({
    required String name,
    required String email,
    required String password,
    required String gender,
    required DateTime birthDate,
  });

  Future<void> logout();

  Future<UserEntity> login({
    required String email,
    required String password,
  });
}