import 'package:flutter/material.dart';
import 'package:superwoman/model/project.dart';

class Stakeholder{
  String? id;
  String? name;
  String? email;
  String? webLink;
  double? amount;
  List<Project>? projects;

  Stakeholder(this.id,this.name,this.email,this.webLink,this.amount,this.projects,);

  Stakeholder.fromData({ this.id,
    this.name,
    this.webLink,
    this.email,
    this.amount,
    this.projects,
  });

  toMap() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "webLink": webLink,
      "amount": amount,
      "projects": projects?.map((e) => e.toMap()).toList(),

    };
  }

  static fromMap(Map<String, dynamic> map) {

    return Stakeholder.fromData(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      amount: double.parse(map['amount'].toString()),
      webLink: map['webLink'],
      projects:
      List<Project>.from(new List<Map>.from(map['projects'])
          .map((e) => Project.fromMap(e))
          .toList()),

    );
  }
}