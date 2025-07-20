import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';
import '../services/auth_service.dart';
import '../cubit/wishlist_cubit.dart';
import '../utils/cache_helper.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService authService;

  AuthCubit(this.authService) : super(AuthInitial());

  void login(String email, String password) async {
    emit(AuthLoading());
    try {
      await authService.loginUser(email, password);
      emit(AuthSuccess());
      print('User ID: ${CacheHelper.getString(key: 'userId')}');
      print('Token: ${CacheHelper.getString(key: 'token')}');
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

 void logout() async {
    await CacheHelper.clearUser();
    emit(AuthInitial());
  }

}
