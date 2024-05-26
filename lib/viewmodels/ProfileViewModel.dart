import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier {
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController businessAddressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  ProfileViewModel() {
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      QuerySnapshot usersSnapshot = await FirebaseFirestore.instance.collection('Users').where('user_rule', isEqualTo: 'Manager').get();

      if (usersSnapshot.docs.isNotEmpty) {
        for (DocumentSnapshot userDoc in usersSnapshot.docs) {
          Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

          businessNameController.text = userData['businessName'] ?? '';
          businessAddressController.text = userData['businessAddress'] ?? '';
          phoneController.text = userData['phoneNumber'] ?? '';
          emailController.text = userData['email'] ?? '';

          notifyListeners(); // Notify listeners to update the UI
        }
      } else {
        print('No users with the role "Manager" found.');
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  @override
  void dispose() {
    businessNameController.dispose();
    businessAddressController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
