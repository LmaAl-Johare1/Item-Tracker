import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project/Views/authentication/LoginView.dart';
import 'package:project/views/dashboard/dashboardView.dart';

import 'Views/authentication/RegisterView.dart';
import 'Views/authentication/ResetPasswordView.dart';
import 'Views/setting/settingview.dart';
// import 'Views/splash_screen.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDDBlrt11AqsJqGk3Ocvu1tRqsL5Y_sE34",
      appId: "1:27340201446:android:6ba30c884e73a965544a27",
      messagingSenderId: "27340201446",
      projectId: "itemtracker-dev-50418",
    ),
  );


  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/' : (context) => LoginScreen(), // changing to welcome screen
        '/LoginPage' : (context) => LoginScreen(),
        '/RegisterPage' :(context) => RegisterPage(),
        '/LoginFromReset' : (context) => LoginScreen(),
        '/resetPassword': (context) => ResetPassword(),
        '/login' : (context)  => LoginScreen(),// Adjust according to your actual dashboard widget name
        '/signup' : (context) => RegisterPage(),
        'RegisterBack' : (context) => LoginScreen(),
        '/dashboardRegister' : (context) => MyHomePage(),
      }, // Set RegisterPage as the home screen
    );
  }
}
