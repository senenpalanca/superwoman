import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:superwoman/pages/Projects/create-project-page.dart';
import 'package:superwoman/services/project.service.dart';
import 'package:superwoman/widgets/scaffold.dart';

import '../../model/project.dart';
import '../../pallete.dart';
import '../../service-locator.dart';

class ProjectsPage extends StatefulWidget {
  ProjectsPage({Key? key}) : super(key: key);

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      showTitle: "Projects",
      actions: [
        IconButton(
            onPressed: () => _createProject(),
            icon: Icon(
              Icons.add,
              color: Colors.blue,
            )),
      ],
      body: Container(
        child: StreamBuilder(
          stream: locator<ProjectService>().getAll().asStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            List projects = snapshot.data as List;
            return _buildView(context, projects);
            return Container();
          },
        ),
      ),
    );
  }

  Widget _buildView(BuildContext context, List projects) {
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
                      label: Text("LINK"),
                      numeric: false,
                      tooltip: "Website of the project",
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
                    DataColumn(
                      label: Text("DELETE"),
                      numeric: false,
                    ),
                  ],
                  rows: projects
                      .map(
                        (project) => DataRow(cells: [
                          DataCell(
                            Text(project.name),
                          ),
                          DataCell(
                            Text(project.description),
                          ),
                          DataCell(
                            Text(
                              project.webLink,
                              style: linkStyle,
                            ),
                          ),
                          DataCell(
                            Text("${project.budget} \$"),
                          ),
                          DataCell(
                            Text(project.closingDate == null
                                ? ""
                                : formatDate(project.closingDate,
                                    [dd, '/', mm, '/', yyyy])),
                          ),
                          DataCell(IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () => _deleteProject(project),
                          )),
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
                onPressed: () => _createProject(),
                child: Text("Create project")),
          ),
        )
      ],
    );
  }

  _createProject() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateProjectPage()),
    ).then((value) => setState(() {}));
  }

  _deleteProject(Project project) async {
    await locator<ProjectService>().deleteProject(project);
    setState(() {});
  }
}
