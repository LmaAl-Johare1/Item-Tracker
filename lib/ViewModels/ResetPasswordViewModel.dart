import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordViewModel extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  String? _errorMessage;
  bool _isLoading = false;

  String? get emailError => _errorMessage;
  bool get isLoading => _isLoading;

  void sendPasswordResetEmail() async {
    if (emailController.text.isEmpty || !emailController.text.contains('@')) {
      _errorMessage = "Please enter a valid email";
      notifyListeners();
      return;
    }
    try {
      _isLoading = true;
      notifyListeners();
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
      _isLoading = false;
      _errorMessage = "Reset password link sent to your email.";
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      _errorMessage = e.message;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}

