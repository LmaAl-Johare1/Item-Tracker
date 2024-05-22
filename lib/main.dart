import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:provider/provider.dart';
import 'package:project/ViewModels/ViewCategoryViewModel.dart';
import 'package:project/ViewModels/InsertProductViewModel.dart';
import 'package:project/ViewModels/ProductViewModel.dart';
import 'Views/Category/ViewCategoryView.dart';
import 'Views/dashboard/dashboardView.dart';
import 'Views/product/InsertProductView.dart';
import 'package:project/ViewModels/SupplyProductViewModel.dart';
import 'Views/product/SupplyProductView.dart';
import 'Views/product/ChartsView.dart';

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

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (_) => InsertProductViewModel()),
        ChangeNotifierProvider(create: (_) => ViewCategoryViewModel()),


        ChangeNotifierProvider(create: (_) => ProductViewModel()),

      ],
      child: MaterialApp(
        title: 'Inventory Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        routes: {
          '/': (context) => MyHomePage(),
          '/dashboard': (context) => MyHomePage(),
          '/insertProduct': (context) => InsertProductView(),
          '/supplyProduct': (context) => SupplyProductPage(),
          '/Charts': (context) => ChartView(),
          '/viewCategories':(context) => ViewCategoryView(),
        },
      )
    );
  }
}