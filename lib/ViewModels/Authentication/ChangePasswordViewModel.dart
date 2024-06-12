import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Services/network_service.dart'; // Import your network service

class ChangePasswordViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final NetworkService _networkService = NetworkService();

  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool _isCurrentPasswordObscured = true;
  bool _isNewPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;

  String? errorMessage;

  bool get isCurrentPasswordObscured => _isCurrentPasswordObscured;
  bool get isNewPasswordObscured => _isNewPasswordObscured;
  bool get isConfirmPasswordObscured => _isConfirmPasswordObscured;

  void toggleCurrentPasswordVisibility() {
    _isCurrentPasswordObscured = !_isCurrentPasswordObscured;
    notifyListeners();
  }

  void toggleNewPasswordVisibility() {
    _isNewPasswordObscured = !_isNewPasswordObscured;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordObscured = !_isConfirmPasswordObscured;
    notifyListeners();
  }

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

      // Re-authenticate the user with the current password
      AuthCredential credential = EmailAuthProvider.credential(email: user.email!, password: currentPassword);
      await user.reauthenticateWithCredential(credential);

      // Update password in Firebase Authentication
      await user.updatePassword(newPassword);

      // Update password in Firestore
      await _networkService.updatePasswordInFirestore(user.email!, newPassword);

      return true;
    } catch (e) {
      errorMessage = "Error changing password: ${e.toString()}";
      notifyListeners();
      return false;
    }
  }
}
