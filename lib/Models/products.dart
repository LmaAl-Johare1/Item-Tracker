import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String productId;
  final String productName;
  final int quantity;
  final DateTime expDate;

  Product({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.expDate,
  });

  factory Product.fromMap(Map<String, dynamic> data, String productId) {
    return Product(
      productId: productId,
      productName: data['productName'] ?? 'Unknown Product',
      quantity: data['quantity'] ?? 0,
      expDate: (data['expDate'] as Timestamp).toDate(), // Convert Timestamp to DateTime
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'quantity': quantity,
      'expDate': expDate,
    };
  }
}