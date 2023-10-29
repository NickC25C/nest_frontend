import 'dart:io';

import 'package:nest_fronted/models/publication.dart';

class Note extends Publication
{
  final String text;
  Note({required super.id, required super.owner, required super.date, required super.publiType, required this.text});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      owner: json['owner'],
      date: json['date'],
      publiType: json['publiType'],
      text: json['text'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> m = super.toJson();
    m.addAll({
      'text': text,
    });
    return m;
  }
}