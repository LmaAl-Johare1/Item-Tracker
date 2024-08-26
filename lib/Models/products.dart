import 'package:cloud_firestore/cloud_firestore.dart';

/// A class representing a Product with various attributes.
class Product {
  /// The ID of the product.
  String productId;

  /// The name of the product.
  String productName;

  /// The quantity of the product in stock.
  int quantity;

  /// The expiration date of the product.
  Timestamp expDate;

  /// The optional image path of the product.
  String? imagePath;

  /// Constructs a Product instance.
  ///
  /// The [productId], [productName], [quantity], and [expDate] parameters are required.
  /// The [imagePath] parameter is optional and represents the path to the product's image.
  Product({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.expDate,
    this.imagePath,
  });

  /// Creates a Product instance from a Map object.
  ///
  /// The [data] parameter should be a Map<String, dynamic> containing the product data.
  /// The [id] parameter represents the product ID.
  /// Returns a Product instance with the data from the Map object.
  factory Product.fromMap(Map<String, dynamic> data, String id) {
    return Product(
      productId: id,
      productName: data['productName'],
      quantity: data['quantity'],
      expDate: data['expDate'],
      imagePath: data['imagePath'],
    );
  }

  /// Converts the Product instance to a Map object.
  ///
  /// Returns a Map<String, dynamic> representing the product data.
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'expDate': expDate,
      'imagePath': imagePath,
    };
  }
}
