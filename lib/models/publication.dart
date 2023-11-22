import 'package:nest_fronted/main.dart';
import 'package:nest_fronted/models/note.dart';
import 'package:nest_fronted/models/picture.dart';
import 'package:nest_fronted/models/user.dart';

enum PublicationType { note, picture, song }

PublicationType toPubType(String type) {
  if (type == "Note") {
    return PublicationType.note;
  } else {
    return PublicationType.picture;
  }
}

class Publication {
  final String id;
  final User owner;
  final DateTime date;
  final PublicationType publiType;
  final List<String> watchers;

  Publication(
      {required this.id,
      required this.owner,
      required this.date,
      required this.publiType,
      required this.watchers});

  factory Publication.fromJson(Map<String, dynamic> json, User u) {
    if (json['publiType'] == "Note") {
      return Note.fromJson(json, u);
    } else {
      return Picture.fromJson(json);
    }
  }

  Map<String, dynamic> toJson() {
    return {'owner': owner, 'date': date, 'publiType': publiType};
  }
}
