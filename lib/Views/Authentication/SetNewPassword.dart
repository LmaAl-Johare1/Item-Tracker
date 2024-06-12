import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ViewModels/Authentication/ResetPasswordViewModel.dart';
import '../../res/AppColor.dart';
import '../../res/AppText.dart';

class SetNewPassword extends StatefulWidget {
  final String? email;

  SetNewPassword({required this.email});

  @override
  _SetNewPasswordState createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends State<SetNewPassword> {
  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColor.primary),
        title: Text(
          'Set New Password',
          style: TextStyle(
            color: AppColor.primary,
            fontSize: AppText.headingOne.fontSize,
            fontWeight: AppText.headingOne.fontWeight,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/resetPassword');
          },
        ),
      ),
      body: ChangeNotifierProvider<ResetPasswordViewModel>(
        create: (_) => ResetPasswordViewModel(),
        child: Consumer<ResetPasswordViewModel>(
          builder: (context, model, child) {
            return Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: model.passwordController,
                    obscureText: _isPasswordObscured,
                    decoration: InputDecoration(
                      labelText: "New Password",
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
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      alignLabelWithHint: true,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordObscured ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordObscured = !_isPasswordObscured;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: model.confirmPasswordController,
                    obscureText: _isConfirmPasswordObscured,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
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
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      alignLabelWithHint: true,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordObscured ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordObscured = !_isConfirmPasswordObscured;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
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
                        onPressed: () async {
                          await model.resetPassword(widget.email);
                          if (model.emailError == null) {
                            Navigator.pushReplacementNamed(
                                context, '/login');
                          }
                        },
                        child: model.isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                          'Reset Password',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: AppText.headingFour.fontSize,
                            fontWeight: AppText.headingFour.fontWeight,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (model.emailError != null) ...[
                    SizedBox(height: 20),
                    Text(model.emailError!,
                        style: TextStyle(color: Colors.red)),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}