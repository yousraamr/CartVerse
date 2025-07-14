import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
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
      tr('categories'):  CategoriesPage(),
      tr('about'): const AboutPage(),
      tr('contact'): const ContactPage(),
      if (!isLoggedIn) tr('login'): const LoginPage(),
      if (!isLoggedIn) tr('register'): const RegisterPage(),
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
              title: Text('logout'.tr(), style: const TextStyle(color: Colors.red)),
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
            title: Text('dark_mode'.tr()),
            trailing: Switch(
              value: isDark,
              onChanged: (val) {
                themeCubit.toggleTheme();
              },
            ),
          ),
          ListTile(
            title: const Text("🇬🇧 English"),
            onTap: () => context.setLocale(const Locale('en')),
          ),
          ListTile(
            title: const Text("🇪🇬 العربية"),
            onTap: () => context.setLocale(const Locale('ar')),
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
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'app_title'.tr(),
                  style: const TextStyle(
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
