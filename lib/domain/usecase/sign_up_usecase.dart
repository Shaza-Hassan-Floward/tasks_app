import '../entities/user_entity.dart';
import '../repo/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository _repository;

  SignUpUseCase(this._repository);

  Future<UserEntity> call({
    required String name,
    required String email,
    required String password,
    required String gender,
    required DateTime birthDate,
  }) {
    return _repository.signUp(
      name: name,
      email: email,
      password: password,
      gender: gender,
      birthDate: birthDate,
    );
  }
}
