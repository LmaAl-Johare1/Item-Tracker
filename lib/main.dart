import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/ViewModels/ForgetPasswordViewModel.dart';  // Your ViewModel file
import 'package:project/Services/network_service.dart';            // Your Network service file
import 'package:project/Views/authentication/EmailEntryView.dart';

import 'Views/authentication/ForgetPasswordView.dart';           // Your Email Entry View file

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
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
        Provider<NetworkService>(
          create: (_) => NetworkService(),
        ),
        ChangeNotifierProvider<PasswordResetViewModel>(
          create: (context) => PasswordResetViewModel(context.read<NetworkService>()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: EmailEntryView(),  // Your initial screen
        routes: {
          '/ForgetPasswordView': (context) => ForgetPasswordView(),
        },
      ),
    );
  }
}
