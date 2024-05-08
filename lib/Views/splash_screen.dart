import 'package:flutter/material.dart';
import 'package:project/res/AppText.dart';
import 'package:project/res/AppColor.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../viewmodels/splashscreen_view_model.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserViewModel(UserModel()), // Assuming UserModel is your data model
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<UserViewModel>(
            builder: (context, viewModel, child) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(flex: 2),
                    Image.asset('assets/img/logo.png',
                      width: 360,
                      height: 387,
                      fit: BoxFit.cover,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      child: SizedBox(
                        width: 209, // Set the width
                        height: 55, // Set the height
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primary, // Background color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                          onPressed: () => Navigator.pushNamed(context, '/login'), // Navigation logic for login
                          child: Text('Log in', style: AppText.ButtonText),
                        ),
                      ),
                    ),
                    if (viewModel.showSignupButton) // Conditionally display the signup button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: SizedBox(
                          width: 209, // Set the width
                          height: 55, // Set the height
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primary, // Background color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17),
                              ),
                            ),
                            onPressed: () => Navigator.pushNamed(context, '/signup'), // Navigation logic for signup
                            child: Text('Sign up', style: AppText.ButtonText),
                          ),
                        ),
                      ),

                    Spacer(),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }
}
