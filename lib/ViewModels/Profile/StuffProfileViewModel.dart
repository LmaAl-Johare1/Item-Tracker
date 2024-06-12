import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Services/UserService.dart';
import '../../Services/network_service.dart';

/// ViewModel for managing and displaying the profile data of a staff user.
///
/// This class provides functionality to fetch and display the profile data
/// of a user with the role "Staff" from Firestore.
class ProfileStaffViewModel extends ChangeNotifier {
  /// Controller for the email text field.
  final TextEditingController emailController = TextEditingController();

  /// Instance of NetworkService to fetch data from Firestore.
  final NetworkService _networkService = NetworkService();

  /// Instance of UserService to fetch user roles.
  final UserService _userService = UserService();

  /// Fetches the user data for the currently logged-in staff user.
  ///
  /// This method fetches the user data from Firestore and populates the email
  /// controller with the fetched data. It ensures that the current user has
  /// the role "Staff". If the user is not a staff member or no user is logged in,
  /// appropriate messages are printed to the console.
  Future<void> fetchUserData() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final userId = currentUser.uid;
        final userRole = await _userService.fetchUserRole(userId);
        if (userRole == 'Staff') {
          final staffData = await _networkService.fetchData('Users', 'userId', userId);
          if (staffData != null) {
            emailController.text = staffData['email'] ?? '';
          } else {
            print('No data found for the current user with role "Staff".');
          }
        } else {
          print('Current user is not a staff member.');
        }
      } else {
        print('No user logged in.');
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }
}
