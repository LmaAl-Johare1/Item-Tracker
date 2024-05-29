
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:project/Services/network_service.dart';
import 'package:project/utils/validators.dart'; // Import validators

class ResetPasswordViewModel extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  String? _errorMessage;
  bool _isLoading = false;

  String? get emailError => _errorMessage;
  bool get isLoading => _isLoading;

  final NetworkService _networkService = NetworkService();

  void sendPasswordResetEmail() async {
    String email = emailController.text.trim();

    // Use the Validators class to check if the email is valid.
    if (!Validators.validateEmail(email)) {
      _errorMessage = "Please enter a valid email";
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      bool emailExists = await _networkService.emailExists(email);
      if (!emailExists) {
        _isLoading = false;
        _errorMessage = "Email does not exist in our records.";
        notifyListeners();
        return;
      }

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