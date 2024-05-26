import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  final String description;
  final DateTime date;
  final String operation;

  Report({
    required this.description,
    required this.date,
    required this.operation,
  });

  factory Report.fromMap(Map<String, dynamic> data) {
    return Report(
      description: data['description'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      operation: data['operation'] ?? '',
    );
  }
}
