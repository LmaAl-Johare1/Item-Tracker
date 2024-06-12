import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Services/UserService.dart';
import '../../Services/network_service.dart';

/// ViewModel for managing and editing the profile data of a user.
///
/// This class provides functionality to fetch and update the profile data
/// of a user with the role "Manager" from Firestore.
class ProfileViewModel extends ChangeNotifier {
  /// Controller for the business name text field.
  final TextEditingController businessNameController = TextEditingController();

  /// Controller for the business address text field.
  final TextEditingController businessAddressController = TextEditingController();

  /// Controller for the phone number text field.
  final TextEditingController phoneController = TextEditingController();

  /// Controller for the email text field.
  final TextEditingController emailController = TextEditingController();

  /// Instance of UserService to fetch user roles.
  final UserService _userService = UserService();

  /// Instance of NetworkService to fetch and update data from Firestore.
  final NetworkService _networkService = NetworkService();

  /// Flag to track whether the profile is in editing mode.
  bool isEditing = false;

  /// Fetches the user data for the currently logged-in user.
  ///
  /// This method fetches the user data from Firestore and populates the text
  /// controllers with the fetched data. It ensures that the current user has
  /// the role "Manager". If the user is not a manager or no user is logged in,
  /// appropriate messages are printed to the console.
  Future<void> fetchUserData() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final userId = currentUser.uid;
        final userRole = await _userService.fetchUserRole(userId);

        if (userRole == 'Manager') {
          final managerData = await _networkService.fetchData('Users', 'userId', userId);

          if (managerData != null) {
            businessNameController.text = managerData['businessName'] ?? '';
            businessAddressController.text = managerData['businessAddress'] ?? '';
            phoneController.text = managerData['phoneNumber'] ?? '';
            emailController.text = managerData['email'] ?? '';
          } else {
            print('No data found for manager');
          }
        } else {
          print('Current user is not a manager');
        }
      } else {
        print('No user logged in');
      }
    } catch (error) {
      print('Error fetching manager data: $error');
    }
  }

  /// Toggles the editing mode for the profile.
  ///
  /// This method switches the `isEditing` flag between true and false,
  /// and notifies listeners of the change.
  void toggleEditing() {
    isEditing = !isEditing;
    notifyListeners();
  }
}
