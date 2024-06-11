import 'package:flutter/material.dart';
import 'package:project/Models/Report.dart';
import '../../Services/network_service.dart';

class ReportViewModel extends ChangeNotifier {
  final NetworkService _networkService = NetworkService();
  List<Report> report = [];
  List<Report> filteredReport = [];
  bool isLoading = false;

  Future<void> fetchTransactions() async {
    isLoading = true;
    notifyListeners();

    try {
      final data = await _networkService.fetchAll('Reports');
      if (data.isNotEmpty) {
        report = data.map((e) => Report.fromMap(e)).toList();
        filteredReport = report;
        print('Fetched reports: $report'); // Debug print
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

  void searchTransactions(String query) {
    if (query.isEmpty) {
      filteredReport = report;
    } else {
      filteredReport = report.where((report) {
        final operationLower = report.operation.toLowerCase();
        final searchLower = query.toLowerCase();
        return operationLower.contains(searchLower);
      }).toList();
    }
    print('Search results: $filteredReport'); // Debug print
    notifyListeners();
  }

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
