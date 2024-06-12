import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/Services/network_service.dart';

/// ViewModel for handling the deletion of user accounts.
///
/// This class manages the process of fetching user emails, selecting an account,
/// re-authenticating the user, and deleting the account from Firebase Authentication
/// and Firestore.
class DeleteAccountViewModel extends ChangeNotifier {
  final NetworkService _networkService = NetworkService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _message = '';
  String _selectedAccount = '';
  List<String> _emails = [];

  /// Getter for the message to be displayed to the user.
  String get message => _message;

  /// Getter for the currently selected account.
  String get selectedAccount => _selectedAccount;

  /// Getter for the list of user emails.
  List<String> get emails => _emails;

  /// Sets the selected account and notifies listeners.
  ///
  /// [account] - The email of the selected account.
  void setSelectedAccount(String account) {
    _selectedAccount = account;
    notifyListeners();
  }

  /// Fetches all user emails from the 'Users' collection in Firestore.
  ///
  /// This method updates the [_emails] list and notifies listeners upon completion.
  Future<void> fetchEmails() async {
    List<Map<String, dynamic>> users = await _networkService.fetchAll('Users');
    _emails = users.map((user) => user['email'] as String).toList();
    _emails = _emails.toSet().toList(); // Remove duplicates
    if (!_emails.contains(_selectedAccount)) {
      _selectedAccount = ''; // Reset selected account if it's not in the list
    }
    notifyListeners();
  }

  /// Deletes the selected account after re-authenticating the user.
  ///
  /// [password] - The password of the user for re-authentication.
  ///
  /// This method re-authenticates the user with the provided password,
  /// deletes the user from Firebase Authentication, and removes the user's data
  /// from Firestore. It sets the appropriate success or error messages and notifies listeners.
  Future<void> deleteAccount(String password) async {
    if (_selectedAccount.isEmpty) {
      _message = 'Account field is empty';
      notifyListeners();
      return;
    }

    try {
      // Re-authenticate the user before deleting
      User? user = _auth.currentUser;
      if (user != null && user.email == _selectedAccount) {
        AuthCredential credential = EmailAuthProvider.credential(
          email: _selectedAccount,
          password: password, // Use the provided password
        );

        await user.reauthenticateWithCredential(credential);
        await user.delete();
      }

      // Delete the user from the database
      await _networkService.deleteData('Users', 'email', _selectedAccount);
      _message = 'Account deleted permanently';
      await fetchEmails(); // Refresh the email list after deletion
    } catch (e) {
      _message = 'Failed to delete the account';
    }
    notifyListeners();
  }
}
