import 'package:flutter/material.dart';

class Project{
  String? id;
  String? name;
  String? webLink;
  String? description;
  String? image;
  double? budget;
  DateTime? closingDate;

  Project({this.name,this.webLink,this.description,this.image,this.budget,this.closingDate,this.id});

  Project.fromData({ this.id,
    this.name,
    this.webLink,
    this.description,
    this.image,
    this.budget,
    this.closingDate,
  });

  toMap() {
    return {
      "id": id,
      "webLink": webLink,
      "description": description,
      "image": image,
      "budget": budget,
      "closingDate": closingDate,

    };
  }

  static fromMap(Map<dynamic, dynamic> map) {

    return Project.fromData(
      id: map['id'],
      webLink: map['webLink'],
      description: map['description'],
      budget: double.parse(map['budget'].toString()),
      image: map['image'],
      closingDate:
      map['closingDate'] != null ? map['closingDate'].toDate() : null,

    );
  }
}