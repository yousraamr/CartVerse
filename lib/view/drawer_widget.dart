import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/theme_cubit.dart';
import '../services/user_session.dart';
import 'categories_page.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'signup_page.dart';
import 'about_page.dart';
import 'contact_page.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final user = await UserSession.getUser();
    setState(() {
      isLoggedIn = user['token'] != null && user['token']!.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final routes = <String, Widget>{
      'Categories': const CategoriesPage(),
      'About': const AboutPage(),
      'Contact': const ContactPage(),
      if (!isLoggedIn) 'Login': const LoginPage(),
      if (!isLoggedIn) 'Register': const RegisterPage(),
    };

    final themeCubit = context.read<ThemeCubit>();
    final isDark = context.watch<ThemeCubit>().state == ThemeMode.dark;

    return Drawer(
      child: ListView(
        children: [
          ...routes.entries.map(
                (entry) => ListTile(
              title: Text(entry.key),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => entry.value),
                );
              },
            ),
          ),
          if (isLoggedIn) const Divider(),
          if (isLoggedIn)
            ListTile(
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () async {
                Navigator.pop(context);
                await UserSession.clearUser();
                setState(() => isLoggedIn = false);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                      (route) => false,
                );
              },
            ),
          const Divider(),
          ListTile(
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: isDark,
              onChanged: (val) {
                themeCubit.toggleTheme();
              },
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
            child: const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'CartVerse',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
