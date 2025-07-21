import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';
import '../services/auth_service.dart';
import '../cubit/wishlist_cubit.dart';
import '../cubit/cart_cubit.dart';
import '../utils/cache_helper.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService authService;
  final CartCubit cartCubit;
  final WishlistCubit wishlistCubit;

  AuthCubit(this.authService, this.cartCubit, this.wishlistCubit) : super(AuthInitial());

  void login(String email, String password) async {
    try {
      emit(AuthLoading());
      final userId = await authService.loginUser(email, password);
      cartCubit.loadCartForUser(userId);

      emit(AuthSuccess());
      print('User ID: $userId');
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
    cartCubit.removeCartData(removeCache: false);
    wishlistCubit.clearWishlist();

    emit(AuthInitial());
  }
}