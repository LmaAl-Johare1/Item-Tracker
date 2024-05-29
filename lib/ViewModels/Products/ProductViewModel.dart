import 'package:flutter/material.dart';
import '../../Models/products.dart';
import '../../Services/network_service.dart';

class ProductViewModel extends ChangeNotifier {
  final NetworkService _networkService = NetworkService();
  Product? product;

  Future<void> fetchProduct(String productId) async {
    try {
      print('Fetching Product in ViewModel with ID: $productId');
      final data = await _networkService.fetchData('products', 'productId', productId);
      if (data.isEmpty) {
        print('No data returned for Product ID: $productId');
        throw Exception('Product not found');
      }
      product = Product.fromMap(data, productId);
      print('Fetched Product: $product');
      notifyListeners();
    } catch (error) {
      print('Error fetching Product: $error');
    }
  }

  Future<void> updateProduct(String productId, Map<String, dynamic> updatedData) async {
    try {
      print('Updating Product with ID: $productId');
      await _networkService.updateData('products', 'productId', productId, updatedData);
      print('Product updated successfully');
      // Optionally, fetch the updated Product to refresh the local state
      await fetchProduct(productId);
    } catch (error) {
      print('Error updating Product: $error');
    }
  }

}