import 'package:flutter/material.dart';
import 'package:superwoman/pages/Projects/projects-page.dart';
import 'package:superwoman/pages/Stakeholders/stakeholders-page.dart';
import 'package:superwoman/pallete.dart';
import 'package:superwoman/service-locator.dart';
import 'package:superwoman/services/project.service.dart';
import 'package:superwoman/services/stakeholder.service.dart';
import 'package:superwoman/widgets/display-card.dart';
import 'package:superwoman/widgets/scaffold.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int noProjects = 0;
  int noStakeholders = 0;
  double moneyRaised = 0;
  double averageFunds = 0;

  Future<bool> _getTabsData() async {
    noProjects = await locator<ProjectService>().getNoProjects();
    noStakeholders = await locator<StakeholderService>().getNoStakeholders();
    moneyRaised = await locator<ProjectService>().getMoneyRaised();
    averageFunds = noProjects > 0 ? moneyRaised / noProjects : 0;
    return true;
  }

  _goToProjectsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProjectsPage()),
    );
  }

  _goToStakeholdersPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StakeholdersPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MyScaffold(
      showTitle: "ONG Dashboard",
      body: FutureBuilder(
        future: _getTabsData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: GridView.count(
                  crossAxisCount:
                      (size.width / (cardHeight * cardProportion)).round(),
                  children: [
                    DisplayCard(
                      _buildTemplateCard(
                          context,
                          "Number of projects",
                          noProjects.toString(),
                          Icons.file_copy_outlined,
                          () => _goToProjectsPage()),
                      Colors.green,
                    ),
                    DisplayCard(
                      _buildTemplateCard(
                        context,
                        "Number of Stakeholders",
                        noStakeholders.toString(),
                        Icons.people_alt_outlined,
                        () => _goToStakeholdersPage(),
                      ),
                      Colors.red,
                    ),
                    DisplayCard(
                      _buildTemplateCard(
                          context,
                          "Total money raised",
                          formatter.format(moneyRaised),
                          Icons.attach_money,
                          () => _goToProjectsPage()),
                      Colors.cyan,
                    ),
                    DisplayCard(
                      _buildTemplateCard(
                          context,
                          "Average funds per project",
                          formatter.format(averageFunds),
                          Icons.attach_money,
                          () => _goToProjectsPage()),
                      Colors.orange,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildTemplateCard(BuildContext context, String title,
      String description, IconData icon, Function onClick) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => onClick(),
      child: Column(
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
          Divider(
            indent: 10,
            endIndent: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    description,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: cardTextColor,
                        fontSize: 18),
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                Icon(
                  icon,
                  color: cardTextColor,
                  // size: size.height * 0.02,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
