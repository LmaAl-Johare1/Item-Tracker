import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import generated localizations
import '../../ViewModels/ProfileViewModel.dart'; // Import your view model
import '../../res/AppColor.dart';
import '../../res/AppText.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late ProfileViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ProfileViewModel(); // Initialize _viewModel
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

  void _toggleEditing() {
    setState(() {
      _viewModel.toggleEditing(); // Toggle editing state
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!; // Retrieve localized strings

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            SizedBox(height: 10), // Adjusted height
            Row(
              children: [
                Icon(
                  Icons.navigate_before,
                  color: AppColor.primary,
                  size: 40,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      localizations.profile, // Use localized string for 'Profile'
                      style: TextStyle(
                        fontSize: AppText.headingOne.fontSize,
                        fontWeight: AppText.headingThree.fontWeight,
                        color: AppColor.primary,
                      ),
                    ),
                  ),
                ),
                Opacity(
                  opacity: 0,
                  child: Icon(
                    Icons.navigate_before,
                    color: AppColor.primary,
                    size: 40,
                  ),
                ),
              ],
            ),
          ],
        ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        color: AppColor.primary,
                        onPressed: _toggleEditing,
                      ),
                      Text(
                        localizations.edit, // Use localized string for 'Edit'
                        style: TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    controller: _viewModel.businessNameController,
                    enabled: _viewModel.isEditing,
                    decoration: _buildInputDecoration(
                      localizations.businessName, // Use localized string for 'Business Name'
                      localizations.itemTracker, // Use localized string for 'ItemTracker'
                    ).copyWith(
                      labelText: localizations.businessName, // Use localized string for 'Business Name'
                      labelStyle: TextStyle(
                        color: AppColor.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              TextField(
                controller: _viewModel.businessAddressController,
                enabled: _viewModel.isEditing,
                decoration: _buildInputDecoration(
                  localizations.businessAddress, // Use localized string for 'Business Address'
                  localizations.palestineNablus, // Use localized string for 'Palestine, Nablus'
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: _viewModel.phoneController,
                enabled: _viewModel.isEditing,
                decoration: _buildInputDecoration(
                  localizations.phoneNumber, // Use localized string for 'Phone Number'
                  localizations.phoneNumberExample, // Use localized string for example
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: _viewModel.emailController,
                enabled: _viewModel.isEditing,
                decoration: _buildInputDecoration(
                  localizations.email, // Use localized string for 'Email'
                  localizations.emailExample, // Use localized string for example
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
