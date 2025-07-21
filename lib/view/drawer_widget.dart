import 'package:cartverse/view/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../cubit/theme_cubit.dart';
import '../cubit/wishlist_cubit.dart';
import '../cubit/cart_cubit.dart';
import '../services/user_session.dart';
import '../utils/cache_helper.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'categories_page.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'signup_page.dart';
import 'about_page.dart';
import 'contact_page.dart';
import 'wishlist_page.dart';
import 'cart_page.dart';
import 'orders_page.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool isLoggedIn = false;
  Locale _selectedLocale = const Locale('en'); // Default language

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectedLocale = context.locale;
  }

  Future<void> checkLoginStatus() async {
    final user = await UserSession.getUser();
    setState(() {
      isLoggedIn = user['token'] != null && user['token']!.isNotEmpty;
    });
  }

    @override
    Widget build(BuildContext context) {
      final themeCubit = context.read<ThemeCubit>();
      final isDark = context.watch<ThemeCubit>().state == ThemeMode.dark;

      return Drawer(
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            bool isLoggedIn = state is AuthSuccess;

            final routes = <String, Widget>{
              tr('categories'): CategoriesPage(),
              tr('about'): const AboutPage(),
              tr('contact'): const ContactPage(),
              tr('wishlist'): const WishlistPage(),
              tr('cart'): const CartPage(),
              if (isLoggedIn) tr('profile'): const ProfilePage(),
              if (isLoggedIn) tr('orders'): const OrdersPage(),
              if (!isLoggedIn) tr('login'): const LoginPage(),
              if (!isLoggedIn) tr('register'): const RegisterPage(),
            };

            return ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 30),

                ...routes.entries.map((entry) => ListTile(
                  title: Text(entry.key),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => entry.value),
                    );
                  },
                )),

                if (isLoggedIn) const Divider(),
                if (isLoggedIn)
                  ListTile(
                    title: Text('logout'.tr(), style: const TextStyle(color: Colors.red)),
                    onTap: () {
                      context.read<AuthCubit>().logout();
                      context.read<WishlistCubit>().clearWishlist();
                      context.read<CartCubit>().removeCartData(removeCache: false);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const HomePage()),
                            (route) => false,
                      );
                    },
                  ),

                const Divider(),
                ListTile(
                  title: Text('dark_mode'.tr()),
                  trailing: Switch(
                    value: isDark,
                    onChanged: (val) {
                      themeCubit.toggleTheme();
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: DropdownButton<Locale>(
                    value: _selectedLocale,
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                    items: const [
                      DropdownMenuItem(
                        value: Locale('en'),
                        child: Text("🇬🇧 English"),
                      ),
                      DropdownMenuItem(
                        value: Locale('ar'),
                        child: Text("🇪🇬 العربية"),
                      ),
                    ],
                    onChanged: (locale) {
                      if (locale != null) {
                        setState(() {
                          _selectedLocale = locale;
                        });
                        context.setLocale(locale);
                      }
                    },
                  ),
                ),

                const SizedBox(height: 30), //

                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const HomePage()),
                            (route) => false,
                      );
                    },
                    child: const Text(
                      "CartVerse",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

              ],
            );
          },
        ),
      );
    }

  }

