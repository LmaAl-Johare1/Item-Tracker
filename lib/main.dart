import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project/views/authentication/login_screen.dart';
import 'package:project/views/authentication/signup_screen.dart';
import 'package:project/views/splash_screen.dart';
import 'package:project/res/AppColor.dart';


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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: AppColor.primary,
      ),

      // home: SplashScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginPage(), // Make sure you have a LoginPage widget
        '/signup': (context) => SignupPage(), // Make sure you have a SignupPage widget
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
