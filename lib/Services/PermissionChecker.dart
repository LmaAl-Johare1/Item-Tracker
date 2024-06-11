import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Services/UserService.dart';

class PermissionChecker {
  final UserService _userService;

  PermissionChecker(this._userService);

  Widget canAccessFeature(BuildContext context, dynamic allowedRoles, Widget featureWidget) {
    return FutureBuilder<String?>(
      future: _userService.fetchUserRole(FirebaseAuth.instance.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          _showPermissionDeniedDialog(context);
          return SizedBox.shrink();
        } else {
          final userRole = snapshot.data;
          if (userRole == null || !allowedRoles.contains(userRole)) {
            _showPermissionDeniedDialog(context);
            return SizedBox.shrink();
          } else {
            return featureWidget;
          }
        }
      },
    );
  }

  void _showPermissionDeniedDialog(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Permission Denied'),
            content: Text('You are not authorized to access this page.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Future.microtask(() {
                    Navigator.pop(context);
                  });
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }
}
