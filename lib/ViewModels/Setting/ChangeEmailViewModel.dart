import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/Services/network_service.dart';

/// ViewModel for handling email change functionality.
///
/// This class manages the process of changing a user's email address,
/// including fetching available emails from the database, validating the new email,
/// and updating the email in Firebase Authentication and Firestore.
class ChangeEmailViewModel extends ChangeNotifier {
  /// List of emails fetched from the database.
  List<String> emails = [];

  /// The currently selected email from the list.
  String? selectedEmail;

  /// Controller for the new email input field.
  TextEditingController newEmailController = TextEditingController();

  /// Success message to display upon successful email change.
  String successMessage = '';

  /// Error message to display upon failure or validation error.
  String errorMessage = '';

  /// Instance of NetworkService to handle database operations.
  final NetworkService networkService;

  /// Constructor to initialize the ViewModel with a NetworkService instance
  /// and fetch the initial list of emails.
  ChangeEmailViewModel({required this.networkService}) {
    fetchEmails();
  }

  /// Fetches all user emails from the 'Users' collection in Firestore.
  ///
  /// This method updates the [emails] list and notifies listeners upon completion.
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

  /// Changes the email of the authenticated user to a new email address.
  ///
  /// This method validates the input, updates the email in Firebase Authentication,
  /// and updates the email in Firestore. It sets the appropriate success or error messages
  /// and notifies listeners.
  Future<void> changeEmail() async {
    if (selectedEmail == null || newEmailController.text.isEmpty) {
      errorMessage = 'Please select an email and enter a new email address';
      successMessage = '';
    } else if (!_isValidEmail(newEmailController.text)) {
      errorMessage = 'Please enter a valid email address';
      successMessage = '';
    } else {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null && user.email == selectedEmail) {
          // Update the email in Firebase Authentication
          await user.updateEmail(newEmailController.text);

          // Update the email in Firestore
          await networkService.updateData(
            'Users',
            'email',
            selectedEmail!, // Field and value to find the document
            {'email': newEmailController.text}, // New data to update
          );

          successMessage = 'Email has been changed successfully';
          errorMessage = '';
          fetchEmails(); // Refresh the email list
        } else {
          errorMessage = 'Selected email does not match the authenticated user email';
          successMessage = '';
        }
      } catch (e) {
        errorMessage = 'Failed to change email: $e';
        successMessage = '';
      }
    }
    notifyListeners();
  }

  /// Validates the given email address.
  ///
  /// Returns true if the email address is valid; otherwise, false.
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }
}
