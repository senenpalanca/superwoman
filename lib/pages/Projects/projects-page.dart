import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:superwoman/model/project.dart';
import 'package:superwoman/pages/Projects/create-project-page.dart';
import 'package:superwoman/pages/main-page.dart';
import 'package:superwoman/services/project.service.dart';

import '../../services/service-locator.dart';

class ProjectsPage extends StatefulWidget {
  ProjectsPage({Key? key}) : super(key: key);

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  @override
  Widget build(BuildContext context) {

    return Container(
      child: StreamBuilder(
        stream: locator<ProjectService>().getAll().asStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List projects = snapshot.data as List;
          print(projects.length);
          return _buildListView(context, projects);
          return Container();
        },
      ),
    );
  }

  Widget _buildListView(BuildContext context, List projects) {

    return  Column(
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
                    label: Text("PROJECT NAME"),
                    numeric: false,
                    tooltip: "Project name",

                  ),
                  DataColumn(
                    label: Text("DESCRIPTION"),
                    numeric: false,
                    tooltip: "Description of the project",
                  ),
                  DataColumn(
                    label: Text("BUDGET"),
                    numeric: false,
                    tooltip: "Budget assignated to the project",

                  ),
                  DataColumn(
                    label: Text("CLOSING DATE"),
                    numeric: false,
                    tooltip: "Finish date of the project",

                  ),
                ],
                rows: projects
                    .map(
                      (project) => DataRow(
                      cells: [
                        DataCell(
                          Container(child: Text(project.name)),
                        ),
                        DataCell(
                          Text(project.description),
                        ),
                        DataCell(
                          Text("${project.budget} \u{20AC}"),
                        ),
                        DataCell(
                          Text(project.closingDate==null?"":formatDate(project.closingDate, [dd, '/', mm, '/', yyyy])),
                        ),
                      ]),
                )
                    .toList(),
              ),
            ),
          ],
        ),),
        Container(
          height: MediaQuery.of(context).size.height*0.1,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding:const EdgeInsets.all(8.0) +EdgeInsets.only(bottom: 10),
            child: ElevatedButton(onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateProjectPage()),
            ).then((value) =>  setState(() {

            })), child: Text("Create project")),
          ),
        )
      ],
    );
  }
}
/*
ListView.builder(

              itemCount: List.from(projects).length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                Project x = projects[index];
                return Container(
                  child: Text(x.description??""),
                );
                /*return ProposalCard(x, () {
                  setState(() {});
                });

                 */
              });
 */