import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import the localization
import 'package:project/res/AppColor.dart';
import 'package:project/res/AppText.dart';

import '../../ViewModels/authentication/ChangePasswordViewModel.dart';

class ChangePasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!; // Retrieve localized strings

    return ChangeNotifierProvider(
      create: (_) => ChangePasswordViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    localizations.changePassword, // Use localized string
                    style: TextStyle(
                      fontSize: AppText.headingOne.fontSize,
                      fontWeight: AppText.headingOne.fontWeight,
                      color: AppColor.primary,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 40), // Use SizedBox to leave space
            ],
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Consumer<ChangePasswordViewModel>(
          builder: (context, viewModel, child) {
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 30),
              children: <Widget>[
                SizedBox(height: 70),
                TextField(
                  controller: viewModel.currentPasswordController,
                  obscureText: true,
                  decoration: _buildInputDecoration(localizations.currentPassword), // Use localized string
                ),
                SizedBox(height: 70),
                TextField(
                  controller: viewModel.newPasswordController,
                  obscureText: true,
                  decoration: _buildInputDecoration(localizations.newPassword), // Use localized string
                ),
                SizedBox(height: 70),
                TextField(
                  controller: viewModel.confirmPasswordController,
                  obscureText: true,
                  decoration: _buildInputDecoration(localizations.confirmNewPassword), // Use localized string
                ),
                SizedBox(height: 100),
                if (viewModel.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      viewModel.errorMessage!,
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColor.primary,
                      minimumSize: Size(204, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                    ),
                    onPressed: () async {
                      await _saveChanges(context);
                    },
                    child: Text(localizations.save, style: AppText.ButtonText), // Use localized string
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _saveChanges(BuildContext context) async {
    var viewModel = Provider.of<ChangePasswordViewModel>(context, listen: false);
    bool success = await viewModel.changePassword();
    if (success) {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  InputDecoration _buildInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
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
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      alignLabelWithHint: true,
      floatingLabelBehavior: FloatingLabelBehavior.always,
    );
  }
}