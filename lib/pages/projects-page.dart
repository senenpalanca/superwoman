import 'package:flutter/material.dart';
import 'package:superwoman/pages/main-page.dart';

class ProjectsPage extends StatelessWidget {
  Function goToPage;
  ProjectsPage(this.goToPage,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(onPressed: ()=>goToPage(MainPage()), child: Text("Create project"),),
    );
  }
}
