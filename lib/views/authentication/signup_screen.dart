import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SignUp Page")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Add your login logic here
          },
          child: Text("SignUp"),
        ),
      ),
    );
  }
}