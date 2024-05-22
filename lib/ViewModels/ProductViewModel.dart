import 'package:flutter/material.dart';
import '../Services/network_service.dart';
import '../Models/Product.dart';

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

  Future<void> updateProduct(String productId, Map<String, dynamic> updatedData) async {
    try {
      print('Updating product with ID: $productId');
      await _networkService.updateData('products', 'productId', productId, updatedData);
      print('Product updated successfully');
      // Optionally, fetch the updated product to refresh the local state
      await fetchProduct(productId);
    } catch (error) {
      print('Error updating product: $error');
    }
  }

}
