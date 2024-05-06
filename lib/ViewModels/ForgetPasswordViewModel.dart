import 'package:flutter/cupertino.dart';
import 'package:project/Services/network_service.dart';
import 'package:project/utils/validators.dart';
class PasswordResetViewModel extends ChangeNotifier {
  final NetworkService networkService;

  PasswordResetViewModel(this.networkService);



  Future<void> sendResetEmail(String email) async {
    try {
      await networkService.sendPasswordResetEmail(email);
      // Navigate to ForgetPasswordView should be triggered after this
    } catch (error) {
      // Handle the error properly
      print('Error sending reset email: $error');
    }
  }

  Future<void> updatePassword(String newPassword) async {
    String? validationResult = Validators.validatePassword(newPassword);
    if (validationResult != null) {
      // Handle validation error, e.g., update UI with an error message
      throw Exception(validationResult);
    }
    // If valid, proceed with the API call or next steps
    try {
      await networkService.sendPasswordResetEmail(newPassword);
      // Success handling, navigate or show success message
    } catch (error) {
      // Error handling during the API call
      throw Exception('Failed to update password: $error');
    }
  }
    notifyListeners();
  }


