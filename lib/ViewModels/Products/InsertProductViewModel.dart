import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:project/services/network_service.dart';
import 'package:project/utils/validators.dart';
/// ViewModel for inserting products.
class InsertProductViewModel with ChangeNotifier {
  final NetworkService _networkService = NetworkService();

  String? _selectedCategory;
  List<String> _categories = [];
  String? _imagePath;
  String? _productId;
  String? _productName;
  int _quantity = 0;
  DateTime? _expDate;

  String? _productNameError;
  String? _productIdError;
  String? _quantityError;
  String? _expDateError;
  String? _categoryError;

  /// Getters
  String? get selectedCategory => _selectedCategory;

  String? get imagePath => _imagePath;

  String? get productId => _productId;

  String? get productName => _productName;

  int get quantity => _quantity;

  DateTime? get expDate => _expDate;

  List<String> get categories => _categories;

  String? get productNameError => _productNameError;

  String? get productIdError => _productIdError;

  String? get quantityError => _quantityError;

  String? get expDateError => _expDateError;

  String? get categoryError => _categoryError;

  /// Initializes the view model by fetching categories.
  InsertProductViewModel() {
    fetchCategories();
  }

  /// Updates the list of categories.
  void updateCategory(List<String> category) {
    _categories = category;
    notifyListeners();
  }

  /// Updates the image path.
  void updateImagePath(String path) {
    _imagePath = path;
    notifyListeners();
  }

  /// Updates the product name.
  void updateProductName(String name) {
    _productName = name;
    _productNameError = null;
    notifyListeners();
  }

  /// Updates the product ID.
  void updateProductId(String id) {
    _productId = id;
    _productIdError = null;
    notifyListeners();
  }

  /// Sets the quantity and validates it.
  set quantity(int newValue) {
    _quantity = newValue;
    _validateQuantity();
    notifyListeners();
  }

  /// Increments the quantity by 1.
  void incrementQuantity() {
    _quantity++;
    _validateQuantity();
    notifyListeners();
  }

  /// Decrements the quantity by 1 if it's greater than 0.
  void decrementQuantity() {
    if (_quantity > 0) {
      _quantity--;
      _validateQuantity();
      notifyListeners();
    }
  }

  /// Updates the expiration date.
  void updateExpDate(DateTime date) {
    _expDate = date;
    _expDateError = null;
    notifyListeners();
  }

  /// Scans a barcode and updates the product ID.
  Future<void> scanBarCode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      'Cancel',
      false,
      ScanMode.BARCODE,
    );
    updateProductId(barcodeScanRes);
  }

  /// Saves the product data.
  Future<bool> saveProduct() async {
    DateTime dateAdded = DateTime.now();
    bool success = false;

    if (!_validateFields()) {
      print('Please fill in all required fields.');
      return success;
    }

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
      await _networkService.checkAndUpdateProduct(_productId!, data);
      final reportData = {
        'operation': 'Insert Product',
        'date': DateTime.now(),
        'description': 'Inserted Product $_productName with quantity $_quantity',
      };
      await _networkService.sendData('Reports', reportData);
      resetFields();

      print('Product inserted successfully');
      success = true;
    } catch (error) {
      print('Failed to insert Product: $error');
    }

    return success;
  }


  /// Validates all fields before saving.
  bool _validateFields() {
    bool isValid = true;

    if (Validators.isFieldEmptyOrNull(_productName)) {
      _productNameError = 'Product name cannot be empty';
      isValid = false;
    }

    if (Validators.isFieldEmptyOrNull(_productId)) {
      _productIdError = 'Product ID cannot be empty';
      isValid = false;
    }

    if (_quantity <= 0) {
      _quantityError = 'Quantity must be greater than 0';
      isValid = false;
    }

    if (_expDate == null) {
      _expDateError = 'Expiration date must be selected';
      isValid = false;
    }

    if (_selectedCategory == null) {
      _categoryError = 'Category must be selected';
      isValid = false;
    }

    if (!isValid) {
      notifyListeners();
    }

    return isValid;
  }

  /// Validates the quantity.
  void _validateQuantity() {
    if (_quantity <= 0) {
      _quantityError = 'Quantity must be greater than 0';
    } else {
      _quantityError = null;
    }
  }

  /// Resets all fields.
  void resetFields() {
    _imagePath = null;
    _productId = null;
    _productName = null;
    _quantity = 0;
    _expDate = null;

    _productNameError = null;
    _productIdError = null;
    _quantityError = null;
    _expDateError = null;
    _categoryError = null;

    notifyListeners();
  }

  /// Fetches categories from the network service.
  Future<void> fetchCategories() async {
    try {
      List<Map<String, dynamic>> result = await _networkService.fetchAll('Categories');
      _categories = result.map<String>((doc) => doc['name'] as String).toList();
      notifyListeners();
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  /// Updates the selected category.
  void updateSelectedCategory(String? category) {
    _selectedCategory = category;
    _categoryError = null;
    notifyListeners();
  }
}