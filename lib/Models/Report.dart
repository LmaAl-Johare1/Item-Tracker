import 'package:cloud_firestore/cloud_firestore.dart';

/// A class representing a Report with various attributes.
class Report {
  /// The ID of the report.
  final String id;

  /// The operation associated with the report.
  final String operation;

  /// The date of the report.
  final DateTime date;

  /// The description of the report.
  final String description;

  /// The name of the product associated with the report, if any.
  String productName;

  /// Constructs a Report instance.
  ///
  /// The [id], [operation], [date], and [description] parameters are required.
  /// The [productName] parameter is optional and defaults to an empty string.
  Report({
    required this.id,
    required this.operation,
    required this.date,
    required this.description,
    this.productName = '',
  });

  /// Creates a Report instance from a Map object.
  ///
  /// The [map] parameter should be a Map<String, dynamic> containing the report data.
  /// Returns a Report instance with the data from the Map object.
  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      id: map['id'] ?? '',
      operation: map['operation'] ?? '',
      date: (map['date'] as Timestamp).toDate(), // Convert Timestamp to DateTime
      description: map['description'] ?? '',
      productName: map['productName'] ?? '', // Add this line to include productName
    );
  }

  /// Converts the Report instance to a Map object.
  ///
  /// Returns a Map<String, dynamic> representing the report data.
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
