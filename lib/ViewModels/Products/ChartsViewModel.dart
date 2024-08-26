import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../Services/network_service.dart';
import 'ProductData.dart';

/// View model class for managing chart data.
class ChartViewModel extends ChangeNotifier {
  List<ProductData> _data = [];
  bool _isDataLoaded = false;
  final NetworkService _networkService = NetworkService();

  /// Getter for accessing the chart data.
  List<ProductData> get data => _data;

  /// Getter for checking if the data is loaded.
  bool get isDataLoaded => _isDataLoaded;

  /// Loads data based on the provided filter.
  Future<void> loadData(String filter) async {
    try {
      List<Map<String, dynamic>> fetchedData = await _networkService.fetchAll('products');

      _data.clear();

      if (filter == 'Near Sold Out') {
        fetchedData = _filterByNearSoldOut(fetchedData);
        _data = fetchedData.map((item) => ProductData(item['productName'], item['quantity'], 0)).toList();
      } else if (filter == 'Expiration Date Proximity') {
        _data = _calculateRemainingDays(fetchedData);
      }

      _isDataLoaded = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading data: $e');
    }
  }

  /// Filters products that are near sold out.
  List<Map<String, dynamic>> _filterByNearSoldOut(List<Map<String, dynamic>> products) {
    return products.where((product) => product['quantity'] < 10).toList();
  }

  /// Calculates remaining days for products based on expiration date.
  List<ProductData> _calculateRemainingDays(List<Map<String, dynamic>> products) {
    return products.map((product) {
      try {
        Timestamp timestamp = product['expDate'];

        DateTime expirationDate = timestamp.toDate();

        Duration difference = expirationDate.difference(DateTime.now());
        int remainingDays = difference.inDays;

        return ProductData(product['productName'], 0, remainingDays);
      } catch (e) {
        debugPrint('Error processing Product ${product['productName']}: $e');
        return ProductData('', 0, 0);
      }
    }).toList();
  }
}