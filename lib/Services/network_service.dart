import 'package:cloud_firestore/cloud_firestore.dart';

class NetworkService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Fetches data from the specified [collection] and [documentId].
  ///
  /// Returns a [Map<String, dynamic>] representing the fetched data.
  ///
  /// Throws a [FirebaseException] if the request fails.
  // Future<Map<String, dynamic>> fetchData(String collection, String documentId) as, String productIdync {
  //   try {
  //     final doc = await _firestore.collection(collection).doc(documentId).get();
  //     return doc.data() ?? {};
  //   } catch (e, stackTrace) {
  //     throw FirebaseException(plugin: 'Firestore',
  //         message: 'Failed to fetch data: $e',
  //         stackTrace: stackTrace);
  //   }
  // }

  Future<Map<String, dynamic>> fetchData(String collection, String field, String value) async {
    try {
      final querySnapshot = await _firestore
          .collection(collection)
          .where(field, isEqualTo: value)
          .get();

      if (querySnapshot.docs.isEmpty) {
        print('No document found for $field: $value');
        return {};
      }

      final doc = querySnapshot.docs.first;
      print('Document data: ${doc.data()}');
      return doc.data()!;
    } catch (e, stackTrace) {
      throw FirebaseException(
        plugin: 'Firestore',
        message: 'Failed to fetch data: $e',
        stackTrace: stackTrace,
      );
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
  Future<void> updateData(String collection, String field, String value, Map<String, dynamic> data) async {
    try {
      print('Fetching document in collection: $collection where $field is $value');
      final querySnapshot = await FirebaseFirestore.instance
          .collection(collection)
          .where(field, isEqualTo: value)
          .get();
      if (querySnapshot.docs.isEmpty) {
        print('No document found for $field: $value');
        return;
      }
      final doc = querySnapshot.docs.first;
      final documentId = doc.id;
      print('Updating data in collection: $collection, document ID: $documentId, data: $data');

      await FirebaseFirestore.instance.collection(collection).doc(documentId).update(data);
      print("Data updated successfully in Firestore");
    } catch (e, stackTrace) {
      print('Failed to update data: $e');
      throw FirebaseException(
        plugin: 'Firestore',
        message: 'Failed to update data: $e',
        stackTrace: stackTrace,
      );
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