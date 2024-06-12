import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'network_service.dart';

/// Service class to handle user-related operations.
class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final NetworkService _networkService = NetworkService();

  /// Fetches the role of a user based on their user ID.
  ///
  /// [userId] - The ID of the user whose role needs to be fetched.
  ///
  /// Returns the role of the user as a [String], or null if the user data is not found.
  Future<String?> fetchUserRole(String userId) async {
    try {
      final userData = await _networkService.fetchData('Users', 'userId', userId);
      if (userData.isEmpty) {
        print('No data found for user id: $userId');
        return null;
      }

      final userRole = userData['user_role'];
      print('User role: $userRole');
      return userRole;
    } catch (e) {
      print('Error fetching user role: $e');
      return null;
    }
  }
}
