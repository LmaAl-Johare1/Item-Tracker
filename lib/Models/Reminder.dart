import 'package:cloud_firestore/cloud_firestore.dart';

class Reminder {
  final String id;
  final String productId;
  final String productName;
  final int currentStock;
  final DateTime timestamp;
  final bool acknowledged;

  Reminder({
    required this.id,
    required this.productId,
    required this.productName,
    required this.currentStock,
    required this.timestamp,
    this.acknowledged = false,
  });

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