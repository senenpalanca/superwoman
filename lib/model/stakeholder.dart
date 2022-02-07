import 'package:flutter/material.dart';
import 'package:superwoman/model/project.dart';

class Stakeholder{
  String name;
  String email;
  String webLink;
  double amount;
  List<Project> projects;
  Stakeholder(this.name,this.email,this.webLink,this.amount,this.projects);
}