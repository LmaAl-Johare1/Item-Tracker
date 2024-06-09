import '../../../services/network_service.dart';
import 'package:flutter/material.dart';
import 'package:project/utils/validators.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginViewModel extends ChangeNotifier {
  final NetworkService _networkService = NetworkService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _email = '';
  String _password = '';

  String? _emailError;
  String? _passwordError;

  String get email => _email;
  String get password => _password;

  String? get emailError => _emailError;
  String? get passwordError => _passwordError;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  bool validateFields() {
    bool isValid = true;

    if (!Validators.validateEmail(_email)) {
      _emailError = 'Invalid email format';
      isValid = false;
    } else {
      _emailError = null;
    }

    if (Validators.isFieldEmpty(_password)) {
      _passwordError = 'Password cannot be empty';
      isValid = false;
    } else {
      _passwordError = null;
    }

    notifyListeners();
    return isValid;
  }

  Future<void> login() async {
    if (validateFields()) {
      try {
        final userData = await _networkService.fetchData('Users', 'email', _email);

        if (userData.isEmpty) {
          _emailError = 'Email does not exist';
          _passwordError = null; // Clear password error if email is invalid
          notifyListeners();
          return;
        }

        // Debug print for fetched user data
        print('Fetched user data: $userData');

        if (userData['password'].trim() != _password.trim()) {
          _passwordError = 'Incorrect password';
          _emailError = null; // Clear email error if password is incorrect
          notifyListeners();
          return;
        }

        // Update password in Firestore if login is successful
        await _updatePasswordInFirestore(_email, _password);

        // Proceed with successful login
        _emailError = null;
        _passwordError = null;
        notifyListeners();

      } catch (e) {
        _passwordError = 'Failed to sign in: $e';
        notifyListeners();
      }
    }
  }

  Future<void> _updatePasswordInFirestore(String email, String newPassword) async {
    try {
      var userDoc = await _firestore.collection('Users').where('email', isEqualTo: email).limit(1).get();
      if (userDoc.docs.isNotEmpty) {
        await _firestore.collection('Users').doc(userDoc.docs.first.id).update({'password': newPassword});
      }
    } catch (e) {
      throw Exception("Failed to update password in Firestore: $e");
    }
  }
}