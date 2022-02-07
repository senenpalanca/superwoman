import 'package:flutter/material.dart';
import 'package:superwoman/model/project.dart';
import 'package:superwoman/pallete.dart';
import 'package:superwoman/services/project.service.dart';
import 'package:superwoman/services/service-locator.dart';
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
  DateTime closingDate = DateTime.now();
  String imageUrl = "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg";
  final _formKey = GlobalKey<FormState>();

  void createProject() {
    if (_formKey.currentState?.validate() ?? false) {

      Project project     = new Project();
      project.name        = nameController.text;
      project.webLink     = webLinkController.text;
      project.description = descriptionController.text;
      project.budget      = double.parse(budgetController.text);
      project.image       = imageUrl;

      locator<ProjectService>().saveProject(project);
      _showConfirmDialog();
      Navigator.of(context).pop(true);
    }
  }
  void _showConfirmDialog() async {
    await showDialog<void>(
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
        child: Container(
          padding: EdgeInsets.all(size.width * 0.01) +
              EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05 ),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    "User name must be between five and 20 characters long.",
              ),
              SizedBox(height: 10),
              const Text(
                "Link",
                style: titleInputStyle,
              ),
              TextInput(
                "Link",
                webLinkController,
                icon: Icons.drive_file_rename_outline,
                regexp: RegExp(r".{5,50}$"),
                errorMsg: "Link must be between five  and 50 characters long.",
              ),
              SizedBox(height: 10),
              const Text(
                "Description",
                style: titleInputStyle,
              ),
              TextInput(
                "Description",
                descriptionController,
                icon: Icons.drive_file_rename_outline,
                regexp: RegExp(r".{5,200}$"),
                errorMsg: "Must be between five and 200 characters long.",
              ),
              SizedBox(height: 10),
              const Text(
                "Budget",
                style: titleInputStyle,
              ),
              TextInput(
                "Budget",
                budgetController,
                icon: Icons.drive_file_rename_outline,
                inputType: TextInputType.number,
                regexp: RegExp(r".{1,10}$"),
                errorMsg: "Must be a number",
              ),
              SizedBox(height: 10),
              const Text(
                "Closing date",
                style: titleInputStyle,
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(closingDate.toIso8601String()),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  ElevatedButton(
                      onPressed: () => changeClosingDate(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.calendar_today_sharp),
                      )),
                ],
              ),
              SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () => createProject(),
                  child: Text("Create project"))
            ],
          ),
        ),
      ),
    );
  }


}
