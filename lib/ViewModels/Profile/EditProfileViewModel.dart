import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Models/UserModel.dart';

/// ViewModel for managing and editing the user profile data.
///
/// This class provides functionality to fetch and update the profile data
/// of a user with the role "Manager" from Firestore.
class EditProfileViewModel extends ChangeNotifier {
  /// Controller for the business name text field.
  final TextEditingController businessNameController = TextEditingController();

  /// Controller for the business address text field.
  final TextEditingController businessAddressController = TextEditingController();

  /// Controller for the phone number text field.
  final TextEditingController phoneController = TextEditingController();

  /// Controller for the email text field.
  final TextEditingController emailController = TextEditingController();

  /// The current user's data.
  UserModel? user;

  /// The current user's ID.
  String? userId;

  /// Constructor that initializes the ViewModel and fetches user data.
  EditProfileViewModel() {
    fetchUserData();
  }

  /// Fetches the user data for the user with the role "Manager".
  ///
  /// This method fetches the user data from Firestore and populates the text
  /// controllers with the fetched data. If no users with the role "Manager" are
  /// found, a message is printed to the console.
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

  /// Saves the changes made to the user profile data.
  ///
  /// This method updates the user data in Firestore with the values from the
  /// text controllers. It shows a success message if the changes are saved
  /// successfully, or prints an error message if there is an error.
  ///
  /// [context] is the BuildContext used to show a SnackBar with a success message.
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
          content: Text('Changes saved successfully!'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
      notifyListeners();
    } catch (error) {
      print('Error saving changes: $error');
    }
  }
}
