import 'package:cartverse/utils/route_names.dart';
import 'package:flutter/material.dart';

import '../view/home_page.dart';
import '../view/login_page.dart';
import '../view/signup_page.dart';


class CustomRouter {
  static Route<dynamic>? allRoutes(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const HomePage());
      case registerScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const RegisterPage());
      case loginScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const LoginPage());
      default:
        return null;
    }
  }
}