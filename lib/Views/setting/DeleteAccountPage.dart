import 'package:flutter/material.dart';
import 'package:project/res/AppColor.dart';
import 'package:project/res/AppText.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import the localization

import '../../Services/network_service.dart';

class DeleteAccountPage extends StatefulWidget {
  @override
  _DeleteAccountPageState createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  final TextEditingController _accountController = TextEditingController();
  final NetworkService _networkService = NetworkService();
  String _message = '';

  void _deleteAccount() async {
    String account = _accountController.text.trim();
    if (account.isEmpty) {
      setState(() {
        _message = AppLocalizations.of(context)!.accountFieldEmpty; // Use localized string
      });
      return;
    }

    bool accountExists = await _networkService.emailExists(account);
    if (!accountExists) {
      setState(() {
        _message = AppLocalizations.of(context)!.invalidAccount; // Use localized string
      });
      return;
    }

    await _networkService.deleteData('Users', account);
    setState(() {
      _message = AppLocalizations.of(context)!.accountDeleted; // Use localized string
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!; // Retrieve localized strings

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColor.primary),
        title: Text(
          localizations.deleteAccount, // Use localized string
          style: TextStyle(
            color: AppColor.primary,
            fontSize: AppText.headingOne.fontSize,
            fontWeight: AppText.headingOne.fontWeight,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/dashboard');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              SizedBox(height: 60),  // Add space between AppBar and TextField
              TextField(
                controller: _accountController,
                decoration: InputDecoration(
                  labelText: localizations.chooseAccount, // Use localized string
                  labelStyle: const TextStyle(
                    color: AppColor.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: AppColor.primary.withOpacity(0.99),
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: AppColor.primary.withOpacity(0.99),
                      width: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 250),  // Space between TextField and Button
              TextButton(
                onPressed: _deleteAccount,
                child: Text(
                  localizations.delete, // Use localized string
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: AppText.ButtonText.fontSize,
                    fontWeight: AppText.ButtonText.fontWeight,
                  ),
                ),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 64, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  backgroundColor: Colors.red,
                ),
              ),
              SizedBox(height: 20),
              Text(
                _message,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
