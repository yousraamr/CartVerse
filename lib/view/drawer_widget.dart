import 'package:flutter/material.dart';
import '../services/user_session.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'signup_page.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  static final Map<String, Widget> routes = {
    'Login': const LoginPage(),
    'Register': const RegisterPage(),
  };

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ...routes.entries.map(
                (entry) => ListTile(
              title: Text(entry.key),
              onTap: () {
                Navigator.pop(context); // Close drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => entry.value),
                );
              },
            ),
          ),
          const Divider(),
          // Logout Button
          ListTile(
            title: const Text('Logout',
                style: TextStyle(color: Colors.red)),
            onTap: () async {
              Navigator.pop(context);
              await UserSession.clearUser();

              // Navigate to HomePage and remove all previous routes
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false,
              );
            },
          ),

          const SizedBox(height: 16),
          // Clickable CartVerse Text
          InkWell(
            onTap: () {
              Navigator.pop(context); // Close drawer
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