import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:project/Services/network_service.dart';
import 'package:project/utils/validators.dart';

class ResetPasswordViewModel extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String? _errorMessage;
  bool _isLoading = false;
  bool _emailSent = false;
  String? _email;

  String? get emailError => _errorMessage;
  bool get isLoading => _isLoading;
  bool get emailSent => _emailSent;
  String? get email => _email;

  final NetworkService _networkService = NetworkService();

  Future<void> checkEmail() async {
    String email = emailController.text.trim();

    if (!Validators.validateEmail(email)) {
      _errorMessage = "Please enter a valid email";
      notifyListeners();
      return;
    }

    _isLoading = true;
    _emailSent = false;
    notifyListeners();

    try {
      bool emailExists = await _networkService.emailExists(email);
      if (!emailExists) {
        _isLoading = false;
        _errorMessage = "Email does not exist";
        notifyListeners();
        return;
      }

      _isLoading = false;
      _emailSent = true;
      _email = email;
      _errorMessage = null;
      notifyListeners();
    } on Exception catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> resetPassword(String? email) async {
    if (email == null) {
      _errorMessage = "Email is not set";
      notifyListeners();
      return;
    }

    String newPassword = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (!Validators.validatePassword(newPassword)) {
      _errorMessage =
      "Password must contain at least one uppercase, one lowercase, and be at least 6 characters long";
      notifyListeners();
      return;
    }

    if (newPassword != confirmPassword) {
      _errorMessage = "Passwords do not match";
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      await _networkService.updatePasswordInFirestore(email, newPassword);
      _isLoading = false;
      _errorMessage = null;
      notifyListeners();
    } on Exception catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
