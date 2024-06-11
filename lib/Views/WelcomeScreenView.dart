import 'package:flutter/material.dart';
import 'package:project/res/AppText.dart';
import 'package:provider/provider.dart';
import '../ViewModels/WelcomeScreenViewModel.dart';
import '../res/AppColor.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SplashViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/img/logo.png'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/LoginPage');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: AppColor.primary,
                minimumSize: Size(204, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
              ),
              child: Text('Login' , style: AppText.ButtunText,),
            ),
            Visibility(
              visible: viewModel.isSignUpVisible,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/signup');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppColor.primary,
                  minimumSize: Size(204, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                ),
                child: Text('Sign up'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}