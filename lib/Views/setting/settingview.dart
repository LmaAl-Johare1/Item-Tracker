import 'package:flutter/material.dart';
import 'package:project/res/AppColor.dart';
import 'package:project/res/AppText.dart';
import 'package:project/ViewModels/authentication/settingviewmodel.dart';

import '../dashboard/DashboardView.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _selectedIndex = 2;
  final settingviewmodel _authService = settingviewmodel();


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (_selectedIndex) {
      case 0:
        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ReportsPage()));
        break;
      case 1:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
        break;
      case 2:
      // Already on Settings Page
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Setting', style: TextStyle(
          fontSize: AppText.headingOne.fontSize,
          fontWeight: AppText.headingOne.fontWeight,
          color: AppColor.primary,
        )),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height:0),
          Container(
            margin: EdgeInsets.all(22),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
              title: Text('Add account', style: TextStyle(
                  fontSize: AppText.headingTwo.fontSize,
                  fontWeight: AppText.headingTwo.fontWeight,
                  color: AppColor.primary
              ), textAlign: TextAlign.center),
              trailing: Icon(
                  Icons.navigate_next,
                  color: AppColor.primary,
                  size:35
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/ChangePasswordView  ');
              },
            ),
          ),
          SizedBox(height: 380),
          Container(
            margin: EdgeInsets.all(22),
            padding: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
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
              title: Text('Logout', style: TextStyle(
                  fontSize: AppText.headingTwo.fontSize,
                  fontWeight: AppText.headingTwo.fontWeight,
                  color: AppColor.validation
              )),
              leading: Icon(
                  Icons.logout,
                  color: AppColor.productInfo,
                  size:40
              ),

              onTap: () {
                _authService.signOut(context);

              },// Navigate to the LoginPage


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