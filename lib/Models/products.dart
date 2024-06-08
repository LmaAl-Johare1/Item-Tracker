import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String productId;
  String productName;
  int quantity;
  Timestamp expDate;
  String? imagePath; // Add this line

  Product({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.expDate,
    this.imagePath, // Add this line
  });

  // Add a method to convert from Map
  factory Product.fromMap(Map<String, dynamic> data, String id) {
    return Product(
      productId: id,
      productName: data['productName'],
      quantity: data['quantity'],
      expDate: data['expDate'],
      imagePath: data['imagePath'], // Add this line
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'expDate': expDate,
      'imagePath': imagePath, // Add this line
    };
  }
}
