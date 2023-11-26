

import 'package:nest_fronted/models/publication.dart';

class Capsule {
  String id;
  String title;
  String description;
  String openDate;
  String imageURL;
  List<String> members;

  Capsule({
    required this.id,
    required this.title,
    required this.description,
    required this.openDate,
    required this.imageURL,
    required this.members
  });

  factory Capsule.fromJson(Map<String, dynamic> json) {
    return Capsule(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      openDate: json['openDate'],
      imageURL: json['imageURL'],
      members: List<String>.from(json['members'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'openDate': openDate,
      'imageURL': imageURL,
      'members': members
    };
  }
}