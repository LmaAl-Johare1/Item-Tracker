import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ViewModels/ForgetPasswordViewModel.dart';
import '../../res/AppColor.dart';
import '../../res/AppText.dart';

class ForgetPasswordView extends StatefulWidget {
  @override
  _ForgetPasswordViewState createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final String _errorText = '';

  @override
  void dispose() {
    // Dispose the TextEditingController when the widget is disposed
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PasswordResetViewModel>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),  // Increased height
        child: AppBar(
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 40),  // Adjust the padding here
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Reset Password',
                style: TextStyle(
                  fontSize: AppText.headingOne.fontSize,
                  fontWeight: AppText.headingOne.fontWeight,
                  color: AppColor.primary,  // Assuming AppColor.primary is blue
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            padding: const EdgeInsets.only(top: 35),
            icon: const Icon(Icons.arrow_back_ios, color: AppColor.primary),  // Blue arrow
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 95),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  errorText: _errorText.isEmpty ? null : _errorText,
                  labelStyle: const TextStyle(
                    color: AppColor.FieldLabel,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: AppColor.primary,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                      color: AppColor.primary,
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                obscureText: true,
              ),

              const SizedBox(height: 10),

              const Text(
                "Password must be at least 8 characters and contain at least one uppercase and one lowercase letter",
                style: TextStyle(
                  color: AppColor.validation,
                ),
              ),

              const SizedBox(height: 60),

              TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm your Password',
                  labelStyle: const TextStyle(
                    color: AppColor.FieldLabel,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: AppColor.primary,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: AppColor.primary,
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                obscureText: true,
              ),

              const SizedBox(height: 77),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: SizedBox(
                  width: 204, // Set the width
                  height: 55, // Set the height
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: AppColor.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                    ),
                    onPressed: () async {
                      try {
                        var _passwordController;
                        await viewModel.updatePassword(_passwordController.text);
                        // Show success message or navigate
                      } catch (e) {
                        // Show error message
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString()))
                        );
                      }
                    },
                    child: const Text('Save', style: AppText.ButtonText),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
