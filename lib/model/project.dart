import 'package:flutter/material.dart';

class Project{
  String name;
  String webLink;
  String description;
  Image image;
  double budget;
  DateTime closingDate;
  Project(this.name,this.webLink,this.description,this.image,this.budget,this.closingDate);
}