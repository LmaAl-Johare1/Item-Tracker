import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String? errorMessage;

  Future<bool> changePassword() async {
    try {
      User? user = _auth.currentUser;

      String currentPassword = currentPasswordController.text;
      String newPassword = newPasswordController.text;
      String confirmPassword = confirmPasswordController.text;

      if (newPassword != confirmPassword) {
        errorMessage = 'Passwords do not match';
        notifyListeners();
        return false;
      }

      AuthCredential credential = EmailAuthProvider.credential(email: user!.email!, password: currentPassword);
      await user.reauthenticateWithCredential(credential);

      await user.updatePassword(newPassword);

      return true;
    } catch (e) {
      errorMessage = "Error changing password: $e";
      notifyListeners();
      return false;
    }
  }
}
