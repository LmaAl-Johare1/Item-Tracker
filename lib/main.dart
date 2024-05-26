import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'ViewModels/InsertProductViewModel.dart';
import 'Views/Category/ViewCategoryView.dart';
import 'Views/Reminder/ReminderView.dart';
import 'Views/authentication/ChangePasswordView.dart';
import 'Views/authentication/LoginView.dart';
import 'Views/dashboard/DashboardView.dart';
import 'Views/product/ChartsView.dart';
import 'Views/product/InsertProductView.dart';
import 'Views/product/SupplyProductView.dart';
import 'Views/setting/DeleteAccountView.dart';
import 'Views/setting/ProfileManager.dart';
import 'Views/setting/SettingView.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InsertProductViewModel()),
        // Add other providers here
      ],
      child: MaterialApp(
        routes: {
          '/': (context) => MyHomePage(),
          '/LoginPage': (context) => LoginScreen(),
          '/LoginFromReset': (context) => LoginScreen(),
          '/login': (context) => LoginScreen(),
          '/RegisterBack': (context) => LoginScreen(),
          '/SettingsPage' : (context) => SettingsPage(),
          '/MyHomePage' : (context) => MyHomePage(),
          '/Profile' : (context) => Profile(),
          '/dashboard': (context) => MyHomePage(),
          '/insertProduct': (context) => InsertProductView(),
          '/supplyProduct': (context) => SupplyProductPage(),
          '/charts': (context) => ChartView(),
          '/viewCategories': (context) => ViewCategoryView(),
          '/changePassword': (context) => ChangePasswordView(),
          '/deleteAccount': (context) => DeleteAccountPage(),
          '/managerProfile': (context) => Profile(),
          '/reminders': (context) => RemindersView(),
        },
      ),
    );
  }
}

