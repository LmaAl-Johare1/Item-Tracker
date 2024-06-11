import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NetworkService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> fetchData(String collection, String field, String value) async {
    try {
      print(
          'Fetching data from collection: $collection where $field equals $value');
      final querySnapshot = await _firestore
          .collection(collection)
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
      print('Failed to fetch data: $e');
      print('Stack trace: $stackTrace');
      throw FirebaseException(
        plugin: 'Firestore',
        message: 'Failed to fetch data: $e',
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      print('Attempting to send password reset email to: $email');
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      print('Password reset email sent successfully to: $email');
    } on FirebaseAuthException catch (e) {
      print('Failed to send reset email: ${e.message}');
      throw Exception('Failed to send reset email: ${e.message}');
    }
  }

  Future<Map<String, dynamic>> sendData(String collection, Map<String, dynamic> data) async {
    try {
      print('Attempting to send data to collection: $collection');
      DocumentReference documentReference =
      await _firestore.collection(collection).add(data);
      print('Data sent successfully with document ID: ${documentReference.id}');
      return {...data, 'documentId': documentReference.id};
    } catch (e, stackTrace) {
      print('Failed to send data: $e');
      print('Stack trace: $stackTrace');
      throw FirebaseException(
        plugin: 'Firestore',
        message: 'Failed to send data: $e',
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> checkAndUpdateProduct(String productId, Map<String, dynamic> data) async {
    try {
      print('Checking if product exists with ID: $productId');
      final existingProduct =
      await fetchData('products', 'productId', productId);
      if (existingProduct.isNotEmpty) {
        // Product with same ID exists, update quantity
        int newQuantity = existingProduct['quantity'] + data['quantity'];
        data['quantity'] = newQuantity; // Update quantity in data
        await updateData('products', 'productId', productId, data);
        print('Product with ID $productId exists, quantity updated');
      } else {
        // Product with same ID doesn't exist, create new document
        await sendData('products', data);
        print('Product with ID $productId does not exist, new product added');
      }
    } catch (e) {
      print('Failed to check and update product: $e');
    }
  }

  Future<void> updateData(String collection, String field, String value, Map<String, dynamic> data) async {
    try {
      print(
          'Updating data in collection: $collection where $field equals $value');
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
      await FirebaseFirestore.instance
          .collection(collection)
          .doc(documentId)
          .update(data);
      print(
          "Data updated successfully in Firestore with document ID: $documentId");
    } catch (e, stackTrace) {
      print('Failed to update data: $e');
      print('Stack trace: $stackTrace');
      throw FirebaseException(
        plugin: 'Firestore',
        message: 'Failed to update data: $e',
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> deleteData(String collection, String field, String value) async {
    try {
      print(
          'Attempting to delete document from collection: $collection where $field equals $value');
      final querySnapshot = await _firestore
          .collection(collection)
          .where(field, isEqualTo: value)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        print('No document found for $field: $value');
        return;
      }

      final doc = querySnapshot.docs.first;
      await _firestore.collection(collection).doc(doc.id).delete();
      print(
          'Document with ID: ${doc.id} deleted successfully from collection: $collection');
    } catch (e, stackTrace) {
      print('Failed to delete data: $e');
      print('Stack trace: $stackTrace');
      throw FirebaseException(
        plugin: 'Firestore',
        message: 'Failed to delete data: $e',
        stackTrace: stackTrace,
      );
    }
  }

  Future<List<Map<String, dynamic>>> fetchAll(String collection) async {
    try {
      print('Fetching all documents from collection: $collection');
      final QuerySnapshot snapshot = await _firestore.collection(collection).get();
      print('Fetched ${snapshot.docs.length} documents from collection: $collection');
      return snapshot.docs.map((doc) => {...doc.data() as Map<String, dynamic>, 'id': doc.id}).toList();
    } catch (e, stackTrace) {
      print('Failed to fetch data: $e');
      print('Stack trace: $stackTrace');
      throw FirebaseException(
        plugin: 'Firestore',
        message: 'Failed to fetch data: $e',
        stackTrace: stackTrace,
      );
    }
  }
  Future<List<DocumentSnapshot>> fetchProductsByCategory(String category) async {
    try {
      print(
          'Fetching products from collection: products where category equals $category');

      // Query the 'products' collection where the 'category' field matches the specified category
      QuerySnapshot snapshot = await _firestore
          .collection('products')
          .where('category', isEqualTo: category)
          .get();

      // Log the number of documents fetched
      print(
          'Fetched ${snapshot.docs.length} products from category: $category');

      // Return the list of document snapshots
      return snapshot.docs;
    } catch (e) {
      // Log the error if fetching fails
      print('Error fetching products: $e');

      // Return an empty list in case of an error
      return [];
    }
  }

  Future<bool> emailExists(String email) async {
    try {
      var result = await _firestore
          .collection('Users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();
      return result.docs.isNotEmpty;
    } catch (e, stackTrace) {
      print('Failed to check email existence: $e');
      print('Stack trace: $stackTrace');
      throw FirebaseException(
          plugin: 'Firestore',
          message: 'Failed to check email existence: $e',
          stackTrace: stackTrace);
    }
  }
  Future<void> updatePassword(String email, String newPassword) async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
        print('Password updated successfully for email: $email');
      }
    } catch (e, stackTrace) {
      print('Failed to update password: $e');
      print('Stack trace: $stackTrace');
      throw FirebaseException(
        plugin: 'FirebaseAuth',
        message: 'Failed to update password: $e',
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> updatePasswordInFirestore(String email, String newPassword) async {
    try {
      var result = await _firestore
          .collection('Users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();
      if (result.docs.isNotEmpty) {
        var doc = result.docs.first;
        await _firestore
            .collection('Users')
            .doc(doc.id)
            .update({'password': newPassword});
        print('Password updated successfully in Firestore for email: $email');
      }
    } catch (e, stackTrace) {
      print('Failed to update password in Firestore: $e');
      print('Stack trace: $stackTrace');
      throw FirebaseException(
        plugin: 'Firestore',
        message: 'Failed to update password in Firestore: $e',
        stackTrace: stackTrace,
      );
    }
  }

  Future<Map<String, dynamic>> fetchProductById(String productId) async {
    try {
      DocumentSnapshot doc =
      await _firestore.collection('products').doc(productId).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      } else {
        throw Exception("Product not found");
      }
    } catch (e) {
      throw Exception("Error fetching product by ID: $e");
    }
  }
}