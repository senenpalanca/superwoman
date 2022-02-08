import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:superwoman/model/stakeholder.dart';
import 'package:uuid/uuid.dart';

class StakeholderService {
  final collection = 'stakeholders';
  final uuid = Uuid();

  saveStakeholder(Stakeholder stakeholder) async {
    stakeholder.id = uuid.v1();
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(stakeholder.id)
        .set(stakeholder.toMap());
  }

  deleteStakeholder(Stakeholder stakeholder) async {
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(stakeholder.id)
        .delete();
  }

  getAll() async {
    var x = await FirebaseFirestore.instance.collection(collection).get();

    return x.docs.map((e) => Stakeholder.fromMap(e.data())).toList();
  }

  getNoStakeholders() async {
    var x = await FirebaseFirestore.instance.collection(collection).get();

    return x.docs.length;
  }
}
