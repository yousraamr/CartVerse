import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/cache_helper.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light) {
    _loadTheme();
  }

  void _loadTheme() async {
    final isDark = CacheHelper.getBool(key: 'isDark') ?? false;
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleTheme() async {
    final isDarkNow = state == ThemeMode.light;
    emit(isDarkNow ? ThemeMode.dark : ThemeMode.light);
    await CacheHelper.saveBool(key: 'isDark', value: isDarkNow);
  }
}
