import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:project/res/AppColor.dart';
import 'package:project/res/AppText.dart';
import '../../ViewModels/Setting/SettingViewModel.dart';
import '../../main.dart';
import '../Report/ReportView.dart';
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
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ReportView()));
        break;
      case 1:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
        break;
      case 2:
      // Already on Settings Page
        break;
    }
  }

  void _changeLanguage(Locale locale) {
    MyAppState? appState = context.findAncestorStateOfType<MyAppState>();
    appState?.setLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!; // Retrieve localized strings

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          localizations.settings,
          style: TextStyle(
            fontSize: AppText.headingOne.fontSize,
            fontWeight: AppText.headingOne.fontWeight,
            color: AppColor.primary,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 0),
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
              title: Text(
                localizations.profile,
                style: TextStyle(
                  fontSize: AppText.headingTwo.fontSize,
                  fontWeight: AppText.headingTwo.fontWeight,
                  color: AppColor.primary,
                ),
                textAlign: TextAlign.center,
              ),
              trailing: Icon(
                Icons.navigate_next,
                color: AppColor.primary,
                size: 35,
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/Profile');
              },
            ),
          ),
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
              title: Text(
                localizations.addAccount,
                style: TextStyle(
                  fontSize: AppText.headingTwo.fontSize,
                  fontWeight: AppText.headingTwo.fontWeight,
                  color: AppColor.primary,
                ),
                textAlign: TextAlign.center,
              ),
              trailing: Icon(
                Icons.navigate_next,
                color: AppColor.primary,
                size: 35,
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/signup');
              },
            ),
          ),
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
            child: ExpansionTile(
              title: Text(
                localizations.language,
                style: TextStyle(
                  fontSize: AppText.headingTwo.fontSize,
                  fontWeight: AppText.headingTwo.fontWeight,
                  color: AppColor.primary,
                ),
                textAlign: TextAlign.center,
              ),
              trailing: Icon(
                Icons.navigate_next,
                color: AppColor.primary,
                size: 35,
              ),
              children: <Widget>[
                ListTile(
                  title: Text(
                    localizations.english,
                    style: TextStyle(
                      fontSize: AppText.headingTwo.fontSize,
                      fontWeight: AppText.headingTwo.fontWeight,
                      color: AppColor.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    _changeLanguage(Locale('en'));
                  },
                ),
                ListTile(
                  title: Text(
                    localizations.arabic,
                    style: TextStyle(
                      fontSize: AppText.headingTwo.fontSize,
                      fontWeight: AppText.headingTwo.fontWeight,
                      color: AppColor.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    _changeLanguage(Locale('ar'));
                  },
                ),
              ],
            ),
          ),
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
            child: ExpansionTile(
              title: Text(
                'Privacy', // Plain string without localization
                style: TextStyle(
                  fontSize: AppText.headingThree.fontSize,
                  fontWeight: AppText.headingTwo.fontWeight,
                  color: AppColor.primary,
                ),
                textAlign: TextAlign.center,
              ),
              trailing: Icon(
                Icons.navigate_next,
                color: AppColor.primary,
                size: 35,
              ),
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Change Password', // Plain string without localization
                    style: TextStyle(
                      fontSize: AppText.headingThree.fontSize,
                      fontWeight: AppText.headingTwo.fontWeight,
                      color: AppColor.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  trailing: Icon(
                    Icons.navigate_next,
                    color: AppColor.primary,
                    size: 35,
                  ),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/changePassword');
                  },
                ),
                ListTile(
                  title: Text(
                    'Change Email', // Plain string without localization
                    style: TextStyle(
                      fontSize: AppText.headingThree.fontSize,
                      fontWeight: AppText.headingTwo.fontWeight,
                      color: AppColor.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  trailing: Icon(
                    Icons.navigate_next,
                    color: AppColor.primary,
                    size: 35,
                  ),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/changeEmail'); // Navigate to change email page
                  },
                ),
                ListTile(
                  title: Text(
                    'Delete Account', // Plain string without localization
                    style: TextStyle(
                      fontSize: AppText.headingThree.fontSize,
                      fontWeight: AppText.headingTwo.fontWeight,
                      color: AppColor.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  trailing: Icon(
                    Icons.navigate_next,
                    color: AppColor.primary,
                    size: 35,
                  ),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/deleteAccount'); // Navigate to delete account page
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 150),
          ListTile(
            title: Text(
              localizations.logout, // Use the logout localization key
              style: TextStyle(
                fontSize: AppText.headingTwo.fontSize,
                fontWeight: AppText.headingTwo.fontWeight,
                color: AppColor.validation,
              ),
            ),
            leading: Icon(
              Icons.logout,
              color: AppColor.productInfo,
              size: 40,
            ),
            onTap: () {
              _authService.signOut(context);
            },
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
