import 'package:flutter/material.dart';
import 'package:project/Models/Report.dart';
import '../../Services/network_service.dart';

/// ViewModel for managing and filtering reports.
///
/// This class handles fetching reports from the database, searching through the reports,
/// and filtering the reports by date.
class ReportViewModel extends ChangeNotifier {
  /// Instance of NetworkService to handle database operations.
  final NetworkService _networkService = NetworkService();

  /// List of all reports fetched from the database.
  List<Report> report = [];

  /// List of filtered reports based on search query or date.
  List<Report> filteredReport = [];

  /// Boolean to indicate if the reports are currently being fetched.
  bool isLoading = false;

  /// Fetches all transactions (reports) from the database.
  ///
  /// This method fetches all reports from the 'Reports' collection in Firestore,
  /// sorts them by date in descending order (latest first), and updates the local lists.
  Future<void> fetchTransactions() async {
    isLoading = true;
    notifyListeners();

    try {
      final data = await _networkService.fetchAll('Reports');
      if (data.isNotEmpty) {
        report = data.map((e) => Report.fromMap(e)).toList();

        // Sort the reports by date in descending order (latest first)
        report.sort((a, b) => b.date.compareTo(a.date));

        filteredReport = report;
        print('Fetched and sorted reports: $report'); // Debug print
      } else {
        print('No data in Reports collection');
      }
    } catch (e) {
      print("Error fetching transactions: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Searches through the transactions based on a query.
  ///
  /// This method filters the reports based on whether the query matches the operation
  /// or product name of a report. If the query is empty, it resets the filtered reports to the full list.
  ///
  /// [query] - The search query to filter the reports.
  void searchTransactions(String query) {
    if (query.isEmpty) {
      filteredReport = report;
    } else {
      filteredReport = report.where((report) {
        final operationLower = report.operation.toLowerCase();
        final productNameLower = report.productName.toLowerCase();
        final searchLower = query.toLowerCase();
        return operationLower.contains(searchLower) || productNameLower.contains(searchLower);
      }).toList();
    }
    print('Search results: $filteredReport'); // Debug print
    notifyListeners();
  }

  /// Filters the transactions based on a selected date.
  ///
  /// This method filters the reports to only include those that match the selected date.
  ///
  /// [selectedDate] - The date to filter the reports by.
  void filterTransactionsByDate(DateTime selectedDate) {
    filteredReport = report.where((report) {
      return report.date.year == selectedDate.year &&
          report.date.month == selectedDate.month &&
          report.date.day == selectedDate.day;
    }).toList();
    print('Filtered reports by date: $filteredReport'); // Debug print
    notifyListeners();
  }
}
