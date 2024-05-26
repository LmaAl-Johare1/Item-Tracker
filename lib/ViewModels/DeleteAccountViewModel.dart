import 'package:flutter/material.dart';
import 'package:project/Services/network_service.dart';

class DeleteAccountViewModel extends ChangeNotifier {
  final NetworkService _networkService = NetworkService();
  String _message = '';

  String get message => _message;

  Future<void> deleteAccount(String account) async {
    if (account.isEmpty) {
      _message = 'Account field is empty';
      notifyListeners();
      return;
    }

    bool accountExists = await _networkService.emailExists(account);
    if (!accountExists) {
      _message = 'Invalid account';
      notifyListeners();
      return;
    }

    await _networkService.deleteData('Users', account);
    _message = 'Account deleted';
    notifyListeners();
  }
}
