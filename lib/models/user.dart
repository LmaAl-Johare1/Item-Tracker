import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> isUsersCollectionEmpty() async {
    final querySnapshot = await firestore.collection('Users').limit(1).get();
    return querySnapshot.docs.isEmpty;
  }
}

