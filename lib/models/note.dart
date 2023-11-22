import 'package:nest_fronted/main.dart';
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
      required this.message, required super.watchers});

  factory Note.fromJson(Map<String, dynamic> json, User u) {
    return Note(
        id: json['id'],
        owner: u,
        date: DateTime.parse(json['date']),
        publiType: toPubType(json['publiType']),
        title: json['title'],
        message: json['message'], watchers: []);
  }
  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> m = super.toJson();
    m.addAll({'title': title, 'message': message});
    return m;
  }
}
