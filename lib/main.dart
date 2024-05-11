import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Views/Category/InsertCategoryView.dart';
import 'package:provider/provider.dart';
import 'package:project/ViewModels/InsertCategoryViewModel.dart';

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
    return ChangeNotifierProvider<CategoryViewModel>(
      create: (context) => CategoryViewModel(),
      child: MaterialApp(
        home: InsertCategoryScreen(), // Or wherever it fits in your navigation logic
      ),
    );
  }
}


