import '../../../domain/entities/user_entity.dart';

sealed class AuthState {}

final class AuthInitialState extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthAuthenticated extends AuthState {
  final UserEntity user;
  AuthAuthenticated(this.user);
}

final class AuthUnauthenticatedState extends AuthState {}

final class AuthErrorState extends AuthState {
  final String message;

  AuthErrorState(this.message);
}