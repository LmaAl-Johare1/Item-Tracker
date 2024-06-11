import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:project/res/AppColor.dart';
import 'package:project/res/AppText.dart';

import '../../ViewModels/Authentication/VerfiyEmailViewModel.dart';

class VerifyEmailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return ChangeNotifierProvider(
      create: (_) => VerifyEmailViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "verifyEmail",
            style: TextStyle(
              fontSize: AppText.headingOne.fontSize,
              fontWeight: AppText.headingOne.fontWeight,
              color: AppColor.primary,
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Consumer<VerifyEmailViewModel>(
          builder: (context, viewModel, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: viewModel.emailController,
                    decoration: InputDecoration(
                      labelText: localizations.email,
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
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                  SizedBox(height: 20),
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
                        bool success = await viewModel.verifyEmail();
                        if (success) {
                          Navigator.of(context).pushReplacementNamed('/changePassword');
                        }
                      },
                      child: Text("verify", style: AppText.ButtonText),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
