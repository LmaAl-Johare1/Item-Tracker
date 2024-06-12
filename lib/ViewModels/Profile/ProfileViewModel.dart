import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Services/UserService.dart';
import '../../Services/network_service.dart'; // Import your network service class

class ProfileViewModel extends ChangeNotifier {
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController businessAddressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final UserService _userService = UserService();
  final NetworkService _networkService = NetworkService(); // Instance of NetworkService

  bool isEditing = false;

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

  void toggleEditing() {
    isEditing = !isEditing;
    notifyListeners();
  }

  Future<void> saveChanges(BuildContext context) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final userId = currentUser.uid;
        await _networkService.updateData('Users', 'userId', userId, {
          'businessName': businessNameController.text,
          'businessAddress': businessAddressController.text,
          'phoneNumber': phoneController.text,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Changes saved successfully!'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );

        toggleEditing();
      }
    } catch (error) {
      print('Error saving changes: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save changes'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
