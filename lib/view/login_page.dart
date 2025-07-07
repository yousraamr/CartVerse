import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/login_model.dart';
import '../services/auth_service.dart';
import '../services/user_session.dart';
import '../utils/route_names.dart';
import '../utils/snackbar.dart';
import '../view/drawer_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  void _submitLogin() async{
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;
      try {
        // send request
        http.Response apiResponse = await AuthService().login(email, password);
        print("Login API status code: ${apiResponse.statusCode}");

        if (apiResponse.statusCode == 200) {
          final data = jsonDecode(apiResponse.body);
          print("Decoded login response: $data");

          // Null-safe parsing
          final userData = data['user'] ?? {};
          final String firstName = userData['firstName'] ?? '';
          final String lastName = userData['lastName'] ?? '';
          final String token = data['accessToken'] ?? '';

          // save user session
          await UserSession.saveUser(
            firstName: firstName,
            lastName: lastName,
            token: token,
          );

          LoginModel loginModel = LoginModel.fromJson(json.decode(apiResponse.body));

          // navigate and show success message
          Navigator.of(context).pushNamedAndRemoveUntil(
              homeScreen, (route) => false);
          showSuccessSnackBar(context, 'Login Successfully');

          print("Access Token: ${loginModel.accessToken}");
          print("User logged in: ${loginModel.user?.firstName} ${loginModel.user
              ?.lastName}");
        } else {
          // show error if login failed
          showErrorSnackBar(context, 'Login failed. Please check your credentials.');
          print("Login failed: ${apiResponse.body}");
        }
      }catch(e) {
        showErrorSnackBar(context, 'An error occurred during login.');
        print("Login exception: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context ) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const DrawerWidget(),
      backgroundColor: const Color(0xFFF5F6F8),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                'Welcome Back',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border:OutlineInputBorder(),

                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Enter your email';
                          if (!value.contains('@')) return 'Enter a valid email';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      // Password
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border:OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () => setState(() {
                              _obscurePassword = !_obscurePassword;
                            }),
                          ),
                        ),
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Enter your password' : null,
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ElevatedButton(
                          onPressed: _submitLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFB8860B), // gold color
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text('Login'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
