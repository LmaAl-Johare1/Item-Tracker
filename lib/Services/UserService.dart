import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'network_service.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final NetworkService _networkService = NetworkService();

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