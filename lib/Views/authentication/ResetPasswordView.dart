import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/ViewModels/ResetPasswordViewModel.dart';

import '../../res/AppColor.dart';
import '../../res/AppText.dart';

/// A StatelessWidget that provides a user interface for resetting passwords.
class ResetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColor.primary),
          title: Text('Reset Password', style: TextStyle(color: AppColor.primary, fontSize: AppText.headingOne.fontSize, fontWeight: AppText.headingOne.fontWeight)),
          centerTitle: true,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                //Navigator.pushReplacementNamed(context, '/login');
              }
          )
      ),

      body: ChangeNotifierProvider<ResetPasswordViewModel>(
        create: (_) => ResetPasswordViewModel(),
        child: Consumer<ResetPasswordViewModel>(
          builder: (context, model, child) => Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                Text(
                    "Enter your email address to reset your password.",
                    style: TextStyle(
                      fontSize: AppText.headingFour.fontSize,
                      fontWeight: AppText.headingFour.fontWeight,
                    )
                ),
                SizedBox(height: 40),
                TextField(
                  controller: model.emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
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
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    alignLabelWithHint: true,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    errorText: model.emailError,
                  ),
                ),
                SizedBox(height: 40),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  child: SizedBox(
                    width: 209,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                      ),
                      onPressed:
                      model.emailError == null && !model.isLoading ? model.sendPasswordResetEmail : null,
                      child: model.isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text('Reset Password' ,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: AppText.headingFour.fontSize, // Assuming headingFour defines fontSize
                            fontWeight: AppText.headingFour.fontWeight,
                          )),
                    ),
                  ),
                ),

                if (model.emailError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      model.emailError!,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),

    );
  }
}
