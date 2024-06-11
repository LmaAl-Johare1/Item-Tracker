import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VerifyEmailViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController emailController = TextEditingController();

  String? errorMessage;

  Future<bool> verifyEmail() async {
    try {
      String email = emailController.text.trim();

      if (email.isEmpty) {
        errorMessage = 'Email cannot be empty';
        notifyListeners();
        return false;
      }

      QuerySnapshot snapshot = await _firestore
          .collection('Users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        errorMessage = 'Email does not exist';
        notifyListeners();
        return false;
      }

      errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = 'Error verifying email: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }
}
