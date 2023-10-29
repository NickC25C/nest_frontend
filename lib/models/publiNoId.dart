import 'package:nest_fronted/models/user.dart';

enum PublicationType { note, picture, song }

class PubliNoId {
  final String titulo;
  final User owner;
  final DateTime date;
  final PublicationType publiType;

  PubliNoId(
      {required this.titulo,
      required this.owner,
      required this.date,
      required this.publiType});
}
