import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../ViewModels/authentication/LoginViewModel.dart';
import '../../models/login.dart';
import '../../res/AppColor.dart';
import '../../res/AppText.dart';
import '../dashboard/DashboardView.dart';
/// A screen widget for user login.
///
/// This screen provides a user interface for users to input their login credentials
/// (email and password) and attempt to log in. It includes text fields for email and password,
/// as well as a button to initiate the login process. Additionally, users can reset their password
/// if needed by tapping on the "Forget password?" link.
///
/// Uses [FirebaseAuth] for authentication and [LoginModel] for managing login data.
/// Relies on [AppColor] and [AppText] for consistent UI styling.
/// Handles login logic through [LoginViewModel].
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginViewModel _loginViewModel = LoginViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Expanded( // Wrap Column with Expanded
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center, // Align content horizontally center
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Text(
                      'Login',
                      style: AppText.headingOne.copyWith(
                        color: AppColor.primary,
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/img/logo.png',
                    width: 380,
                    height: 387,
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextField(
                      controller: _emailController,
                      decoration: _buildInputDecoration('Email'),
                    ),
                  ),
                  SizedBox(height: 35),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: _buildInputDecoration('Password'),
                    ),
                  ),
                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/resetPassword');
                          },
                          child: Text(
                            'Forget password?',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: AppColor.primary,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),

                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: SizedBox(
                      width: 209,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                        ),
                        onPressed: _handleLogin,
                        child: Text('Log in', style: AppText.ButtonText),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        color: AppColor.primary,
        fontWeight: FontWeight.bold,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: AppColor.primary.withOpacity(0.99),
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: AppColor.primary.withOpacity(0.99),
          width: 2,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      alignLabelWithHint: true,
      floatingLabelBehavior: FloatingLabelBehavior.always,
    );
  }


  void _handleLogin() async {
    final loginData = LoginModel(
      email: _emailController.text,
      password: _passwordController.text,
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginData.email,
        password: loginData.password,
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to login: $e'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}





