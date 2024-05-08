import 'package:flutter/material.dart';
import 'package:project/Views/authentication/LoginView.dart';
import 'package:project/res/AppText.dart';
import 'package:project/res/AppColor.dart';

import '../setting/settingview.dart';

/// Represents a reminder with a title and a date/time.
class Reminder {
  final String title;
  final DateTime dateTime;

  /// Constructs a [Reminder] instance with the given [title] and [dateTime].
  Reminder({required this.title, required this.dateTime});
}

/// Represents the home page of the application.
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _total = 200;
  int _productIn = 10;
  int _productOut = 20;
  List<Reminder> _reminders = [];

  /// Adds a reminder with the given [title] and [dateTime] to the list of reminders.
  void _addReminder(String title, DateTime dateTime) {
    setState(() {
      _reminders.add(Reminder(title: title, dateTime: dateTime));
    });
  }

  int _selectedIndex = 0;

  /// Handles the selection of items in the bottom navigation bar.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
        // Navigate to Reports page
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
          break;
        case 1:
        // (Home)
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyHomePage()));
          break;
        case 2:
        // Navigate to Settings page
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SettingsPage()));
          break;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.white,
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                      children: <Widget>[
                        SizedBox(height: 50),
                        Text(
                          'Dashboard',
                          style: AppText.headingOne.copyWith(color: AppColor.primary),
                        ),
                        SizedBox(height: 30), // Add space before the first Container
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 25), // Margin to add space from screen edges
                              child: Container(
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 8), // Padding for the first Container
                                decoration: BoxDecoration(
                                  color: AppColor.greylight,
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.inventory, size: 30, color: AppColor.primary,
                                        ),
                                        SizedBox(width: 15),
                                        Text(
                                          'Total:                      $_total',
                                          style: AppText.headingThree.copyWith(color: AppColor.primary),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [//payment
                                        Icon(Icons.file_upload_outlined, size: 30, color: AppColor.primary), // Icon for Total
                                        SizedBox(width: 15),
                                        Text(
                                          'Product In:              $_productIn',
                                          style: AppText.headingThree.copyWith(color: AppColor.primary),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20), // Add spacing between sections
                                    Row(
                                      children: [
                                        Icon(Icons.file_download_outlined,   size: 30,color: AppColor.primary), // Icon for Product In
                                        SizedBox(width: 15), // Adjust spacing between icon and text
                                        Text(
                                          'Product Out:             $_productOut',
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
                                  children: [//notifications_none_outlined
                                    Icon(Icons.notifications_none_outlined, color: AppColor.productInfo, size: 30),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8), // Adjust the left padding as needed
                                      child: Text(
                                        'Reminders',
                                        style: AppText.headingThree.copyWith(color: AppColor.primary),
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(), // Added to allow the last icon to align to the end
                                    ),
                                    Icon(Icons.arrow_forward_ios, color: AppColor.primary),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 3), // Add space between the Reminders Container and the "Go to Charts" section
                            SizedBox(height: 10), // Add space between the two Containers
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  // Add code here to navigate to the Charts view
                                },
                                style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all(AppColor.primary),
                                  overlayColor: MaterialStateProperty.all(AppColor.primary.withOpacity(0.1)), // Adjust overlay color as needed
                                  textStyle: MaterialStateProperty.all(
                                    AppText.headingTwo.copyWith(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Go to Charts',
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20), // Add space after the second Container
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 165,
                                  height: 65,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.primary, // Background color
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(17),
                                      ),
                                    ),
                                    onPressed: () {

                                    },
                                    child: Center(
                                      child: Text('View Category', style: TextStyle(fontSize: 16, color: AppColor.secondary)), // Adjusted font size
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 165,
                                  height: 65,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.primary, // Background color
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(17),
                                      ),
                                    ),
                                    onPressed: () {
                                      // Add code here to navigate to the View Category view
                                    },
                                    child: Center(
                                      child: Text('Insert Product', style: TextStyle(fontSize: 16, color: AppColor.secondary)), // Adjusted font size
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 165,
                                  height: 65,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.primary, // Background color
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(17),
                                      ),
                                    ),
                                    onPressed: () {
                                      // Add code here to insert a new product
                                    },
                                    child: Center(
                                      child: Text('supply product', style: TextStyle(fontSize: 16, color: AppColor.secondary)), // Adjusted font size
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 165,
                                  height: 65,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.primary, // Background color
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(17),
                                      ),
                                    ),
                                    onPressed: () {
                                      // Add code here to generate a barcode
                                    },
                                    child: Center(
                                      child: Text('Generate Barcode', style: TextStyle(fontSize: 14, color: AppColor.secondary)), // Adjusted font size
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],

                        ),
                      ]),
                ),

              )],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: AppColor.greylight,  selectedItemColor: Colors.black, // Set the color of the selected item to black

        onTap: _onItemTapped,
      ),
    );
  }
}
