import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:superwoman/model/project.dart';
import 'package:uuid/uuid.dart';

class ProjectService{

  final collection = 'projects';
  final uuid = Uuid();

  saveProject(Project project) async {
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(project.id)
        .set(project.toMap());
  }


}