import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NetworkService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> fetchData(String collection, String field, String value) async {
    try {
      final querySnapshot = await _firestore.collection(collection)
          .where(field, isEqualTo: value)
          .limit(1)
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
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      // You could throw a more specific error or handle it differently
      throw Exception('Failed to send reset email: ${e.message}');
    }
  }
  Future<Map<String, dynamic>> sendData(String collection, Map<String, dynamic> data) async {
    try {
      DocumentReference documentReference = await _firestore.collection(collection).add(data);
      return {...data, 'documentId': documentReference.id};
    } catch (e, stackTrace) {
      throw FirebaseException(
        plugin: 'Firestore',
        message: 'Failed to send data: $e',
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> updateData(String collection, String field, String value, Map<String, dynamic> data) async {
    try {
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
      await FirebaseFirestore.instance.collection(collection).doc(documentId).update(data);
      print("Data updated successfully in Firestore");
    } catch (e, stackTrace) {
      throw FirebaseException(
        plugin: 'Firestore',
        message: 'Failed to update data: $e',
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> deleteData(String collection, String documentId) async {
    try {
      await _firestore.collection(collection).doc(documentId).delete();
    } catch (e, stackTrace) {
      throw FirebaseException(
        plugin: 'Firestore',
        message: 'Failed to delete data: $e',
        stackTrace: stackTrace,
      );
    }
  }

  Future<List<Map<String, dynamic>>> fetchAll(String collection) async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection(collection).get();
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e, stackTrace) {
      throw FirebaseException(
        plugin: 'Firestore',
        message: 'Failed to fetch data: $e',
        stackTrace: stackTrace,
      );
    }
  }

  Future<List<DocumentSnapshot>> fetchProductsByCategory(String category) async {
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

  Future<bool> emailExists(String email) async {
    try {
      var result = await _firestore.collection('Users').where('email', isEqualTo: email).limit(1).get();
      return result.docs.isNotEmpty; // True if there is at least one document
    } catch (e, stackTrace) {
      throw FirebaseException(plugin: 'Firestore', message: 'Failed to check email existence: $e', stackTrace: stackTrace);
    }
  }
}