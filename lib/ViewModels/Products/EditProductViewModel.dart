import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Models/products.dart';
import '../../Services/network_service.dart';

class EditProductViewModel extends ChangeNotifier {
  final NetworkService _networkService = NetworkService();
  late Product product;

  EditProductViewModel(this.product) {
    productNameController.text = product.productName;
    quantityController.text = product.quantity.toString();
    expDate = product.expDate.toDate();
    imagePath = product.imagePath; // Initialize imagePath
  }

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  DateTime? expDate;
  String? imagePath; // Make imagePath nullable

  Future<void> updateProduct(String productId, Map<String, dynamic> updatedData) async {
    try {
      // Fetch the document based on productId
      final productData = await _networkService.fetchData('products', 'productId', productId);
      if (productData.isEmpty) {
        return;
      }

      // Update the document
      await _networkService.updateData('products', 'productId', productId, updatedData);

      // Verify the update
      final updatedProductData = await _networkService.fetchData('products', 'productId', productId);
      if (updatedProductData.isNotEmpty) {
        product = Product.fromMap(updatedProductData, productId);
        notifyListeners();
      }
    } catch (error) {
      print('Error updating Product: $error');
    }
  }

  void updateProductName(String value) {
    product.productName = value;
    notifyListeners();
  }

  void updateQuantity(String value) {
    product.quantity = int.parse(value);
    notifyListeners();
  }

  void updateExpDate(DateTime? date) {
    expDate = date;
    notifyListeners();
  }

  void updateImagePath(String path) {
    imagePath = path;
    notifyListeners();
  }

  Future<void> saveProduct() async {
    Map<String, dynamic> updatedData = {
      'productName': productNameController.text,
      'quantity': int.parse(quantityController.text),
      'expDate': Timestamp.fromDate(expDate!),
      'imagePath': imagePath, // Include imagePath
    };
    await updateProduct(product.productId, updatedData);
  }
}
