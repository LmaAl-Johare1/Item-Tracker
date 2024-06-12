import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import the localization
import '../../res/AppColor.dart';
import '../../res/AppText.dart';
import '../../ViewModels/Authentication/ChangePasswordViewModel.dart';

class ChangePasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!; // Retrieve localized strings

    return ChangeNotifierProvider(
      create: (_) => ChangePasswordViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Center(
            child: Text(
              localizations.changePassword,
              style: TextStyle(
                fontSize: AppText.headingOne.fontSize,
                fontWeight: AppText.headingOne.fontWeight,
                color: AppColor.primary,
              ),
            ),
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
                  obscureText: viewModel.isCurrentPasswordObscured,
                  decoration: _buildInputDecoration(
                    localizations.currentPassword, // Use localized string
                        () => viewModel.toggleCurrentPasswordVisibility(),
                    viewModel.isCurrentPasswordObscured,
                  ),
                ),
                SizedBox(height: 70),
                TextField(
                  controller: viewModel.newPasswordController,
                  obscureText: viewModel.isNewPasswordObscured,
                  decoration: _buildInputDecoration(
                    localizations.newPassword, // Use localized string
                        () => viewModel.toggleNewPasswordVisibility(),
                    viewModel.isNewPasswordObscured,
                  ),
                ),
                SizedBox(height: 70),
                TextField(
                  controller: viewModel.confirmPasswordController,
                  obscureText: viewModel.isConfirmPasswordObscured,
                  decoration: _buildInputDecoration(
                    localizations.confirmNewPassword, // Use localized string
                        () => viewModel.toggleConfirmPasswordVisibility(),
                    viewModel.isConfirmPasswordObscured,
                  ),
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
                      bool success = await viewModel.changePassword();
                      if (success) {
                        Navigator.of(context).pushReplacementNamed('/login');
                      }
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

  InputDecoration _buildInputDecoration(String labelText, VoidCallback toggleVisibility, bool isObscured) {
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
      suffixIcon: IconButton(
        icon: Icon(
          isObscured ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey,
        ),
        onPressed: toggleVisibility,
      ),
    );
  }
}
