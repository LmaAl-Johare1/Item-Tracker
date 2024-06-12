import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Services/UserService.dart';
import 'AdminProfileView.dart';
import 'ProfileView.dart';
import 'StuffProfileView.dart';

class ProfileNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    final currentUser = FirebaseAuth.instance.currentUser;
    print('Current user: $currentUser');
    final Future<String?>? userRole = currentUser != null ? UserService().fetchUserRole(currentUser.uid) : null;

    return FutureBuilder<String?>(
      future: userRole,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          print('Error fetching user role: ${snapshot.error}');
          return Text('Error fetching user role');
        } else {
          final String? role = snapshot.data;
          print('User role: $role');
          switch (role) {
            case 'Admin':
              return ProfileAdmin();
            case 'Staff':
              return ProfileStuff();
            case 'Manager':
              return Profile();
            default:
              return Text('Unknown role');
          }
        }
      },
    );
  }
}
