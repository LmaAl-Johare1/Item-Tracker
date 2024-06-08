import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import generated localizations
import '../../ViewModels/Profile/StuffProfileViewModel.dart';
import '../../res/AppColor.dart';
import '../../res/AppText.dart';

class ProfileStuff extends StatefulWidget {
  @override
  _ProfileStuffState createState() => _ProfileStuffState(); // Corrected class name
}

class _ProfileStuffState extends State<ProfileStuff> { // Corrected class name
  late ProfileStaffViewModel _viewModel; // Corrected ViewModel name

  @override
  void initState() {
    super.initState();
    _viewModel = ProfileStaffViewModel(); // Corrected ViewModel name
    _viewModel.fetchUserData(); // Fetch user data
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
    final localizations = AppLocalizations.of(context)!; // Retrieve localized strings

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
          localizations.profileStuffs, // Use localized string for 'Profile'
          style: TextStyle(
            fontSize: AppText.headingOne.fontSize,
            fontWeight: AppText.headingThree.fontWeight,
            color: AppColor.primary,
          ),
        ),
        centerTitle: true, // Align the title in the center
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 40), // Reduced height
              Text(
                localizations.personalInformation, // Use localized string for 'Personal Information'
                style: TextStyle(
                  color: AppColor.secondary,
                  fontSize: AppText.headingTwo.fontSize,
                ),
              ),
              SizedBox(height: 20), // Reduced height
              Column(
                children: [
                  SizedBox(height: 30), // Added height for spacing
                  TextField(
                    controller: _viewModel.emailController,
                    enabled: false, // Set email field to read-only
                    decoration: _buildInputDecoration(
                      localizations.email, // Use localized string for 'Email'
                      localizations.emailExample, // Use localized string for example
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
