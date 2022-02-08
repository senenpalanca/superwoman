import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:superwoman/pages/Projects/create-project-page.dart';
import 'package:superwoman/pages/Stakeholders/create-stakeholder-page.dart';
import 'package:superwoman/services/project.service.dart';
import 'package:superwoman/services/stakeholder.service.dart';
import 'package:superwoman/widgets/scaffold.dart';

import '../../service-locator.dart';

class StakeholdersPage extends StatefulWidget {
  StakeholdersPage({Key? key}) : super(key: key);

  @override
  State<StakeholdersPage> createState() => _StakeholdersPageState();
}

class _StakeholdersPageState extends State<StakeholdersPage> {

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      showTitle: "Stakeholders",
      actions: [
        IconButton(onPressed: () => _createStakeholder(), icon: Icon(Icons.add, color: Colors.blue,)),
      ],
      body: Container(
        child: StreamBuilder(
          stream: locator<StakeholderService>().getAll().asStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            List stakeholders = snapshot.data as List;
            return _buildView(context, stakeholders);
            return Container();
          },
        ),
      ),
    );
  }

  Widget _buildView(BuildContext context, List stakeholders) {

    return Column(
      children: [
        Expanded(
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              SingleChildScrollView(
                child: DataTable(
                  //sortAscending: sort,
                  sortColumnIndex: 0,
                  columns: [
                    DataColumn(
                      label: Text("NAME"),
                      numeric: false,
                      tooltip: "Stakeholder name",
                    ),
                    DataColumn(
                      label: Text("EMAIL"),
                      numeric: false,
                      tooltip: "Email of the stakeholder",
                    ),
                    DataColumn(
                      label: Text("LINK"),
                      numeric: false,
                      tooltip: "Web link of the stakeholder",
                    ),
                    DataColumn(
                      label: Text("AMOUNT"),
                      numeric: false,
                      tooltip: "Amount put by stakeholder",
                    ),
                    DataColumn(
                      label: Text("PROJECTS"),
                      numeric: false,
                      tooltip: "Number of projects",
                    ),
                  ],
                  rows: stakeholders
                      .map(
                        (stakeholder) => DataRow(cells: [
                          DataCell(
                             Text(stakeholder.name),
                          ),
                          DataCell(
                            Text(stakeholder.email),
                          ),
                          DataCell(
                            Text(stakeholder.webLink, style: TextStyle(color: Colors.blue),),
                          ),
                          DataCell(
                            Text(" ${stakeholder.amount} \$"),
                          ),
                          DataCell(
                            Text((stakeholder.projects?.length??0).toString()),
                          ),
                        ]),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0) + EdgeInsets.only(bottom: 10),
            child: ElevatedButton(
                onPressed: () => _createStakeholder(),
                child: Text("New stakeholder")),
          ),
        )
      ],
    );
  }

  _createStakeholder() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const CreateStakeholderPage()),
    ).then((value) => setState(() {}));
  }
}

