import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project/Views/products/InsertProductView.dart';
import 'package:project/views/splash_screen.dart';
import 'Views/authentication/LoginView.dart';
import 'Views/authentication/RegisterView.dart';
import 'Views/authentication/ResetPasswordView.dart';
import 'Views/dashboard/DashboardView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
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
      routes: {
        '/': (context) => SplashScreen(),
        '/LoginPage': (context) => LoginScreen(),
        '/RegisterPage': (context) => RegisterPage(),
        '/LoginFromReset': (context) => LoginScreen(),
        '/resetPassword': (context) => ResetPassword(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => RegisterPage(),
        '/RegisterBack': (context) => LoginScreen(),

        '/MyHomePage' : (context) => MyHomePage(),
        '/insertProduct': (context) => InsertProductScreen(),
      },
    );
  }
}


