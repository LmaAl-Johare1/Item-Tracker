import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// ViewModel for changing user password.
class ChangePasswordViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  /// Error message to be displayed in case of any errors during password change.
  String? errorMessage;

  /// Changes the user's password.
  ///
  /// Returns true if the password change was successful, otherwise false.
  Future<bool> changePassword() async {
    try {
      User? user = _auth.currentUser;

      if (user == null) {
        errorMessage = 'No user is currently signed in.';
        notifyListeners();
        return false;
      }

      String currentPassword = currentPasswordController.text;
      String newPassword = newPasswordController.text;
      String confirmPassword = confirmPasswordController.text;

      if (newPassword != confirmPassword) {
        errorMessage = 'Passwords do not match';
        notifyListeners();
        return false;
      }

      AuthCredential credential = EmailAuthProvider.credential(email: user.email!, password: currentPassword);
      await user.reauthenticateWithCredential(credential);

      await user.updatePassword(newPassword);

      return true;
    } catch (e) {
      errorMessage = "Error changing password: ${e.toString()}";
      notifyListeners();
      return false;
    }
  }
}
