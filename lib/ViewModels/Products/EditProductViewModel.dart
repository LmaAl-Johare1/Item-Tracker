import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

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
  File? _imageFile;
  String? _imageUrl;

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

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: source);
    if (pickedImage != null) {
      _imageFile = File(pickedImage.path);
      imagePath = pickedImage.path; // Update imagePath with local path
      notifyListeners();
    }
  }

  Future<void> uploadImage(BuildContext context) async {
    if (_imageFile == null) return;
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      String fileName = path.basename(_imageFile!.path);
      Reference ref = storage.ref().child('product_images/$fileName');
      UploadTask uploadTask = ref.putFile(_imageFile!);
      TaskSnapshot taskSnapshot = await uploadTask;
      _imageUrl = await taskSnapshot.ref.getDownloadURL();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Image uploaded successfully'),
      ));
      notifyListeners();
    } catch (ex) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(ex.toString()),
      ));
    }
  }

  Future<void> saveProduct(BuildContext context) async {
    await uploadImage(context);

    Map<String, dynamic> updatedData = {
      'productName': productNameController.text,
      'quantity': int.parse(quantityController.text),
      'expDate': Timestamp.fromDate(expDate!),
      'imagePath': _imageUrl ?? imagePath, // Use uploaded image URL if available
    };
    await updateProduct(product.productId, updatedData);
  }

  Future<void> deleteProduct(BuildContext context) async {
    try {
      await _networkService.deleteData('products', 'productId', product.productId);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Product deleted successfully'),
      ));
      Navigator.pop(context, true); // Return true to indicate success
      Navigator.pop(context); // Go back to products view screen
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to delete product: $error'),
      ));
    }
  }
}
