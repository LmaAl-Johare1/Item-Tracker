import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Services/UserService.dart';
import '../../Services/network_service.dart'; // Import your network service class

class ProfileStaffViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final NetworkService _networkService = NetworkService();
  final UserService _userService = UserService();

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
