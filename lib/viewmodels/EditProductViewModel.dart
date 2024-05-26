import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Models/products.dart';
import '../Services/network_service.dart';

class EditProductViewModel extends ChangeNotifier {
  final NetworkService _networkService = NetworkService();
  late Product product;

  EditProductViewModel(Product product) {
    this.product = product;
  }

  Future<void> updateProduct(String productId, Map<String, dynamic> updatedData) async {
    try {
      print('Updating product with productId: $productId');
      print('Updated data: $updatedData');

      // Fetch the document based on productId
      final productData = await _networkService.fetchData('products', 'productId', productId);
      if (productData.isEmpty) {
        print('Document with productId $productId does not exist.');
        return;
      }

      // Update the document
      await _networkService.updateData('products', 'productId', productId, updatedData);

      // Verify the update
      final updatedProductData = await _networkService.fetchData('products', 'productId', productId);
      if (updatedProductData.isNotEmpty) {
        product = Product.fromMap(updatedProductData, productId);
        notifyListeners();
        print('Product updated successfully');
      } else {
        print('Failed to fetch updated product.');
      }
    } catch (error) {
      print('Error updating product: $error');
    }
  }
}
