import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final int quantity;
  final String? imagePath; // Make imagePath nullable
  final Timestamp expDate; // If you're using Firestore Timestamps

  Product({
    required this.id,
    required this.name,
    required this.quantity,
    this.imagePath,
    required this.expDate,
  });

  factory Product.fromMap(Map<String, dynamic> data, String documentId) {
    return Product(
      id: documentId,
      name: data['productName'] as String,
      quantity: data['quantity'] as int,
      imagePath: data['imagePath'] as String?,
      expDate: data['expDate'] as Timestamp,
    );
  }
}
