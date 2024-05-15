import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:project/services/network_service.dart';

/// View model for managing product data.
class InsertProductViewModel with ChangeNotifier {

  final NetworkService _networkService = NetworkService();

  String? _selectedCategory;
  String? get selectedCategory => _selectedCategory;


  List<String> _categories = [];
  String? _imagePath;
  String? _productId;
  String? _productName;
  int _quantity = 0;
  DateTime? _expDate;

  /// Getters for product properties.
  String? get imagePath => _imagePath;
  String? get productId => _productId;
  String? get productName => _productName;
  int get quantity => _quantity;
  DateTime? get expDate => _expDate;
  List<String> get categories => _categories;


  void updateCategory(List<String> category){
    _categories = category;
    notifyListeners();
  }
  /// Update the image path.
  void updateImagePath(String path) {
    _imagePath = path;
    notifyListeners();
  }

  /// Update the product name.
  void updateProductName(String name) {
    _productName = name;
    notifyListeners();
  }

  /// Update the product ID.
  void updateProductId(String id) {
    _productId = id;
    notifyListeners();
  }

  /// Setter for quantity.
  set quantity(int newValue) {
    _quantity = newValue;
    notifyListeners();
  }

  /// Increment the quantity.
  void incrementQuantity() {
    _quantity++;
    notifyListeners();
  }

  /// Decrement the quantity.
  void decrementQuantity() {
    if (_quantity > 0) {
      _quantity--;
      notifyListeners();
    }
  }

  /// Update the expiration date.
  void updateExpDate(DateTime date) {
    _expDate = date;
    notifyListeners();
  }

  /// Scan a QR code to update the product ID.
  Future<void> scanBarCode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      'Cancel',
      false,
      ScanMode.BARCODE,
    );
    updateProductId(barcodeScanRes);
  }

  /// Save the product data.
  Future<void> saveProduct() async {
    DateTime dateAdded = DateTime.now();

    Map<String, dynamic> data = {
      'imagePath': _imagePath,
      'productId': _productId,
      'productName': _productName,
      'quantity': _quantity,
      'expDate': _expDate,
      'category': _selectedCategory,
      'created_at': dateAdded,

    };

    try {
      await NetworkService().sendData('products', data);
      resetFields();
      print('Product inserted successfully');
    } catch (error) {
      print('Failed to insert product: $error');
    }
  }

  /// Reset all fields to their initial values.
  void resetFields() {
    _imagePath = null;
    _productId = null;
    _productName = null;
    _quantity = 0;
    _expDate = null;

    _productId = '';
    _productName = '';

    notifyListeners();
  }

  InsertProductViewModel() {
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      List<Map<String, dynamic>> result = await _networkService.fetchAll('Categories');
      _categories = result.map<String>((doc) => doc!['name'] as String).toList();
      notifyListeners();
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  void updateSelectedCategory(String? category) {
    _selectedCategory = category;
    notifyListeners();
  }
}
