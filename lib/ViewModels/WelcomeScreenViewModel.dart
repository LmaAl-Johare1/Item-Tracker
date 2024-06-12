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
      List<Map<String, dynamic>> users = await _networkService.fetchAll('Users');
      _isSignUpVisible = users.isEmpty;
      notifyListeners();
    } catch (e) {
      print('Error checking emails: $e');
    }
  }
}