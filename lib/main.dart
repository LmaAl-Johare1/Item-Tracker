import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project/ViewModels/Authentication/ResetPasswordViewModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:project/ViewModels/Authentication/LoginViewModel.dart';

import 'ViewModels/Setting/DeleteAccountViewModel.dart';
import 'ViewModels/products/InsertProductViewModel.dart';
import 'ViewModels/Category/ViewCategoryViewModel.dart';
import 'ViewModels/products/ProductViewModel.dart';
import 'Views/Authentication/ResetPasswordView.dart';
import 'Views/Category/InsertCategoryView.dart';
import 'Views/Category/ViewCategoryView.dart';
import 'Views/GenerateBarcode/GenerateBarcodeView.dart';
import 'Views/Reminder/ReminderView.dart';
import 'Views/Setting/ChangeEmailView.dart';
import 'Views/authentication/ChangePasswordView.dart';
import 'Views/authentication/LoginView.dart';
import 'Views/authentication/RegisterView.dart';
import 'Views/dashboard/DashboardView.dart';
import 'Views/product/CategoryProductView.dart';
import 'Views/product/ChartsView.dart';
import 'Views/product/EditProductView.dart';
import 'Views/product/InsertProductView.dart';
import 'Views/product/ProductDetailsView.dart';
import 'Views/product/SupplyProductView.dart';
import 'Views/profile/ProfileView.dart';
import 'Views/setting/DeleteAccountView.dart';
import 'Views/setting/SettingView.dart';
import 'l10n/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDqK1-9a5lYrpQPHYh74gvJCuR7_k6B0K0",
      appId: "1:188054375610:android:e0d9116276a116b2f80683",
      messagingSenderId: "188054375610",
      projectId: "itemtracker-cfd33",
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Locale _locale = Locale('en');

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginViewModel>(
          create: (_) => LoginViewModel(),
        ),
        ChangeNotifierProvider<ResetPasswordViewModel>(
          create: (_) => ResetPasswordViewModel(),
        ),
        ChangeNotifierProvider<InsertProductViewModel>(
          create: (_) => InsertProductViewModel(),
        ),
        ChangeNotifierProvider<ViewCategoryViewModel>(
          create: (_) => ViewCategoryViewModel(),
        ),
        ChangeNotifierProvider<ProductViewModel>(
          create: (_) => ProductViewModel(),
        ),
        ChangeNotifierProvider<DeleteAccountViewModel>(
          create: (_) => DeleteAccountViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Inventory Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        locale: _locale,
        supportedLocales: L10n.all,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale?.languageCode &&
                supportedLocale.countryCode == locale?.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        initialRoute: '/',
        routes: {
          '/': (context) => ChangeEmailView(),
          '/resetPassword': (context) => ResetPassword(),
          '/LoginPage': (context) => LoginScreen(),
          '/LoginFromReset': (context) => LoginScreen(),
          '/login': (context) => LoginScreen(),
          '/RegisterBack': (context) => LoginScreen(),
          '/SettingsPage': (context) => SettingsPage(),
          '/MyHomePage': (context) => MyHomePage(),
          '/Profile': (context) => Profile(),
          '/dashboard': (context) => MyHomePage(),
          '/insertProduct': (context) => InsertProductView(),
          '/supplyProduct': (context) => SupplyProductPage(),
          '/charts': (context) => ChartView(),
          '/viewCategories': (context) => ViewCategoryView(),
          '/changePassword': (context) => ChangePasswordView(),
          '/deleteAccount': (context) => DeleteAccountPage(),
          '/managerProfile': (context) => Profile(),
          '/reminders': (context) => RemindersView(),
          '/changeEmail': (context) => ChangeEmailView(),
          '/generateBarcode': (context) => GenerateBarcodeView(),
          '/Setting': (context) => SettingsPage(),
        },
      ),
    );
  }
}
