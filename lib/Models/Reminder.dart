import 'package:cloud_firestore/cloud_firestore.dart';

/// A class representing a Reminder with various attributes.
class Reminder {
  /// The ID of the reminder.
  final String id;

  /// The ID of the associated product.
  final String productId;

  /// The name of the associated product.
  final String productName;

  /// The current stock of the product.
  final int currentStock;

  /// The timestamp of when the reminder was created.
  final DateTime timestamp;

  /// Whether the reminder has been acknowledged.
  final bool acknowledged;

  /// Constructs a Reminder instance.
  ///
  /// The [id], [productId], [productName], [currentStock], and [timestamp] parameters are required.
  /// The [acknowledged] parameter is optional and defaults to false.
  Reminder({
    required this.id,
    required this.productId,
    required this.productName,
    required this.currentStock,
    required this.timestamp,
    this.acknowledged = false,
  });

  /// Creates a Reminder instance from a Map object.
  ///
  /// The [data] parameter should be a Map<String, dynamic> containing the reminder data.
  /// The [documentId] parameter represents the reminder ID.
  /// Returns a Reminder instance with the data from the Map object.
  factory Reminder.fromMap(Map<String, dynamic>? data, String documentId) {
    if (data == null) {
      throw ArgumentError('Data cannot be null');
    }

    return Reminder(
      id: documentId,
      productId: data['productId'] ?? '',
      productName: data['productName'] ?? 'Unknown',
      currentStock: data['currentStock'] ?? 0,
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      acknowledged: data['acknowledged'] ?? false,
    );
  }

  /// Converts the Reminder instance to a Map object.
  ///
  /// Returns a Map<String, dynamic> representing the reminder data.
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'currentStock': currentStock,
      'timestamp': timestamp,
      'acknowledged': acknowledged,
    };
  }
}
