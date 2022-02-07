import 'package:flutter/material.dart';
import 'package:superwoman/services/service-locator.dart';
import 'dashboard.dart';

void main() {
  setupLocator();
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
