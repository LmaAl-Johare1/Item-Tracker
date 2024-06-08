import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project/res/AppText.dart';
import 'package:project/res/AppColor.dart';
import 'package:project/services/network_service.dart';
import 'package:provider/provider.dart';
import '../../Models/Reminder.dart';
import '../../ViewModels/Dashboard/DashboardViewModel.dart';
import '../Reminder/ReminderView.dart';
import '../Report/ReportView.dart';
import '../setting/SettingView.dart';
import '../../ViewModels/Reminder/ReminderViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer? _resetTimer;
  late RemindersViewModel _remindersViewModel;

  @override
  void initState() {
    super.initState();

    _remindersViewModel = RemindersViewModel();

    _resetTimer = Timer.periodic(Duration(hours: 24), (Timer timer) {
      final viewModel = Provider.of<MyHomePageViewModel>(context, listen: false);
      if (DateTime.now().difference(viewModel.lastReset).inHours >= 24) {
        viewModel.resetProductOutCounter();
      }
    });

    _checkReminders();
  }

  void _checkReminders() async {
    await _remindersViewModel.fetchReminders();
    _remindersViewModel.reminders.forEach((reminder) {
      if (reminder.currentStock <= 5) {
        _showNotification(reminder);
      }
    });
  }

  void _showNotification(Reminder reminder) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${reminder.productName} is low on stock!',
        ),
        action: SnackBarAction(
          label: 'View',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RemindersView()),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _resetTimer?.cancel();
    super.dispose();
  }

  int _selectedIndex = 1;

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

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final viewModel = Provider.of<MyHomePageViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.white,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                Text(
                  localizations!.dashboardTitle,
                  style: AppText.headingOne.copyWith(color: AppColor.primary),
                ),
                const SizedBox(height: 30),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 8),
                        decoration: BoxDecoration(
                          color: AppColor.greylight,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.inventory,
                                      size: 30,
                                      color: AppColor.primary,
                                    ),
                                    const SizedBox(width: 15),
                                    Text(
                                      localizations.total,
                                      style: AppText.headingThree.copyWith(color: AppColor.primary),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${viewModel.total}',
                                  style: AppText.headingThree.copyWith(color: AppColor.primary),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.file_upload_outlined,
                                        size: 30, color: AppColor.primary),
                                    const SizedBox(width: 15),
                                    Text(
                                      localizations.productIn,
                                      style: AppText.headingThree.copyWith(color: AppColor.primary),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${viewModel.productIn}',
                                  style: AppText.headingThree.copyWith(color: AppColor.primary),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.file_download_outlined,
                                        size: 30, color: AppColor.primary),
                                    const SizedBox(width: 15),
                                    Text(
                                      localizations.productOut,
                                      style: AppText.headingThree.copyWith(color: AppColor.primary),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${viewModel.productOut}',
                                  style: AppText.headingThree.copyWith(color: AppColor.primary),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(25),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RemindersView()),
                          );
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(20, 10, 20, 8)),
                          backgroundColor: MaterialStateProperty.all(AppColor.greylight),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.notifications_none_outlined,
                                color: AppColor.productInfo, size: 30),
                            Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Text(
                                localizations.reminders,
                                style: AppText.headingThree.copyWith(color: AppColor.primary),
                              ),
                            ),
                            const Expanded(
                              child: SizedBox(),
                            ),
                            const Icon(Icons.arrow_forward_ios, color: AppColor.primary),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 13),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/charts');
                        },
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all(AppColor.primary),
                          overlayColor: MaterialStateProperty.all(AppColor.primary.withOpacity(0.1)),
                          textStyle: MaterialStateProperty.all(
                            AppText.headingTwo.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(localizations.goToCharts),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 165,
                          height: 65,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/Category');
                            },
                            child: Center(
                              child: Text(localizations.viewCategory,
                                  style: TextStyle(fontSize: 14, color: Colors.white)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 165,
                          height: 65,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/insertProduct');
                            },
                            child: Center(
                              child: Text(localizations.insertProduct,
                                  style: TextStyle(fontSize: 14, color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 165,
                          height: 65,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/supplyProduct');
                            },
                            child: Center(
                              child: Text(localizations.supplyProduct,
                                  style: TextStyle(fontSize: 14, color: Colors.white)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 165,
                          height: 65,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/generateBarcode');
                            },
                            child: Center(
                              child: Text(localizations.generateBarcode,
                                  style: TextStyle(fontSize: 14, color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
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
    );
  }
}
