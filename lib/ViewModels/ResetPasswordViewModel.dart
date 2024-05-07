import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:project/Services/network_service.dart'; // Ensure this import is correct based on your project structure

class ResetPasswordViewModel extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  String? _errorMessage;
  bool _isLoading = false;

  String? get emailError => _errorMessage;
  bool get isLoading => _isLoading;

  final NetworkService _networkService = NetworkService();

  void sendPasswordResetEmail() async {
    String email = emailController.text.trim();

    if (email.isEmpty || !email.contains('@')) {
      _errorMessage = "Please enter a valid email";
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      // First check if the email exists in the database
      bool emailExists = await _networkService.emailExists(email);
      if (!emailExists) {
        _isLoading = false;
        _errorMessage = "Email does not exist in our records.";
        notifyListeners();
        return;
      }

      // If email exists, proceed to send the reset email
      await _networkService.sendPasswordResetEmail(email);
      _isLoading = false;
      _errorMessage = "Reset password link sent to your email.";
      notifyListeners();
    } on Exception catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
