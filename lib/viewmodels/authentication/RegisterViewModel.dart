import 'package:flutter/material.dart';
import 'package:project/services/network_service.dart';

/// ViewModel for the registration screen.
///
/// Handles user inputs, prepares user data, and sends it to the network service.
class RegisterViewModel extends ChangeNotifier {
  final NetworkService _networkService;

  RegisterViewModel(this._networkService);

  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _selectedRole = 'Admin';
  String _businessName = '';
  String _phoneNumber = '';
  String _businessAddress = '';

  /// Getters for the form fields
  String get email => _email;
  String get password => _password;
  String get confirmPassword => _confirmPassword;
  String get selectedRole => _selectedRole;
  String get businessName => _businessName;
  String get phoneNumber => _phoneNumber;
  String get businessAddress => _businessAddress;

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

  /// Sends registration data to the server.
  ///
  /// Prepares user data and sends it to the network service.
  /// Throws an error if sending data fails.
  Future<void> sendDataToServer() async {
    try {
      final userData = _prepareUserData();
      await _networkService.sendData('Users', userData);
    } catch (e) {
      print('Error sending data: $e');
      rethrow; // Rethrow the exception for upper layers to handle
    }
  }

  /// Prepares user data based on the selected role.
  ///
  /// Returns a map containing user data to be sent to the server.
  Map<String, dynamic> _prepareUserData() {
    final userData = {
      'email': _email,
      'password': _password,
      'user_rule': _selectedRole, // Add selected user role here
    };

    // If the role is Manager, add additional fields
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
