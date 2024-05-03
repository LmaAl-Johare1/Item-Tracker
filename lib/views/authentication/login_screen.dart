import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Page")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Add your login logic here
          },
          child: Text("Log In"),
        ),
      ),
    );
  }
}