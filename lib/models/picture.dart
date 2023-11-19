import 'dart:io';

import 'package:nest_fronted/models/publication.dart';

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
      required this.image});

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
        id: json['id'],
        owner: json['owner'],
        date: json['date'],
        publiType: toPubType(json['publiType']),
        description: json['description'],
        url: json['url'],
        image: null);
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> m = super.toJson();
    m.addAll({'url': null, 'image': null});
    return m;
  }
}
