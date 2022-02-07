import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:superwoman/services/service-locator.dart';
import 'dashboard.dart';

void main() async {
  setupLocator();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyC0Tw3TmkNbwAg40E3aznIXWpSLJ9Xj2lI",
      appId: "1:587196116231:android:05cbd70bd8b589802829a2",
      messagingSenderId: "587196116231",
      projectId: "superwoman-adf31",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Dashboard(title: 'ONG Dashboard'),
    );
  }
}
