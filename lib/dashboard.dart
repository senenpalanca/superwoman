import 'package:flutter/material.dart';
import 'package:superwoman/drawer.dart';
import 'package:superwoman/pages/main-page.dart';
import 'package:superwoman/pallete.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  Widget frontPage = MainPage();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title, style: TextStyle(color: backgroundColor),),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: backgroundColor),
      ),

      drawer: MyDrawer(_setFrontPage),
      body: frontPage,
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _setFrontPage(Widget page){
    setState(() {
      frontPage = page;
    });

  }

}
