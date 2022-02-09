import 'package:flutter/material.dart';
import 'package:superwoman/model/project.dart';
import 'package:superwoman/model/stakeholder.dart';
import 'package:superwoman/pallete.dart';
import 'package:superwoman/service-locator.dart';
import 'package:superwoman/services/project.service.dart';
import 'package:superwoman/widgets/text-input.dart';

import '../../services/stakeholder.service.dart';
import '../../widgets/multi-select.dart';

class CreateStakeholderPage extends StatefulWidget {
  const CreateStakeholderPage({Key? key}) : super(key: key);

  @override
  _CreateStakeholderPageState createState() => _CreateStakeholderPageState();
}

class _CreateStakeholderPageState extends State<CreateStakeholderPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController webLinkController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  List<Project> projects = [];
  final _formKey = GlobalKey<FormState>();

  void createStakeholder(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      Stakeholder stakeholder = new Stakeholder();
      stakeholder.name = nameController.text;
      stakeholder.webLink = webLinkController.text;
      stakeholder.email = emailController.text;
      stakeholder.amount = double.parse(amountController.text);
      stakeholder.projects = projects;
      locator<StakeholderService>().saveStakeholder(stakeholder);
      await _showConfirmDialog(context);
      Navigator.of(context).pop(true);
    }
  }

  _showConfirmDialog(BuildContext context) async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Stakeholder created'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                const Text('Stakeholder registered successfully.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _showAddProjectsDialog() async {
    List allProjects = await locator<ProjectService>().getAll();
    final List<Project> recvProjects = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: allProjects.cast<Project>());
      },
    );
    if (recvProjects != null) {
      setState(() {
        projects = recvProjects;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    webLinkController.dispose();
    emailController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const double separation = 5;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: const Text(
          "Register stakeholder",
          style: TextStyle(color: backgroundColor),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(size.width * 0.01) +
                    EdgeInsets.only(
                        left: size.width * 0.05, right: size.width * 0.05),
                child: ListView(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: separation,
                    ),
                    const Text(
                      "Name",
                      style: titleInputStyle,
                    ),
                    TextInput(
                      "Name",
                      nameController,
                      icon: Icons.drive_file_rename_outline,
                      regexp: RegExp(r".{5,20}$"),
                      errorMsg:
                          "Stakeholder name must be between five and 20 characters long",
                    ),
                    SizedBox(height: separation),
                    const Text(
                      "Link",
                      style: titleInputStyle,
                    ),
                    TextInput(
                      "Link",
                      webLinkController,
                      icon: Icons.link,
                      regexp: RegExp(r".{5,100}$"),
                      errorMsg:
                          "Link must be between five  and 100 characters long",
                    ),
                    SizedBox(height: separation),
                    const Text(
                      "Email",
                      style: titleInputStyle,
                    ),
                    TextInput(
                      "Email",
                      emailController,
                      icon: Icons.email_outlined,
                      regexp: RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"),
                      errorMsg: "Must have email type format",
                      inputType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: separation),
                    const Text(
                      "Amount",
                      style: titleInputStyle,
                    ),
                    TextInput(
                      "Amount",
                      amountController,
                      icon: Icons.euro,
                      inputType: TextInputType.number,
                      regexp: RegExp(r"^[0-9]{1,20}([.][0-9]{1,20})?$"),
                      errorMsg: "Must be a number. Use dots(.) for decimals.",
                    ),
                    SizedBox(height: separation),
                    //Falta que se puedan seleccionar varios proyectos
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Projects",
                          style: titleInputStyle,
                        ),
                        TextButton(
                          onPressed: () => _showAddProjectsDialog(),
                          child: const Text("Add project(s)"),
                        ),
                      ],
                    ),
                    SizedBox(height: separation),
                    projects.length == 0
                        ? const Text("None selected")
                        : Wrap(
                            children: projects
                                .map((e) => Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Chip(
                                        label: Text(e.name ?? ""),
                                      ),
                                    ))
                                .toList(),
                          ),
                  ],
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.all(size.height * 0.02),
              child: ElevatedButton(
                  onPressed: () => createStakeholder(context),
                  child: Text("Register stakeholder")),
            ),
          ],
        ),
      ),
    );
  }
}
