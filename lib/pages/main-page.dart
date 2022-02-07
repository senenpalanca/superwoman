import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:superwoman/Widgets/display-card.dart';

import '../pallete.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.count(
          crossAxisCount: (size.width / (cardHeight * cardProportion)).round(),
          children: [
            DisplayCard(
              _buildTemplateCard(context, "Number of projects", "56",
                  Icons.file_copy_outlined),
              Colors.green,
            ),
            DisplayCard(
                _buildTemplateCard(context, "Number of Stakeholders", "21",
                    Icons.people_alt_outlined),
                Colors.red),
            DisplayCard(
                _buildTemplateCard(context, "Total money raised", "213,065",
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
  }


  Widget _buildTemplateCard(BuildContext context, String title,
      String description, IconData leftIcon) {
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
                leftIcon,
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
