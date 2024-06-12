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
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/img/logo.png',
                  height: constraints.maxHeight * 0.5, // Adjust image height
                ),
                SizedBox(height: constraints.maxHeight * 0.05), // Adjust spacing
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppColor.primary,
                    minimumSize: Size(constraints.maxWidth * 0.5, 55), // Adjust button width
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: AppText.ButtunText,
                  ),
                ),
                Visibility(
                  visible: viewModel.isSignUpVisible,
                  child: SizedBox(height: constraints.maxHeight * 0.02), // Adjust spacing
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
                      minimumSize: Size(constraints.maxWidth * 0.5, 55), // Adjust button width
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                    ),
                    child: Text('Sign up', style: AppText.ButtunText,),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
