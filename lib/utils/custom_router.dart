import 'package:flutter/material.dart';

import '../utils/route_names.dart';
import '../view/home_page.dart';
import '../view/login_page.dart';
import '../view/signup_page.dart';
import '../view/categories_page.dart';
import '../view/about_page.dart';
import '../view/contact_page.dart';
import '../view/wishlist_page.dart';
import '../view/cart_page.dart';
import '../view/profile_page.dart';

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
      case categoriesScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => CategoriesPage());
      case aboutScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AboutPage());
      case contactScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ContactPage());
      case wishlistScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const WishlistPage());
      case cartScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const CartPage());
      case profilePage:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ProfilePage());
      default:
        return null;
    }
  }
}