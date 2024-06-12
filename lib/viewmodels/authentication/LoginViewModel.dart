import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../services/network_service.dart';
import '../../ViewModels/Reminder/ReminderViewModel.dart';
import '../../utils/validators.dart';
import 'package:provider/provider.dart';

class LoginViewModel extends ChangeNotifier {
  final NetworkService _networkService = NetworkService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _email = '';
  String _password = '';

  String? _emailError;
  String? _passwordError;

  String get email => _email;

  String get password => _password;

  String? get emailError => _emailError;

  String? get passwordError => _passwordError;

  String? _userId; // Added field to store user ID

  String? get userId => _userId; // Getter for user ID

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

  Future<void> login(BuildContext context) async {
    if (validateFields()) {
      try {
        final RemindersViewModel reminderViewModel = Provider.of<RemindersViewModel>(context, listen: false);
        final UserCredential userCredential = await _auth
            .signInWithEmailAndPassword(
          email: _email.trim(),
          password: _password.trim(),
        );

        // Retrieve the user ID from the userCredential
        _userId = userCredential.user?.uid;

        // If user ID is null, login failed
        if (_userId == null) {
          _passwordError = 'Failed to sign in';
          notifyListeners();
          return;
        }

        // Fetch user data using the authenticated user's ID
        final userData = await _networkService.fetchData(
            'Users', 'userId', _userId!);

        // Check if user is a manager
        final bool isManager = userData['user_role'] == 'Manager';

        if (isManager) {
          // Instantiate RemindersViewModel and send notifications
          //await reminderViewModel.sendNotification();

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

          // Proceed with successful login
          _emailError = null;
          _passwordError = null;
          notifyListeners();
        }
      } catch (e) {
        _passwordError = 'Failed to sign in: $e';
        notifyListeners();
      }
    }
  }
}
