import 'package:flutter/material.dart';
import '../utils/snackbar.dart';
import 'drawer_widget.dart';

import 'package:cartverse/services/auth_service.dart';
import 'package:cartverse/models/signup_model.dart';
import 'package:cartverse/utils/route_names.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';




class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  /*void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      http.Response apiResponse = await AuthService().register(
        _firstNameController.text,
        _lastNameController.text,
        _emailController.text,
        _passwordController.text,
      );

      final signupData = SignupModel.fromJson(json.decode(apiResponse.body));
      print("Access Token: ${signupData.accessToken}");
      print("User First Name: ${signupData.user?.firstName}");
      print("Registered: ${_firstNameController.text}");
    }
  }*/

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      http.Response apiResponse = await AuthService().register(
        _firstNameController.text,
        _lastNameController.text,
        _emailController.text,
        _passwordController.text,
      );

      print("Status Code: ${apiResponse.statusCode}");
      print("Response Body: ${apiResponse.body}");

      if (apiResponse.statusCode == 200 || apiResponse.statusCode ==201) {
        try {
          final decoded = json.decode(apiResponse.body);

          if (decoded is Map<String, dynamic>) {
            final signupData = SignupModel.fromJson(decoded);
            print("Access Token: ${signupData.accessToken}");
            print("User First Name: ${signupData.user?.firstName}");

            Navigator.of(context).pushNamed(loginScreen);
            showSuccessSnackBar(context,'Register Successfully');

            await Future.delayed(const Duration(seconds: 2));
            Navigator.pushReplacementNamed(context, loginScreen);
          } else {
            print("Unexpected JSON structure.");
          }
        } catch (e) {
          print("Error decoding JSON: $e");
        }
      }
      else{
        showErrorSnackBar(context, apiResponse.body);
      }
    }
  }



  @override
  Widget build(BuildContext context) {
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
                'User Registration',
                style: TextStyle(
                  fontSize: 24,
                ),
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
                      TextFormField(
                        controller: _firstNameController,
                        decoration: const InputDecoration(
                            labelText: 'First Name',
                            border:OutlineInputBorder(),
                        ),
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Enter your first name' : null,
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _lastNameController,
                        decoration: const InputDecoration(
                            labelText: 'Last Name',
                            border:OutlineInputBorder(),
                        ),
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Enter your last name' : null,
                      ),
                      const SizedBox(height: 16.0),
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
                        value == null || value.length < 6
                            ? 'Enter minimum 6 characters'
                            : null,
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _confirmController,
                        obscureText: _obscureConfirm,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          border:OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirm ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () => setState(() {
                              _obscureConfirm = !_obscureConfirm;
                            }),
                          ),
                        ),
                        validator: (value) =>
                        value != _passwordController.text ? 'Passwords do not match' : null,
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFB8860B),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text('Register'),
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
