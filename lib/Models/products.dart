import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String productId;
  final String productName;
  final int quantity;
  final DateTime expDate;
  final String imagePath;

  Product({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.expDate,
    required this.imagePath,
  });

  factory Product.fromMap(Map<String, dynamic> data, String productId) {
    return Product(
      productId: productId,
      productName: data['productName'] ?? 'Unknown Product',
      quantity: data['quantity'] ?? 0,
      expDate: (data['expDate'] as Timestamp).toDate(),
      imagePath: data['imagePath'] ?? '', // Assuming imagePath is stored as a URL
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'quantity': quantity,
      'expDate': expDate,
      'imagePath': imagePath,
    };
  }
}
