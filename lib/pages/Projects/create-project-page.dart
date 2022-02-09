import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:superwoman/model/project.dart';
import 'package:superwoman/pallete.dart';
import 'package:superwoman/service-locator.dart';
import 'package:superwoman/services/project.service.dart';
import 'package:superwoman/widgets/avatar-selector.dart';
import 'package:superwoman/widgets/text-input.dart';

class CreateProjectPage extends StatefulWidget {
  const CreateProjectPage({Key? key}) : super(key: key);

  @override
  _CreateProjectPageState createState() => _CreateProjectPageState();
}

class _CreateProjectPageState extends State<CreateProjectPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController webLinkController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController budgetController = TextEditingController();
  DateTime closingDate = DateTime.now().add(new Duration(days: 7));
  String imageUrl =
      "https://ichef.bbci.co.uk/news/400/cpsprodpb/156EE/production/_113309778_gettyimages-524903696.jpg";
  final _formKey = GlobalKey<FormState>();

  void createProject(BuildContext context) async {
    var x = _formKey.currentState!.validate();
    if (_formKey.currentState!.validate()) {
      Project project = new Project();
      project.name = nameController.text;
      project.webLink = webLinkController.text;
      project.description = descriptionController.text;
      project.budget = double.parse(budgetController.text);
      project.image = imageUrl;
      project.closingDate = closingDate;

      locator<ProjectService>().saveProject(project);
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
          title: const Text('Project created'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Project created successfully.'),
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

  changeClosingDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: closingDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != closingDate)
      setState(() {
        closingDate = picked;
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    webLinkController.dispose();
    descriptionController.dispose();
    budgetController.dispose();
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
          "Create project",
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
                    Center(
                      child: AvatarSelector(imageUrl),
                    ),
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
                      regexp: RegExp(r".{5,50}$"),
                      errorMsg:
                          "Project name must be between five and 50 characters long",
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
                      regexp: RegExp(r"^[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}$"),
                      errorMsg:
                          "Link must have link format (Ex. www.google.com)",
                    ),
                    SizedBox(height: separation),
                    const Text(
                      "Description",
                      style: titleInputStyle,
                    ),
                    TextInput(
                      "Description",
                      descriptionController,
                      icon: Icons.insert_drive_file,
                      regexp: RegExp(r".{0,200}$"),
                      errorMsg: "Only can be up to 200 characters long",
                      multiLine: true,
                    ),
                    SizedBox(height: separation),
                    const Text(
                      "Budget",
                      style: titleInputStyle,
                    ),
                    TextInput(
                      "Budget",
                      budgetController,
                      icon: Icons.euro,
                      inputType: TextInputType.number,
                      regexp: RegExp(r"^[0-9]{1,20}([.][0-9]{1,20})?$"),
                      errorMsg: "Must be a number. Use dots(.) for decimals.",
                    ),
                    SizedBox(height: separation),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Closing date",
                          style: titleInputStyle,
                        ),
                        TextButton(
                            onPressed: () => changeClosingDate(),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Text("Change"),
                            )),
                      ],
                    ),
                    Text(
                      formatDate(closingDate, [dd, '/', mm, '/', yyyy]),
                      style: TextDateStyle,
                    ),
                    SizedBox(height: separation),
                  ],
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.all(size.height * 0.015),
              child: ElevatedButton(
                  onPressed: () => createProject(context),
                  child: const Text("Create project")),
            )
          ],
        ),
      ),
    );
  }
}
