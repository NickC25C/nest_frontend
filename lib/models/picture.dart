import 'dart:io';

import 'package:nest_fronted/models/publiNoId.dart';
import 'package:nest_fronted/models/publication.dart';

class Picture extends Publication {
  final String? url;
  final File? image;
  Picture(
      {required super.id,
      required super.titulo,
      required super.owner,
      required super.date,
      super.publiType = PublicationType.picture,
      required this.url,
      required this.image});
}
