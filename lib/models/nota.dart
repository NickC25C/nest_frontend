import 'dart:io';
import 'package:nest_fronted/models/publiNoId.dart';
import 'package:nest_fronted/models/publication.dart';

class NotaPub extends Publication {
  final String mensaje;
  NotaPub({
    required super.id,
    required super.titulo,
    required super.owner,
    required super.date,
    super.publiType = PublicationType.note,
    required this.mensaje,
  });
}
