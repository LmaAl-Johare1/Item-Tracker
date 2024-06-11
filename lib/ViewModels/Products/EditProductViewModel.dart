import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProductViewModel extends ChangeNotifier {
  String? imagePath;
  String? productName;
  String? productId;
  int quantity = 1;
  DateTime? expDate;
  String? selectedCategory;

  List<String> categories = [];

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productIdController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController expDateController = TextEditingController();

  EditProductViewModel(String initialProductId) {
    productId = initialProductId;
    loadProductData(initialProductId);
    loadCategories();
  }

  @override
  void dispose() {
    productNameController.dispose();
    productIdController.dispose();
    quantityController.dispose();
    expDateController.dispose();
    super.dispose();
  }

  Future<void> loadProductData(String productId) async {
    if (productId.isEmpty) {
      print('Product ID is empty');
      return;
    }

    try {
      DocumentSnapshot productDoc = await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .get();

      if (productDoc.exists) {
        Map<String, dynamic> productData = productDoc.data() as Map<String, dynamic>;

        productName = productData['productName'];
        this.productId = productData['productId'];
        quantity = productData['quantity'];
        expDate = (productData['expDate'] as Timestamp).toDate();
        selectedCategory = productData['category'];
        imagePath = productData['imagePath'];

        productNameController.text = productName ?? '';
        productIdController.text = this.productId ?? '';
        quantityController.text = quantity.toString();
        expDateController.text = expDate?.toLocal().toString().split(' ')[0] ?? '';

        notifyListeners();
      } else {
        print('Product not found');
      }
    } catch (e) {
      print('Error loading product data: $e');
    }
  }

  Future<void> loadCategories() async {
    try {
      QuerySnapshot categorySnapshot = await FirebaseFirestore.instance
          .collection('Categories')
          .get();

      categories = categorySnapshot.docs
          .map((doc) => doc['name'] as String)
          .toList();

      notifyListeners();
    } catch (e) {
      print('Error loading categories: $e');
    }
  }

  Future<void> updateImagePath(String path) async {
    imagePath = path;
    notifyListeners();
  }

  void updateProductName(String name) {
    productName = name;
    notifyListeners();
  }

  void updateProductId(String id) {
    productId = id;
    notifyListeners();
  }

  void incrementQuantity() {
    quantity++;
    notifyListeners();
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
      notifyListeners();
    }
  }

  void updateExpDate(DateTime date) {
    expDate = date;
    expDateController.text = expDate!.toLocal().toString().split(' ')[0];
    notifyListeners();
  }

  void updateSelectedCategory(String? category) {
    selectedCategory = category;
    notifyListeners();
  }

  Future<void> saveProduct() async {
    try {
      await FirebaseFirestore.instance.collection('products').doc(productId).update({
        'productName': productName,
        'productId': productId,
        'quantity': quantity,
        'expDate': expDate,
        'category': selectedCategory,
        'imagePath': imagePath,
      });
      print('Product updated successfully');
    } catch (e) {
      print('Error saving product: $e');
    }
  }
}
