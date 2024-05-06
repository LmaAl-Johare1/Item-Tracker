import 'package:cloud_firestore/cloud_firestore.dart';

class NetworkService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Fetches data from the specified [collection] and [documentId].
  ///
  /// Returns a [Map<String, dynamic>] representing the fetched data.
  ///
  /// Throws a [FirebaseException] if the request fails.
  Future<Map<String, dynamic>> fetchData(String collection, String documentId) async {
    try {
      final doc = await _firestore.collection(collection).doc(documentId).get();
      return doc.data() ?? {};
    } catch (e, stackTrace) {
      throw FirebaseException(plugin: 'Firestore', message: 'Failed to fetch data: $e', stackTrace: stackTrace);
    }
  }
  /// Sends data to the specified [collection] and [documentId].
  ///
  /// Returns a [Map<String, dynamic>] representing the response data.
  ///
  /// Throws a [FirebaseException] if the request fails.
  Future<Map<String, dynamic>> sendData(String collection, String documentId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).doc(documentId).set(data);
      return data;
    } catch (e, stackTrace) {
      throw FirebaseException(plugin: 'Firestore', message: 'Failed to send data: $e', stackTrace: stackTrace);
    }
  }

  /// Updates data at the specified [collection] and [documentId].
  ///
  /// Returns a [Map<String, dynamic>] representing the response data.
  ///
  /// Throws a [FirebaseException] if the request fails.
  Future<Map<String, dynamic>> updateData(String collection, String documentId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).doc(documentId).update(data);
      return data;
    } catch (e, stackTrace) {
      throw FirebaseException(plugin: 'Firestore', message: 'Failed to update data: $e', stackTrace: stackTrace);
    }
  }

  /// Deletes data at the specified [collection] and [documentId].
  ///
  /// Throws a [FirebaseException] if the request fails.
  Future<void> deleteData(String collection, String documentId) async {
    try {
      await _firestore.collection(collection).doc(documentId).delete();
    } catch (e, stackTrace) {
      throw FirebaseException(plugin: 'Firestore', message: 'Failed to delete data: $e', stackTrace: stackTrace);
    }
  }
}
