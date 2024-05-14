import 'package:cloud_firestore/cloud_firestore.dart';

class NetworkService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  /// Sends data to the specified [collection].
  ///
  /// Returns a [Map<String, dynamic>] representing the response data including the document ID.
  ///
  /// Throws a [FirebaseException] if the request fails
  Future<Map<String, dynamic>> sendData(String collection,
      Map<String, dynamic> data) async {
    try {
      DocumentReference documentReference = await _firestore.collection(
          collection).add(data);
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

  Future<List<Map<String, dynamic>>> fetchAll(String collection) async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection(collection)
          .get();
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e, stackTrace) {
      throw FirebaseException(plugin: 'Firestore',
          message: 'Failed to fetch data: $e',
          stackTrace: stackTrace);
    }
  }

  Future<List<DocumentSnapshot>> fetchProductsByCategory(
      String category) async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('products')
          .where('category', isEqualTo: category)
          .get();
      return snapshot.docs;
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }


}
