import 'package:flutter/material.dart';
import 'package:superwoman/pages/Projects/create-project-page.dart';
import 'package:superwoman/pages/main-page.dart';

class ProjectsPage extends StatelessWidget {

  ProjectsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(onPressed: ()=>Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CreateProjectPage()),
      ), child: Text("Create project"),),
    );
  }
}
