import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  final String id;
  final String operation;
  final DateTime date;
  final String description;
  String productName;

  Report({
    required this.id,
    required this.operation,
    required this.date,
    required this.description,
    this.productName = '',
  });

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      id: map['id'] ?? '',
      operation: map['operation'] ?? '',
      date: (map['date'] as Timestamp).toDate(), // Convert Timestamp to DateTime
      description: map['description'] ?? '',
      productName: map['productName'] ?? '', // Add this line to include productName
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'operation': operation,
      'date': date,
      'description': description,
      'productName': productName,
    };
  }
}
