import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:superwoman/Widgets/display-card.dart';
import 'package:superwoman/services/service-locator.dart';

import '../pallete.dart';
import '../services/project.service.dart';
import '../services/stakeholder.service.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int noProjects = 0;

  int noStakeholders = 0;
  double moneyRaised = 0;
  int objectivesAchieved = 0;
  Future<bool> _getTabsData() async {
    noProjects = await locator<ProjectService>().getNoProjects();
    noStakeholders = await locator<StakeholderService>().getNoStakeholders();
    moneyRaised = await locator<ProjectService>().getMoneyRaised();
    return true;
  }

  //int no
  @override
  Widget build(BuildContext context) {
    _getTabsData();
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: _getTabsData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
       if(snapshot.hasData){
         return Container(
           child: Padding(
             padding: const EdgeInsets.all(12.0),
             child: GridView.count(
               crossAxisCount: (size.width / (cardHeight * cardProportion)).round(),
               children: [
                 DisplayCard(
                   _buildTemplateCard(context, "Number of projects", noProjects.toString(),
                       Icons.file_copy_outlined),
                   Colors.green,
                 ),
                 DisplayCard(
                     _buildTemplateCard(context, "Number of Stakeholders", noStakeholders.toString(),
                         Icons.people_alt_outlined),
                     Colors.red),
                 DisplayCard(
                     _buildTemplateCard(context, "Total money raised", moneyRaised.toString().replaceAll(".", ","),
                         Icons.attach_money),
                     Colors.cyan),
                 DisplayCard(
                     _buildTemplateCard(context, "Number of Objectives achieved", "214",
                         Icons.check),
                     Colors.orange),

               ],
             ),
           ),
         );
       }else{
         return Center(child: CircularProgressIndicator(),);
       }
      },
    );
  }

  Widget _buildTemplateCard(BuildContext context, String title,
      String description, IconData icon) {
    Size size = MediaQuery.of(context).size;
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(color: cardTitleColor, fontSize: 18),
            ),
          ),
        ),
        Divider(indent: 10,endIndent: 10,),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                description,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: cardTextColor, fontSize: 22),
              ),
              SizedBox(width: 6,),
              Icon(
                icon,
                color: cardTextColor,
                // size: size.height * 0.02,
              )
            ],
          ),
        )
      ],
    );
  }
}
