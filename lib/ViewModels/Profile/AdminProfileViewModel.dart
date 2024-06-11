import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profileadminviewmodel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();

  Future<void> fetchUserData() async {
    try {
      QuerySnapshot usersSnapshot = await FirebaseFirestore.instance.collection('Users').where('user_role', isEqualTo: 'Admin').get(); // تم تغيير staff إلى admin هنا

      if (usersSnapshot.docs.isNotEmpty) {
        DocumentSnapshot staffDoc = usersSnapshot.docs.first;
        Map<String, dynamic> userData = staffDoc.data() as Map<String, dynamic>;

        emailController.text = userData['email'] ?? '';
      } else {
        print('No users with the role "admin" found.');
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }
}
