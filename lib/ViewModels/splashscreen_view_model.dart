import 'package:flutter/cupertino.dart';
import '../models/user.dart';

/// ViewModel for managing user-related operations and UI state changes.
///
/// This ViewModel is responsible for managing the state and interactions
/// related to user operations in the UI. It determines whether certain UI
/// elements, such as the signup button, should be shown based on the user data.
class UserViewModel extends ChangeNotifier {
  /// Internal model holding the current user's data.
  final UserModel _userModel;

  /// Flag to determine whether the signup button should be shown.
  bool _showSignupButton = false;

  /// Constructor that initializes the ViewModel with a user model.
  ///
  /// Upon initialization, it also determines the visibility of the signup
  /// button based on the user collection status.
  ///
  /// Parameters:
  ///   - [_userModel] UserModel instance that holds user-related data and methods.
  UserViewModel(this._userModel) {
    determineButtonVisibility();
  }

  /// Getter to retrieve the current visibility state of the signup button.
  bool get showSignupButton => _showSignupButton;

  /// Determines the visibility of the signup button by checking if the user
  /// collection is empty.
  ///
  /// Updates [_showSignupButton] based on whether the users collection is
  /// empty and notifies listeners if there's a change in the button's visibility state.
  void determineButtonVisibility() async {
    bool isEmpty = await _userModel.isUsersCollectionEmpty();
    if (isEmpty != _showSignupButton) {
      _showSignupButton = isEmpty;
      notifyListeners();
    }
  }
}