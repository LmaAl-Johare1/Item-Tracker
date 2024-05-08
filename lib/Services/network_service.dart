import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NetworkService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  /// Fetches data from the specified [collection] and [documentId].
  ///
  /// Returns a [Map<String, dynamic>] representing the fetched data.
  ///
  /// Throws a [FirebaseException] if the request fails.
  Future<Map<String, dynamic>> fetchData(String collection,
      String documentId) async {
    try {
      final doc = await _firestore.collection(collection).doc(documentId).get();
      return doc.data() ?? {};
    } catch (e, stackTrace) {
      throw FirebaseException(plugin: 'Firestore',
          message: 'Failed to fetch data: $e',
          stackTrace: stackTrace);
    }
  }


  /// Sends data to the specified [collection] and [documentId].



  /// Sends data to the specified [collection].
  ///
  /// Returns a [Map<String, dynamic>] representing the response data including the document ID.
  ///
  /// Throws a [FirebaseException] if the request fails.
  Future<Map<String, dynamic>> sendData(String collection,
      Map<String, dynamic> data) async {

    try {
      DocumentReference documentReference = await _firestore.collection(collection).add(data);
      return {...data, 'documentId': documentReference.id};
    } catch (e, stackTrace) {
      throw FirebaseException(plugin: 'Firestore',
          message: 'Failed to send data: $e',
          stackTrace: stackTrace);
    }
  }


  /// Updates data at the specified [collection] and [documentId].
  ///
  /// Returns a [Map<String, dynamic>] representing the response data.
  ///
  /// Throws a [FirebaseException] if the request fails.
  Future<Map<String, dynamic>> updateData(String collection, String documentId,
      Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).doc(documentId).update(data);
      return data;
    } catch (e, stackTrace) {
      throw FirebaseException(plugin: 'Firestore',
          message: 'Failed to update data: $e',
          stackTrace: stackTrace);
    }
  }

  /// Deletes data at the specified [collection] and [documentId].
  ///
  /// Throws a [FirebaseException] if the request fails.
  Future<void> deleteData(String collection, String documentId) async {
    try {
      await _firestore.collection(collection).doc(documentId).delete();
    } catch (e, stackTrace) {
      throw FirebaseException(plugin: 'Firestore',
          message: 'Failed to delete data: $e',
          stackTrace: stackTrace);
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      // You could throw a more specific error or handle it differently
      throw Exception('Failed to send reset email: ${e.message}');
    }
  }

  Future<void> updatePassword(String newPassword) async {
    User? currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      try {
        await currentUser.updatePassword(newPassword);
        await currentUser.reload(); // Optional: refresh user information
      } on FirebaseAuthException catch (e) {
        throw Exception('Failed to update password: ${e.message}');
      }
    } else {
      throw Exception('No user logged in.');
    }
  }

  /// Checks if an email exists in the user's collection.
  Future<bool> emailExists(String email) async {
    try {
      var result = await _firestore.collection('Users').where('email', isEqualTo: email).limit(1).get();
      return result.docs.isNotEmpty; // True if there is at least one document
    } catch (e, stackTrace) {
      throw FirebaseException(plugin: 'Firestore', message: 'Failed to check email existence: $e', stackTrace: stackTrace);
    }
  }
}

