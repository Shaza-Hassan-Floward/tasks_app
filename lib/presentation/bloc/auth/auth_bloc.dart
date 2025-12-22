import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecase/login_usecase.dart';
import '../../../domain/usecase/logout_usecase.dart';
import '../../../domain/usecase/sign_up_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase signUpUseCase;
  final LogoutUseCase logoutUseCase;
  final LoginUseCase loginUseCase;

  AuthBloc({
    required this.signUpUseCase,
    required this.logoutUseCase,
    required this.loginUseCase,
  }) : super(AuthInitialState()) {
    on<AuthSignupEvent>(_onSignUp);
    on<AuthLogoutEvent>(_onLogout);
    on<AuthLoginEvent>(_login);
  }

  Future<void> _onSignUp(
    AuthSignupEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    try {
      emit(AuthLoadingState());
      final user = await signUpUseCase(
          name: event.username,
          email: event.email,
          password: event.password,
          gender: event.gender,
          birthDate: event.birthDate);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> _login(
    AuthLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    try {
      final user = await loginUseCase(
        email: event.email,
        password: event.password,
      );
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> _onLogout(
    AuthLogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    await logoutUseCase();
    emit(AuthUnauthenticatedState());
  }


}
