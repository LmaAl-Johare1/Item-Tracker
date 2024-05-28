import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../Services/network_service.dart';

class ChartViewModel extends ChangeNotifier {
  List<SalesData> _data = [];
  bool _isDataLoaded = false;
  final NetworkService _networkService = NetworkService();

  List<SalesData> get data => _data;
  bool get isDataLoaded => _isDataLoaded;

  Future<void> loadData(String filter) async {
    try {
      List<Map<String, dynamic>> fetchedData = await _networkService.fetchAll('products');

      // Clear existing data
      _data.clear();

      if (filter == 'Near Sold Out') {
        fetchedData = _filterByNearSoldOut(fetchedData);
        _data = fetchedData.map((item) => SalesData(item['productName'], item['quantity'])).toList();
      } else if (filter == 'Expiration Date Proximity') {
        _data = _filterByExpirationDateProximity(fetchedData);
      }

      _isDataLoaded = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading data: $e');
    }
  }

  List<Map<String, dynamic>> _filterByNearSoldOut(List<Map<String, dynamic>> products) {
    return products.where((product) => product['quantity'] < 10).toList();
  }

  List<SalesData> _filterByExpirationDateProximity(List<Map<String, dynamic>> products) {
    DateTime now = DateTime.now();

    return products.where((product) {
      try {
        Timestamp timestamp = product['expDate']; // Assuming 'expDate' is the field containing the expiration date

        // Convert Timestamp to DateTime
        DateTime expirationDate = timestamp.toDate();

        // Calculate remaining days
        Duration difference = expirationDate.difference(now);
        int remainingDays = difference.inDays;

        // Debug print for verification
        debugPrint('Product: ${product['productName']}, Expiration Date: $expirationDate, Now: $now, Remaining Days: $remainingDays');

        // Include product if remaining days is within the desired range
        return remainingDays > 0 && remainingDays <= 8;
      } catch (e) {
        debugPrint('Error processing product ${product['productName']}: $e');
        return false;
      }
    }).map((product) {
      Timestamp timestamp = product['expDate'];
      DateTime expirationDate = timestamp.toDate();
      int remainingDays = expirationDate.difference(DateTime.now()).inDays;
      return SalesData(product['productName'], remainingDays);
    }).toList();
  }
}

class SalesData {
  SalesData(this.product, this.value);

  final String product;
  final int value;

  @override
  String toString() {
    return '{Product: $product, Value: $value}';
  }
}