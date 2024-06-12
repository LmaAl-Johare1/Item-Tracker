import 'package:flutter/material.dart';
import '../Services/network_service.dart';

class SplashViewModel with ChangeNotifier {
  final NetworkService _networkService;
  bool _isSignUpVisible = false;

  SplashViewModel(this._networkService) {
    _checkEmail();
  }

  bool get isSignUpVisible => _isSignUpVisible;

  Future<void> _checkEmail() async {
    try {
      // Fetch all users from the Users collection
      List<Map<String, dynamic>> users = await _networkService.fetchAll('Users');
      // Check if there are no users with an 'email' field
      _isSignUpVisible = users.isEmpty || users.every((user) => user['email'] == null);
      notifyListeners();
    } catch (e) {
      // Handle any errors that occur during the fetch operation
      print('Error checking emails: $e');
    }
  }
}
