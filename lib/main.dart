import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:superwoman/service-locator.dart';

import 'pages/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyC0Tw3TmkNbwAg40E3aznIXWpSLJ9Xj2lI",
      appId: "1:587196116231:android:05cbd70bd8b589802829a2",
      messagingSenderId: "587196116231",
      projectId: "superwoman-adf31",
    ),
  );
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Dashboard(),
    );
  }
}
