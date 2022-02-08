import 'package:flutter/material.dart';
import 'package:superwoman/pages/Projects/projects-page.dart';
import 'package:superwoman/pages/Stakeholders/stakeholders-page.dart';
import 'package:superwoman/pages/dashboard.dart';
import 'package:superwoman/pallete.dart';

class MyDrawer extends StatefulWidget {
  //final Function? putOnTop;
  MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: backgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: backgroundColor,
            ),
            child: Text(
              'ONG Dashboard',
              style: TextStyle(color: titleColor),
            ),
          ),
          _buildTile("Dashboard", Icons.admin_panel_settings, Dashboard()),
          _buildTile("Projects", Icons.file_copy, ProjectsPage()),
          _buildTile("Stakeholders", Icons.group, StakeholdersPage()),
        ],
      ),
    );
  }

  _buildTile(String name, IconData icon, Widget page) {
    return Container(
      color: activeColor,
      child: ListTile(
        leading: Icon(
          icon,
          color: iconColor,
        ),
        title: Text(
          name,
          style: TextStyle(color: textColor),
        ),
        onTap: () => _goTo(page),
      ),
    );
  }

  _goTo(Widget page) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
