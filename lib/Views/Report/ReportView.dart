import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:project/ViewModels/Report/ReportViewModel.dart';
import 'package:project/Views/dashboard/DashboardView.dart';
import 'package:provider/provider.dart';
import 'package:project/Models/Report.dart';

import '../../res/AppColor.dart';
import '../../res/AppText.dart';
import '../Setting/SettingView.dart';
import 'DataSearch.dart';

class ReportView extends StatefulWidget {
  @override
  _ReportViewState createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ReportView()));
    } else if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
    }
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final viewModel = Provider.of<ReportViewModel>(context, listen: false);
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      viewModel.filterTransactionsByDate(selectedDate);
      print('Filtered by date: $selectedDate');
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) { // Ensure the build method is implemented
    final localizations = AppLocalizations.of(context)!;

    return ChangeNotifierProvider(
      create: (_) => ReportViewModel()..fetchTransactions(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            localizations.reports,
            style: TextStyle(
              color: AppColor.primary,
              fontSize: AppText.HeadingOne.fontSize,
              fontWeight: AppText.HeadingOne.fontWeight,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                final viewModel = Provider.of<ReportViewModel>(context, listen: false);
                await viewModel.fetchTransactions();
                showSearch(context: context, delegate: DataSearch(viewModel.report));
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                // children: [
                //   Expanded(
                //     child: Container(
                //       height: 50,
                //
                //     ),
                //   ),
                //   SizedBox(width: 10),
                //   // GestureDetector(
                //   //   onTap: () {
                //   //     _showDatePicker(context);
                //   //   },
                //   //   child: Container(
                //   //     height: 50,
                //   //     width: 50,
                //   //     padding: EdgeInsets.all(10.0),
                //   //     decoration: BoxDecoration(
                //   //       color: Colors.white,
                //   //       borderRadius: BorderRadius.circular(10.0),
                //   //       boxShadow: [
                //   //         BoxShadow(
                //   //           color: Colors.grey.withOpacity(0.5),
                //   //           spreadRadius: 2,
                //   //           blurRadius: 5,
                //   //           offset: Offset(0, 3),
                //   //         ),
                //   //       ],
                //   //     ),
                //   //     child: Icon(Icons.filter_list),
                //   //   ),
                //   // ),
                // ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Consumer<ReportViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (viewModel.filteredReport.isEmpty) {
                    return Center(
                      child: Text(
                        "noReportsFound",
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: viewModel.filteredReport.length,
                    itemBuilder: (context, index) {
                      final transaction = viewModel.filteredReport[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: Text(localizations.transactionDetails),
                                  content: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('${localizations.operation}: ${transaction.operation}'),
                                      SizedBox(height: 8.0),
                                      Text('${localizations.date}: ${transaction.date.toLocal()}'),
                                      SizedBox(height: 8.0),
                                      Text('${localizations.description}: ${transaction.description}'),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(localizations.close),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${localizations.operation}: ${transaction.operation}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8.0),
                                Text('${localizations.date}: ${transaction.date.toLocal()}'),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFFD9D9D9),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.insert_chart),
              label: localizations.reports,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: localizations.home,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: localizations.settings,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
