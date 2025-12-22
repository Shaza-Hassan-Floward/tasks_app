sealed class AuthEvent {}

final class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  AuthLoginEvent(this.email, this.password);
}

final class AuthLogoutEvent extends AuthEvent {}

final class AuthSignupEvent extends AuthEvent {
  final String username;
  final String password;
  final String email;
  final String gender;
  final DateTime birthDate;

  AuthSignupEvent({required this.username, required this.password, required this.email, required this.gender, required this.birthDate});
}