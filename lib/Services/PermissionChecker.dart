import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Services/UserService.dart';

/// A utility class to check user permissions and access to certain features.
class PermissionChecker {
  final UserService _userService;

  /// Constructor to initialize the PermissionChecker with a UserService instance.
  PermissionChecker(this._userService);

  /// Checks if the current user has access to a feature based on their role.
  ///
  /// [context] - The BuildContext of the current widget.
  /// [allowedRoles] - A list of roles that are allowed to access the feature.
  /// [featureWidget] - The widget representing the feature to display if access is granted.
  ///
  /// Returns a FutureBuilder that checks the user's role and conditionally displays the featureWidget.
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

  /// Displays a permission denied dialog if the user is not authorized to access the feature.
  ///
  /// [context] - The BuildContext of the current widget.
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
