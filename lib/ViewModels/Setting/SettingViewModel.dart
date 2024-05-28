import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/Views/authentication/LoginView.dart';

class settingviewmodel {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> signOut(BuildContext context) async {
    try {
      await _firebaseAuth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (error) {
      print('Error signing out: $error');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to log out')));
    }
  }
}