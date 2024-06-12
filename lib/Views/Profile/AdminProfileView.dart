import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import generated localizations
import '../../ViewModels/Profile/AdminProfileViewModel.dart';
import '../../res/AppColor.dart';
import '../../res/AppText.dart';

class ProfileAdmin extends StatefulWidget {
  @override
  _ProfileAdminState createState() => _ProfileAdminState();
}

class _ProfileAdminState extends State<ProfileAdmin> {
  late Profileadminviewmodel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = Profileadminviewmodel();
    _viewModel.fetchUserData();
  }

  InputDecoration _buildInputDecoration(String labelText, String placeholder) {
    return InputDecoration(
      labelText: labelText,
      hintText: placeholder,
      labelStyle: TextStyle(
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
      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
      alignLabelWithHint: true,
      floatingLabelBehavior: FloatingLabelBehavior.always,
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/Setting');
          },
        ),
        title: Text(
          localizations.admin,
          style: TextStyle(
            fontSize: AppText.headingOne.fontSize,
            fontWeight: AppText.headingOne.fontWeight,
            color: AppColor.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 40),
              Text(
                localizations.personalInformation,
                style: TextStyle(
                  color: AppColor.secondary,
                  fontSize: AppText.headingTwo.fontSize,
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  SizedBox(height: 30),
                  TextField(
                    controller: _viewModel.emailController,
                    enabled: false,
                    decoration: _buildInputDecoration(
                      localizations.email,
                      localizations.emailExample,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30), // Added height for spacing
            ],
          ),
        ),
      ),
    );
  }
}
