import 'package:flutter/material.dart';

class ProductViewModel extends ChangeNotifier {
  String productName = '';
  String productID = '';
  int quantity = 0;
  DateTime? expirationDate;

  void setProductName(String name) {
    productName = name;
    notifyListeners();
  }

  void setProductID(String id) {
    productID = id;
    notifyListeners();
  }

  void increaseQuantity() {
    quantity++;
    notifyListeners();
  }

  void decreaseQuantity() {
    if (quantity > 0) {
      quantity--;
      notifyListeners();
    }
  }

  void setExpirationDate(DateTime date) {
    expirationDate = date;
    notifyListeners();
  }

  void saveProduct() {
    // Here you could add your logic to save the product details
    print("Product Saved: $productName, $productID, $quantity, $expirationDate");
  }
}