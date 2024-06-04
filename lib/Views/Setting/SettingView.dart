import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:project/res/AppColor.dart';
import 'package:project/res/AppText.dart';
import '../../ViewModels/Setting/SettingViewModel.dart';
import '../../main.dart';
import '../Report/ReportView.dart';
import '../dashboard/DashboardView.dart';

/// The settings page where users can view and modify their settings.
class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _selectedIndex = 2;
  final settingviewmodel _authService = settingviewmodel();

  /// Handles bottom navigation item taps.
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
        break;
    }
  }

  /// Changes the app's language.
  void _changeLanguage(Locale locale) {
    MyAppState? appState = context.findAncestorStateOfType<MyAppState>();
    appState?.setLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
          SizedBox(height: 20),
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
              leading: Icon(Icons.person, color: AppColor.primary),
              title: Text(
                localizations.profile,
                style: TextStyle(
                  fontSize: AppText.headingTwo.fontSize,
                  fontWeight: AppText.headingTwo.fontWeight,
                  color: AppColor.primary,
                ),
                textAlign: TextAlign.left,
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
              leading: Icon(Icons.add, color: AppColor.primary),
              title: Text(
                localizations.addAccount,
                style: TextStyle(
                  fontSize: AppText.headingTwo.fontSize,
                  fontWeight: AppText.headingTwo.fontWeight,
                  color: AppColor.primary,
                ),
                textAlign: TextAlign.left,
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
              leading: Icon(Icons.language, color: AppColor.primary),
              title: Text(
                localizations.language,
                style: TextStyle(
                  fontSize: AppText.headingTwo.fontSize,
                  fontWeight: AppText.headingTwo.fontWeight,
                  color: AppColor.primary,
                ),
                textAlign: TextAlign.left,
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
              leading: Icon(Icons.lock, color: AppColor.primary),
              title: Text(
                'Privacy',
                style: TextStyle(
                  fontSize: AppText.headingThree.fontSize,
                  fontWeight: AppText.headingTwo.fontWeight,
                  color: AppColor.primary,
                ),
                textAlign: TextAlign.left,
              ),
              trailing: Icon(
                Icons.navigate_next,
                color: AppColor.primary,
                size: 35,
              ),
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Change Password',
                    style: TextStyle(
                      fontSize: AppText.headingThree.fontSize,
                      fontWeight: AppText.headingTwo.fontWeight,
                      color: AppColor.primary,
                    ),
                    textAlign: TextAlign.left,
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
                    'Change Email',
                    style: TextStyle(
                      fontSize: AppText.headingThree.fontSize,
                      fontWeight: AppText.headingTwo.fontWeight,
                      color: AppColor.primary,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  trailing: Icon(
                    Icons.navigate_next,
                    color: AppColor.primary,
                    size: 35,
                  ),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/changeEmail');
                  },
                ),
                ListTile(
                  title: Text(
                    'Delete Account',
                    style: TextStyle(
                      fontSize: AppText.headingThree.fontSize,
                      fontWeight: AppText.headingTwo.fontWeight,
                      color: AppColor.primary,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  trailing: Icon(
                    Icons.navigate_next,
                    color: AppColor.primary,
                    size: 35,
                  ),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/deleteAccount');
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
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
              leading: Icon(Icons.logout, color: AppColor.primary, size: 40),
              title: Text(
                localizations.logout,
                style: TextStyle(
                  fontSize: AppText.headingTwo.fontSize,
                  fontWeight: AppText.headingTwo.fontWeight,
                  color: AppColor.validation,
                ),
                textAlign: TextAlign.left,
              ),
              onTap: () {
                _authService.signOut(context);
              },
            ),
          ),
          SizedBox(height: 50),
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
