import 'package:flutter/material.dart';
import 'package:project/res/AppColor.dart';
import 'package:project/res/AppText.dart';
import '../../ViewModels/authentication/SignoutViewModel.dart';
import '../Report/ReportView.dart';
import '../dashboard/DashboardView.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final settingviewmodel _authService = settingviewmodel();
  int _selectedIndex = 2;

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
          SizedBox(height: 0),
          _buildSettingsTile(
            title: 'Profile',
            onTap: () {
              Navigator.pushReplacementNamed(context, '/managerProfile');
            },
          ),
          _buildSettingsTile(
            title: 'Add account',
            onTap: () {
              Navigator.pushReplacementNamed(context, '/signup');
            },
          ),
          _buildSettingsTile(
            title: 'Delete account',
            onTap: () {
              Navigator.pushReplacementNamed(context, '/deleteAccount');
            },
          ),
          _buildSettingsTile(
            title: 'Change Password',
            onTap: () {
              Navigator.pushReplacementNamed(context, '/changePassword');
            },
          ),
          SizedBox(height: 300),
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
                color: AppColor.validation,
              )),
              leading: Icon(
                Icons.logout,
                color: AppColor.productInfo,
                size: 40,
              ),
              onTap: () {
                _authService.signOut(context);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFD9D9D9),
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

  Widget _buildSettingsTile({required String title, required VoidCallback onTap}) {
    return Container(
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
        title: Text(title, style: TextStyle(
          fontSize: AppText.headingTwo.fontSize,
          fontWeight: AppText.headingTwo.fontWeight,
          color: AppColor.primary,
        ), textAlign: TextAlign.center),
        trailing: Icon(
          Icons.navigate_next,
          color: AppColor.primary,
          size: 35,
        ),
        onTap: onTap,
      ),
    );
  }
}
