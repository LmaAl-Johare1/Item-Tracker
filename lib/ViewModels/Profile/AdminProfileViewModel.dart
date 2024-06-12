import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Services/UserService.dart';
import '../../Services/network_service.dart';

class Profileadminviewmodel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final NetworkService _networkService = NetworkService();
  final UserService _userService = UserService();
  Future<void> fetchUserData() async {
    try{
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
