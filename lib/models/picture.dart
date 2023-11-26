import 'dart:io';

import 'package:nest_fronted/models/publication.dart';
import 'package:nest_fronted/models/user.dart';

class Picture extends Publication {
  final String description;
  final String? url;
  final File? image;
  Picture(
      {required super.id,
      required super.owner,
      required super.date,
      required super.publiType,
      required this.description,
      required this.url,
      required this.image,
      required super.watchers});

  factory Picture.fromJson(Map<String, dynamic> json, User u, File? f) {
    return Picture(
        id: json['id'],
        owner: u,
        date: DateTime.parse(json['date']),
        publiType: toPubType(json['publiType']),
        description: json['description'],
        url: json['url'],
        image: f,
        watchers: []);
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> m = super.toJson();
    m.addAll({'url': null, 'image': null});
    return m;
  }
}
