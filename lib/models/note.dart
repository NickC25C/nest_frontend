import 'dart:io';

import 'package:nest_fronted/models/publication.dart';

class Note extends Publication
{
  final String title;
  final String message;
  Note({required super.id, required super.owner, required super.date, required super.publiType, required this.title, required this.message});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      owner: json['owner'],
      date: json['date'],
      publiType: json['publiType'],
      title: json['title'],
      message: json['message']
    );
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> m = super.toJson();
    m.addAll({
      'title': title,
      'message': message
    });
    return m;
  }
}