import 'package:flutter/material.dart';
import 'package:project/Models/Report.dart';
import '../../Services/network_service.dart';

class ReportViewModel extends ChangeNotifier {
  final NetworkService _networkService = NetworkService();
  List<Report> report = [];
  bool isLoading = false;
  List<Report> filteredReport = [];

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

  // void searchTransactions(String query) {
  //   if (query.isEmpty) {
  //     filteredReport = report;
  //   } else {
  //     filteredReport = report.where((transaction) {
  //       return transaction.operation.toLowerCase().contains('insert product') &&
  //           transaction.description.toLowerCase().contains(query.toLowerCase());
  //     }).toList();
  //   }
  //   notifyListeners();
  // }
  //
  // void filterTransactions(String operation) {
  //   if (operation.isEmpty) {
  //     filteredReport = report;
  //   } else {
  //     filteredReport = report.where((transaction) => transaction.operation.toLowerCase() == operation.toLowerCase()).toList();
  //   }
  //   notifyListeners();
  // }
}
