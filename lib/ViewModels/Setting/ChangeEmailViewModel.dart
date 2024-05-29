import 'package:flutter/material.dart';
import 'package:project/Services/network_service.dart';

class ChangeEmailViewModel extends ChangeNotifier {
  List<String> emails = [];
  String? selectedEmail;
  TextEditingController newEmailController = TextEditingController();

  String successMessage = '';
  String errorMessage = '';
  final NetworkService networkService;

  ChangeEmailViewModel({required this.networkService}) {
    fetchEmails();
  }

  Future<void> fetchEmails() async {
    try {
      // Fetch all user documents from the Users collection
      print('Fetching emails from database...');
      List<Map<String, dynamic>> users = await networkService.fetchAll('Users');
      print('Data received: $users');
      emails = users.map((user) => user['email'].toString()).toList();
      print('Parsed emails: $emails');
      notifyListeners();
    } catch (e) {
      errorMessage = 'Failed to load emails: $e';
      successMessage = '';
      notifyListeners();
    }
  }

  Future<void> changeEmail() async {
    if (selectedEmail == null || newEmailController.text.isEmpty) {
      errorMessage = 'Please select an email and enter a new email address';
      successMessage = '';
    } else if (!_isValidEmail(newEmailController.text)) {
      errorMessage = 'Please enter a valid email address';
      successMessage = '';
    } else {
      try {
        // Update the email in the database
        await networkService.updateData(
          'Users',
          'email',
          selectedEmail!, // Field and value to find the document
          {'email': newEmailController.text}, // New data to update
        );

        successMessage = 'Email has been changed successfully';
        errorMessage = '';
        fetchEmails(); // Refresh the email list
      } catch (e) {
        errorMessage = 'Failed to change email: $e';
        successMessage = '';
      }
    }
    notifyListeners();
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }
}