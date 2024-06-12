import 'package:flutter/material.dart';
import '../../Models/products.dart';
import '../../Services/network_service.dart';

/// ViewModel for managing product-related operations.
///
/// This class provides methods to fetch and update product data
/// using a network service.
class ProductViewModel extends ChangeNotifier {
  final NetworkService _networkService = NetworkService();
  Product? product;

  /// Fetches product data from the network service using the given product ID.
  ///
  /// This method retrieves the product data from Firestore and updates the
  /// local product state. It throws an exception if the product is not found.
  ///
  /// [productId] The ID of the product to fetch.
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

  /// Updates product data in the network service using the given product ID and updated data.
  ///
  /// This method updates the product data in Firestore and optionally fetches
  /// the updated product to refresh the local state.
  ///
  /// [productId] The ID of the product to update.
  /// [updatedData] A map containing the updated product data.
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
