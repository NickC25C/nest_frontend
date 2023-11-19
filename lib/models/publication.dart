import 'package:nest_fronted/main.dart';
import 'package:nest_fronted/models/note.dart';
import 'package:nest_fronted/models/picture.dart';
import 'package:nest_fronted/models/user.dart';

enum PublicationType { note, picture, song }

class Publication {
  final String id;
  final User owner;
  final DateTime date;
  final PublicationType publiType;

  Publication(
      {required this.id,
      required this.owner,
      required this.date,
      required this.publiType});

  factory Publication.fromJson(Map<String, dynamic> json) {
    if (json['publiType'] == "Note") {
      return Note.fromJson(json);
    } else {
      return Picture.fromJson(json);
    }
  }

  Map<String, dynamic> toJson() {
    return {'owner': owner, 'date': date, 'publiType': publiType};
  }
}
