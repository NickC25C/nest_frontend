import 'package:nest_fronted/models/publication.dart';
import 'package:nest_fronted/models/user.dart';

class Note extends Publication {
  final String title;
  final String message;
  Note(
      {required super.id,
      required super.owner,
      required super.date,
      required super.publiType,
      required this.title,
      super.watchers,
      required this.message});

  factory Note.fromJson(Map<String, dynamic> json, User u) {
    return Note(
        id: json['id'],
        owner: u,
        date: DateTime.parse(json['date']),
        publiType: toPubType(json['publiType']),
        title: json['title'],
        message: json['message']);
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      'ownerId': owner.id,
      'watchers': watchers,
      'title': title,
      'message': message,
    };
  }
}
