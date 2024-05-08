import 'package:cloud_firestore/cloud_firestore.dart';

/// Model class to interact with the Firestore database specifically for user-related data.
///
/// This class provides methods to interact with the 'Users' collection in Firestore.
/// It handles database operations such as checking if the users collection is empty.
class UserModel {
  /// Instance of FirebaseFirestore used to perform Firestore operations.
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// Checks if the 'Users' collection in Firestore is empty.
  ///
  /// This method queries the 'Users' collection and returns true if there are no documents,
  /// indicating the collection is empty.
  ///
  /// Returns:
  ///   - `true` if the 'Users' collection is empty.
  ///   - `false` if the 'Users' collection contains one or more documents.
  Future<bool> isUsersCollectionEmpty() async {
    final querySnapshot = await firestore.collection('Users').limit(1).get();
    return querySnapshot.docs.isEmpty;
  }
}
