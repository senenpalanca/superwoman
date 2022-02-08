import 'package:flutter/material.dart';
import 'package:superwoman/widgets/drawer.dart';

import '../pallete.dart';

class MyScaffold extends StatelessWidget {
  final Widget body;
  String? showTitle;
  List<Widget>? actions;

  MyScaffold({required this.body, this.showTitle, this.actions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(showTitle ?? "ONG Dashboard",
            style: TextStyle(color: backgroundColor)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: backgroundColor),
        actions: actions ?? [],
      ),
      body: body,
      drawer: MyDrawer(),
    );
  }
}
