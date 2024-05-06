import 'package:flutter/foundation.dart';

class ProductViewModel extends ChangeNotifier {
  String productName = '';
  String productId = '';
  int _quantity = 0;
  DateTime? expDate;
  int get quantity => _quantity;

  void updateProductName(String name) {
    productName = name;
    notifyListeners();
  }

  void updateProductId(String id) {
    productId = id;
    notifyListeners();
  }

  set quantity(int newValue) {
    _quantity = newValue;
    notifyListeners();
  }

  void incrementQuantity() {
    _quantity++;
    notifyListeners();
  }

  void decrementQuantity() {
    if (_quantity > 0) {
      _quantity--;
      notifyListeners();
    }
  }

  void updateQuantityFromString(String value) {
    int? newValue = int.tryParse(value);
    if (newValue != null) {
      _quantity = newValue;
      notifyListeners();
    }
  }

  void setExpDate(DateTime date) {
    expDate = date;
    notifyListeners();
  }

  void saveProduct() {
    // Implement saving logic
    print("Product Saved: $productName, $productId, $quantity, $expDate");
  }
}
