import 'package:flutter/material.dart';
import 'package:project/res/AppText.dart';
import 'package:project/res/AppColor.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
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
                  onPressed: () {
                    // Handle Login
                  },
                  child: Text('Log in', style: AppText.ButtonText),
                ),
              ),
            ),
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
                  onPressed: () {
                    // Handle Sign up
                  },
                  child: Text('Sign up', style: AppText.ButtonText),
                ),
              ),
            ),

            Spacer(),
          ],
        ),
      ),
    );
  }
}
