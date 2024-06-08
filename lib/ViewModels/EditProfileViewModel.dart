import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/UserModel.dart';

class EditProfileViewModel extends ChangeNotifier {
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController businessAddressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  UserModel? user;
  String? userId; // معرف المستخدم

  EditProfileViewModel() {
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      QuerySnapshot usersSnapshot = await FirebaseFirestore.instance.collection('Users').where('user_rule', isEqualTo: 'Manager').get();

      if (usersSnapshot.docs.isNotEmpty) {
        DocumentSnapshot firstManagerDoc = usersSnapshot.docs.first;
        user = UserModel.fromMap(firstManagerDoc.data() as Map<String, dynamic>);

        businessNameController.text = user!.businessName;
        businessAddressController.text = user!.businessAddress;
        phoneController.text = user!.phoneNumber;
        emailController.text = user!.email;
        notifyListeners();
      } else {
        print('No users with the role "Manager" found.');
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  Future<void> saveChanges(BuildContext context) async {
    try {
      QuerySnapshot usersSnapshot = await FirebaseFirestore.instance.collection('Users').where('user_rule', isEqualTo: 'Manager').get();

      for (DocumentSnapshot doc in usersSnapshot.docs) {
        await doc.reference.update({
          'businessName': businessNameController.text,
          'businessAddress': businessAddressController.text,
          'phoneNumber': phoneController.text,
          'email': emailController.text,
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Changes saved successfully!'), // رسالة الإشعار
          duration: Duration(seconds: 2), // مدة عرض الإشعار
          backgroundColor: Colors.green, // لون الخلفية
          behavior: SnackBarBehavior.floating,
        ),
      );
      notifyListeners();
    } catch (error) {
      print('Error saving changes: $error');
    }
  }
}
