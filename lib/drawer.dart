import 'package:flutter/material.dart';
import 'package:superwoman/pages/main-page.dart';
import 'package:superwoman/pallete.dart';


class MyDrawer extends StatefulWidget {

  final Function putOnTop;
  MyDrawer( this.putOnTop,  {Key? key,}) : super(key: key);

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
          _buildTile("Dashboard",Icons.admin_panel_settings, MainPage()),
          _buildTile("Projects", Icons.file_copy,MainPage()),
          _buildTile("Stakeholders", Icons.group,MainPage()),
        ],
      ),
    );
  }

  _buildTile(String name, IconData icon, Widget page) {
    return Container(
      color: activeColor,
      child: ListTile(
        leading: Icon(icon, color: iconColor,),
        title: Text(name,style: TextStyle(color: textColor),),
        onTap: () => _showPage(page),
      ),
    );
  }

  _showPage(Widget page){
    //Callback Func
    widget.putOnTop(page);
    Navigator.of(context).pop();
  }

}
