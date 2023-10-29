import 'package:nest_fronted/models/publiNoId.dart';

class Publication extends PubliNoId {
  final int id;

  Publication(
      {required this.id,
      required super.titulo,
      required super.owner,
      required super.date,
      required super.publiType});
}
