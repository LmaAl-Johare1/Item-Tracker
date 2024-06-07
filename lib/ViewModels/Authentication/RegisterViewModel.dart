import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../Services/network_service.dart';
import '../../utils/validators.dart';

class RegisterViewModel extends ChangeNotifier {
  final NetworkService _networkService;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RegisterViewModel(this._networkService);

  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _selectedRole = 'Admin';
  String _businessName = '';
  String _phoneNumber = '';
  String _businessAddress = '';

  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  /// Getters for the form fields
  String get email => _email;
  String get password => _password;
  String get confirmPassword => _confirmPassword;
  String get selectedRole => _selectedRole;
  String get businessName => _businessName;
  String get phoneNumber => _phoneNumber;
  String get businessAddress => _businessAddress;

  /// Getters for the error messages
  String? get emailError => _emailError;
  String? get passwordError => _passwordError;
  String? get confirmPasswordError => _confirmPasswordError;

  /// Sets the email field.
  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  /// Sets the password field.
  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  /// Sets the confirm password field.
  void setConfirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
    notifyListeners();
  }

  /// Sets the selected role.
  void setSelectedRole(String role) {
    _selectedRole = role;
    notifyListeners();
  }

  /// Sets the business name field.
  void setBusinessName(String name) {
    _businessName = name;
    notifyListeners();
  }

  /// Sets the phone number field.
  void setPhoneNumber(String number) {
    _phoneNumber = number;
    notifyListeners();
  }

  /// Sets the business address field.
  void setBusinessAddress(String address) {
    _businessAddress = address;
    notifyListeners();
  }

  /// Validates the form fields and updates error messages.
  bool validateFields() {
    bool isValid = true;

    if (!Validators.validateEmail(_email)) {
      _emailError = 'Invalid email format';
      isValid = false;
    } else {
      _emailError = null;
    }

    if (!Validators.validatePassword(_password)) {
      _passwordError = 'Password must contain at least one uppercase, one lowercase, and be at least 6 characters long';
      isValid = false;
    } else {
      _passwordError = null;
    }

    if (!Validators.validatePasswordMatch(_password, _confirmPassword)) {
      _confirmPasswordError = 'Passwords do not match';
      isValid = false;
    } else {
      _confirmPasswordError = null;
    }

    notifyListeners();
    return isValid;
  }

  /// Sends registration data to the server.
  ///
  /// Throws an error if sending data fails.
  Future<void> signUp() async {
    if (validateFields()) {
      try {
        final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );

        // User registration successful, now prepare user data to send to the server
        final userData = _prepareUserData(userCredential.user!.uid);
        await _networkService.sendData('Users', userData);
      } catch (e) {
        print('Error signing up: $e');
        rethrow; // Rethrow the exception for upper layers to handle
      }
    }
  }

  /// Prepares user data based on the selected role.
  Map<String, dynamic> _prepareUserData(String userId) {
    final userData = {
      'userId': userId, // Include the user ID obtained from Firebase Authentication
      'email': _email,
      'user_role': _selectedRole,
    };

    // Include additional fields for Manager role
    if (_selectedRole == 'Manager') {
      userData.addAll({
        'businessName': _businessName,
        'phoneNumber': _phoneNumber,
        'businessAddress': _businessAddress,
      });
    }

    return userData;
  }
}
