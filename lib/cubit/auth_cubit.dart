import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';
import '../services/auth_service.dart';
import '../services/user_session.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService authService;

  AuthCubit(this.authService) : super(AuthInitial());

  void login(String email, String password) async {
    emit(AuthLoading());
    try {
      final response = await authService.login(email, password);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final user = data['user'] ?? {};
        await UserSession.saveUser(
          firstName: user['firstName'] ?? '',
          lastName: user['lastName'] ?? '',
          token: data['accessToken'] ?? '',
        );
        emit(AuthSuccess());
      } else {
        emit(AuthFailure('Login failed: Check credentials.'));
      }
    } catch (e) {
      emit(AuthFailure('Login error: $e'));
    }
  }

  void register(String firstName, String lastName, String email, String password) async {
    emit(AuthLoading());
    try {
      final response = await authService.register(firstName, lastName, email, password);

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure('Register failed: ${response.body}'));
      }
    } catch (e) {
      emit(AuthFailure('Register error: $e'));
    }
  }
}
