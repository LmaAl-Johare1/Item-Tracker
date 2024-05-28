import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileViewModel extends ChangeNotifier {
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController businessAddressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool isEditing = false;

  Future<void> fetchUserData() async {
    try {
      QuerySnapshot usersSnapshot = await FirebaseFirestore.instance.collection('Users').where('user_rule', isEqualTo: 'Manager').get();

      if (usersSnapshot.docs.isNotEmpty) {
        DocumentSnapshot firstManagerDoc = usersSnapshot.docs.first;
        Map<String, dynamic> userData = firstManagerDoc.data() as Map<String, dynamic>;

        businessNameController.text = userData['businessName'] ?? '';
        businessAddressController.text = userData['businessAddress'] ?? '';
        phoneController.text = userData['phoneNumber'] ?? '';
        emailController.text = userData['email'] ?? '';
      } else {
        print('No users with the role "Manager" found.');
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  void toggleEditing() {
    isEditing = !isEditing;
    notifyListeners();
  }


}
