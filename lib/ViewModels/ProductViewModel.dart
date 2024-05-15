import 'package:flutter/material.dart';
import '../services/network_service.dart';
import '../models/product.dart';

class ProductViewModel extends ChangeNotifier {
  final NetworkService _networkService = NetworkService();
  Product? product;

  Future<void> fetchProduct(String productId) async {
    try {
      print('Fetching product in ViewModel with ID: $productId');
      final data = await _networkService.fetchData('products', 'productId', productId);
      if (data.isEmpty) {
        print('No data returned for product ID: $productId');
        throw Exception('Product not found');
      }
      product = Product.fromMap(data, productId);
      print('Fetched product: $product');
      notifyListeners();
    } catch (error) {
      print('Error fetching product: $error');
    }
  }
}
