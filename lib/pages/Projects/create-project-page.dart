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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
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
                      height: 10,
                    ),
                    Center(
                      child: AvatarSelector(imageUrl),
                    ),
                    SizedBox(
                      height: 10,
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
                          "Project name must be between five and 20 characters long",
                    ),
                    SizedBox(height: 10),
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
                          "Link must be between five and 100 characters long",
                    ),
                    SizedBox(height: 10),
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
                    ),
                    SizedBox(height: 10),
                    const Text(
                      "Budget",
                      style: titleInputStyle,
                    ),
                    TextInput(
                      "Budget",
                      budgetController,
                      icon: Icons.attach_money,
                      inputType: TextInputType.number,
                      regexp: RegExp(r".{1,10}$"),
                      errorMsg: "Cannot be empty and must be a number",
                    ),
                    SizedBox(height: 10),
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
                              child: Text("Change"),
                            )),
                      ],
                    ),
                    Text(
                      formatDate(closingDate, [dd, '/', mm, '/', yyyy]),
                      style: TextDateStyle,
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.all(size.height * 0.02),
              child: ElevatedButton(
                  onPressed: () => createProject(context),
                  child: Text("Create project")),
            )
          ],
        ),
      ),
    );
  }
}
