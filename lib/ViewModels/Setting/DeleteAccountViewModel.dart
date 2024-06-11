import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/Services/network_service.dart';

class DeleteAccountViewModel extends ChangeNotifier {
  final NetworkService _networkService = NetworkService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _message = '';
  String _selectedAccount = '';
  List<String> _emails = [];

  String get message => _message;
  String get selectedAccount => _selectedAccount;
  List<String> get emails => _emails;

  void setSelectedAccount(String account) {
    _selectedAccount = account;
    notifyListeners();
  }

  Future<void> fetchEmails() async {
    List<Map<String, dynamic>> users = await _networkService.fetchAll('Users');
    _emails = users.map((user) => user['email'] as String).toList();
    _emails = _emails.toSet().toList(); // Remove duplicates
    if (!_emails.contains(_selectedAccount)) {
      _selectedAccount = ''; // Reset selected account if it's not in the list
    }
    notifyListeners();
  }

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
