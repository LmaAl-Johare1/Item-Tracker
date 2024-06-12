import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Services/UserService.dart';
import '../../Services/network_service.dart';

/// ViewModel for managing the profile data of an admin user.
///
/// This class provides functionality to fetch and manage the profile data
/// of an admin user from Firestore. It includes fetching the email of the
/// currently logged-in admin user.
class Profileadminviewmodel extends ChangeNotifier {
  /// Controller for the email text field.
  final TextEditingController emailController = TextEditingController();

  /// Instance of the NetworkService to interact with Firestore.
  final NetworkService _networkService = NetworkService();

  /// Instance of the UserService to fetch user role information.
  final UserService _userService = UserService();

  /// Fetches the profile data of the current admin user.
  ///
  /// This method fetches the user data from Firestore based on the currently
  /// logged-in user's ID. If the user is an admin, their email is fetched and
  /// populated in the [emailController].
  Future<void> fetchUserData() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final userId = currentUser.uid;
        final userRole = await _userService.fetchUserRole(userId);
        if (userRole == 'Admin') {
          final adminData = await _networkService.fetchData('Users', 'userId', userId);
          emailController.text = adminData['email'] ?? '';
        } else {
          print('No users with the role "admin" found.');
        }
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }
}
