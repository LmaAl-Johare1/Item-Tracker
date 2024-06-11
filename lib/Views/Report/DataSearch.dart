import 'package:flutter/material.dart';
import 'package:project/Models/Report.dart';

class DataSearch extends SearchDelegate<String> {
  final List<Report> reports;

  DataSearch(this.reports);

  Future<List<Report>> getsearchdata(String query) async {
    // Filter reports locally by productName and operation
    return reports.where((report) {
      final operationLower = report.operation.toLowerCase();
      final productNameLower = report.productName.toLowerCase();
      final searchLower = query.toLowerCase();
      return operationLower.contains(searchLower) || productNameLower.contains(searchLower);
    }).toList();
  }

  void _showReportDetails(BuildContext context, Report report) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Operation Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Operation: ${report.operation}'),
              SizedBox(height: 8.0),
              Text('Date: ${report.date.toLocal()}'),
              SizedBox(height: 8.0),
              Text('Description: ${report.description}'),
              SizedBox(height: 8.0),
              Text('Product Name: ${report.productName}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Report>>(
      future: getsearchdata(query),
      builder: (BuildContext context, AsyncSnapshot<List<Report>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No results found.'));
        } else {
          return Container(
            color: Colors.white, // Set background color to white
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, i) {
                final report = snapshot.data![i];
                return ListTile(
                  title: Text(report.productName),
                  subtitle: Text(report.operation),
                  onTap: () {
                    _showReportDetails(context, report); // Show details popup
                  },
                );
              },
            ),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? reports
        : reports.where((report) {
      final operationLower = report.operation.toLowerCase();
      final productNameLower = report.productName.toLowerCase();
      final searchLower = query.toLowerCase();
      return operationLower.contains(searchLower) || productNameLower.contains(searchLower);
    }).toList();

    return Container(
      color: Colors.white, // Set background color to white
      child: ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          final report = suggestionList[index];
          return ListTile(
            title: Text(report.productName),
            subtitle: Text(report.operation),
            onTap: () {
              query = report.productName;
              showResults(context);
            },
          );
        },
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the app bar
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, ""); // Use an empty string instead of null
      },
    );
  }
}
