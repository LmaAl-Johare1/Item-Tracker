import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/Services/network_service.dart';

class MyHomePageViewModel extends ChangeNotifier {
  int _total = 0;
  int _productIn = 0;
  int _productOut = 0;
  int _totalSupplied = 0;
  DateTime _lastReset = DateTime.now();
  final NetworkService _networkService = NetworkService();

  int get total => _total;
  int get productIn => _productIn;
  int get productOut => _productOut;
  int get totalSupplied => _totalSupplied;
  DateTime get lastReset => _lastReset;

  set total(int value) {
    _total = value;
    notifyListeners();
  }

  set productIn(int value) {
    _productIn = value;
    notifyListeners();
  }

  set productOut(int value) {
    _productOut = value;
    notifyListeners();
  }

  set totalSupplied(int value) {
    _totalSupplied = value;
    notifyListeners();
  }

  set lastReset(DateTime value) {
    _lastReset = value;
    notifyListeners();
  }

  Future<void> initialize() async {
    await updateProductInCount();
    listenForProductInsertions();
    checkAndAggregateQuantities();
  }

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
    FirebaseFirestore.instance.collection('products').snapshots().listen(
          (snapshot) {
        int productInQuantity = 0;
        int totalQuantity = 0;

        DateTime now = DateTime.now();

        snapshot.docs.forEach((doc) {
          if (doc.data().containsKey('created_at')) {
            Timestamp createdAtTimestamp = doc['created_at'];
            DateTime createdAt = createdAtTimestamp.toDate();

            if (createdAt.day == now.day &&
                createdAt.month == now.month &&
                createdAt.year == now.year) {
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
      },
      onError: (error) {
        print('Error fetching Product insertions: $error');
      },
    );
  }

  void checkAndAggregateQuantities() {
    FirebaseFirestore.instance
        .collection('products')
        .where('supply_date', isGreaterThanOrEqualTo: DateTime.now().subtract(Duration(days: 1)))
        .snapshots()
        .listen(
          (snapshot) {
        int productOutQuantity = 0;
        DateTime now = DateTime.now();

        snapshot.docs.forEach((doc) {
          if (doc.data().containsKey('supply_date')) {
            Timestamp supplyTimestamp = doc['supply_date'];
            DateTime supplyDate = supplyTimestamp.toDate();

            if (supplyDate.day == now.day &&
                supplyDate.month == now.month &&
                supplyDate.year == now.year) {
              int quantity = doc['supplied_quantity'] ?? 0;
              productOutQuantity += quantity;
            }
          }
        });

        _productOut = productOutQuantity;
        notifyListeners();
      },
      onError: (error) {
        print('Error fetching products: $error');
      },
    );
  }

  void updateProductOut(int suppliedQuantity) {
    _productOut += suppliedQuantity;
    _productIn -= suppliedQuantity;
    _totalSupplied += suppliedQuantity;
    notifyListeners();
  }

  void resetProductOutCounter() {
    _productOut = 0;
    _lastReset = DateTime.now();
    notifyListeners();
  }
}
