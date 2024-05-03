import 'package:flutter/cupertino.dart';

import '../models/user.dart';

class UserViewModel extends ChangeNotifier {
  final UserModel _userModel;
  bool _showSignupButton = false;

  UserViewModel(this._userModel) {
    determineButtonVisibility();
  }

  bool get showSignupButton => _showSignupButton;

  void determineButtonVisibility() async {
    bool isEmpty = await _userModel.isUsersCollectionEmpty();
    if (isEmpty != _showSignupButton) {
      _showSignupButton = isEmpty;
      notifyListeners();
    }
  }
}
