import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/services/network_service.dart';

class MyHomePageViewModel extends ChangeNotifier {
  int _total = 0;
  int _productIn = 0;
  int _productOut = 0;
  final NetworkService _networkService = NetworkService();

  int get total => _total;

  int get productIn => _productIn;

  int get productOut => _productOut;

  Future<void> updateProductInCount() async {
    try {
      int totalQuantity = 0;

      QuerySnapshot productsSnapshot =
      await FirebaseFirestore.instance.collection('products').get();

      productsSnapshot.docs.forEach((doc) {
        int quantity = doc['quantity'] ?? 0;
        totalQuantity += quantity;
      });

      _total = totalQuantity;
      notifyListeners();
    } catch (e, stackTrace) {
      print('Error: $e');
      print(stackTrace);
    }
  }

  void listenForProductInsertions() {
    FirebaseFirestore.instance
        .collection('products')
        .snapshots()
        .listen((snapshot) {
      int productInQuantity = 0;
      int productOutQuantity = 0;
      int totalQuantity = 0;

      DateTime now = DateTime.now();

      snapshot.docs.forEach((doc) {
        if (doc.data().containsKey('created_at')) {
          Timestamp createdAtTimestamp = doc['created_at'];
          DateTime createdAt = createdAtTimestamp.toDate();

          if (createdAt.day == now.day) {
            int quantity = doc['quantity'] ?? 0;
            productInQuantity += quantity;
          }
        }

        int quantity = doc['quantity'] ?? 0;
        totalQuantity += quantity;
      });

      _productIn = productInQuantity;
      _total = totalQuantity;
      notifyListeners();
    }, onError: (error) {
      print('Error fetching product insertions: $error');
    });
  }

  void checkAndAggregateQuantities() {
    FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((querySnapshot) {
      int productOutQuantity = 0; // Initialize productOutQuantity
      querySnapshot.docs.forEach((doc) {
        if (doc.data().containsKey('supply_date')) {
          Timestamp supplyTimestamp = doc['supply_date'];
          DateTime supplyDate = supplyTimestamp.toDate();

          if (supplyDate.day == DateTime
              .now()
              .day) {
            int quantity = doc['quantity'] ?? 0;
            productOutQuantity += quantity;
          }
        }
      });

      // Update productOut quantity
      _productOut = productOutQuantity;

      // Subtract productOut quantity from total
      _total -= productOutQuantity;


      notifyListeners();
    }).catchError((error) {
      print('Error fetching products: $error');
    });
  }

}
