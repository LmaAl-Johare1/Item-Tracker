import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

import '../../Models/products.dart';
import '../../Services/network_service.dart';

/// ViewModel for editing a product.
///
/// This class provides functionality to edit and update product details, including product name, quantity,
/// expiration date, and product image.
class EditProductViewModel extends ChangeNotifier {
  final NetworkService _networkService = NetworkService();
  late Product product;

  /// Constructor to initialize the EditProductViewModel with the given product.
  ///
  /// Sets up initial values for the text controllers and expiration date based on the given product.
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

  /// Updates the product details in Firestore.
  ///
  /// Fetches the document based on productId, updates the document with the given data, and verifies the update.
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

  /// Updates the product name.
  ///
  /// Notifies listeners about the change.
  void updateProductName(String value) {
    product.productName = value;
    notifyListeners();
  }

  /// Updates the product quantity.
  ///
  /// Notifies listeners about the change.
  void updateQuantity(String value) {
    product.quantity = int.parse(value);
    notifyListeners();
  }

  /// Updates the product expiration date.
  ///
  /// Notifies listeners about the change.
  void updateExpDate(DateTime? date) {
    expDate = date;
    notifyListeners();
  }

  /// Updates the image path.
  ///
  /// Notifies listeners about the change.
  void updateImagePath(String path) {
    imagePath = path;
    notifyListeners();
  }

  /// Picks an image from the specified source and updates the image path.
  ///
  /// Notifies listeners about the change.
  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: source);
    if (pickedImage != null) {
      _imageFile = File(pickedImage.path);
      imagePath = pickedImage.path; // Update imagePath with local path
      notifyListeners();
    }
  }

  /// Uploads the selected image to Firebase Storage and updates the image URL.
  ///
  /// Displays a success or error message based on the upload result.
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

  /// Saves the updated product details.
  ///
  /// Uploads the selected image (if any) and updates the product details in Firestore.
  Future<void> saveProduct(BuildContext context) async {
    await uploadImage(context);

    Map<String, dynamic> updatedData = {
      'productName': productNameController.text,
      'quantity': int.parse(quantityController.text),
      'expDate': Timestamp.fromDate(expDate!),
      'imagePath': _imageUrl ?? imagePath,
    };
    await updateProduct(product.productId, updatedData);
  }
}