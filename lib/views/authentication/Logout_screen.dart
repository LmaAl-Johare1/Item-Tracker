import 'package:flutter/material.dart';
import 'package:project/res/AppColor.dart';
import 'package:project/res/AppText.dart';
import'package:project/views/authentication/login_screen.dart';
class Logout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _selectedIndex = 0;  // Keeps track of the selected index in the bottom nav

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),  // Increased height
        child: AppBar(
          flexibleSpace: Padding(
            padding: EdgeInsets.only(top: 40),  // Adjust the padding here
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Setting',
                style: TextStyle(
                  fontSize: AppText.headingOne.fontSize,
                  fontWeight: AppText.headingOne.fontWeight,
                  color: AppColor.primary,  // Assuming AppColor.primary is blue
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            padding: EdgeInsets.only(top: 35),
            icon: Icon(Icons.arrow_back_ios, color: AppColor.primary),  // Blue arrow
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(22),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ListTile(
              title: Text(
                'Add account',
                style: TextStyle(
                  fontSize: AppText.headingTwo.fontSize,
                  fontWeight: AppText.headingTwo.fontWeight,
                  color: AppColor.primary,  // Blue text
                ),
                textAlign: TextAlign.center,
              ),
              trailing: Icon(
                Icons.navigate_next,
                color: AppColor.primary,  // Blue icon
                size: 35,
              ),
              onTap: () {},
            ),
          ),
          SizedBox(height: 370),
          Container(
            margin: EdgeInsets.all(22),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),

            child: ListTile(
              title: Text(
                'Logout',
                style: TextStyle(
                  fontSize: AppText.headingTwo.fontSize,
                  fontWeight: AppText.headingTwo.fontWeight,
                  color: AppColor.validation,  // Assuming AppColor.secondary is red
                ),
              ),
              leading: Icon(
                  Icons.logout,
                  color: AppColor.productInfo ,  // Red icon
                  size: 40
              ),
              onTap: () {
                // Navigate to the login page
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
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
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}