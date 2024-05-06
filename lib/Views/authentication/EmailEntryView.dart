import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/ViewModels/ForgetPasswordViewModel.dart';

import '../../res/AppColor.dart';
import '../../res/AppText.dart';

class EmailEntryView extends StatefulWidget {
  @override
  _EmailEntryViewState createState() => _EmailEntryViewState();
}

class _EmailEntryViewState extends State<EmailEntryView> {
  final TextEditingController _emailController = TextEditingController();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),  // Increased height
        child: AppBar(
          flexibleSpace: Padding(
            padding: EdgeInsets.only(top: 40),  // Adjust the padding here
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
            padding: EdgeInsets.only(top: 35),
            icon: Icon(Icons.arrow_back_ios, color: AppColor.primary),  // Blue arrow
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 50),
          child: Column(
            children: [
              Text(
                'Enter your email address to reset your password.',
                style: AppText.headingFour,
              ),
              SizedBox(height: 20),

              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  errorText: _errorMessage.isNotEmpty ? _errorMessage : null,
                  labelStyle: TextStyle(
                    color: AppColor.FieldLabel,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: AppColor.primary,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: AppColor.primary,
                      width: 2,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),


              SizedBox(height: 30),
              // Provides spacing between the input field and the button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: SizedBox(
                  width: 209, // Set the width
                  height: 55, // Set the height
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: AppColor.primary, // Background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                    ),
                     onPressed: () {
                       // Assuming you're using Provider for state management
                       Provider.of<PasswordResetViewModel>(context, listen: false)
                          .sendResetEmail(emailController.text)
                           .then((_) {
                         Navigator.pushNamed(context, '/ForgetPasswordView');
                      })
                           .catchError((error) {
                         // Handle errors, like showing an error message
                      });
                     },
                    child: Text('Reset Password' , style: AppText.headingFour,),

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
