import 'package:flutter/material.dart';
import 'package:nest_fronted/models/note.dart';
import 'package:nest_fronted/models/picture.dart';
import 'foto.dart';
import 'nota.dart';
import 'package:nest_fronted/models/publication.dart';

class PublicationWidget extends StatelessWidget {
  final Publication pub;
  const PublicationWidget({
    super.key,
    required this.pub,
  });

  @override
  Widget build(BuildContext context) {
    if (pub.publiType == PublicationType.note) {
      Note notaPubli = pub as Note;
      return Nota(
        nota: notaPubli,
      );
    } else {
      Picture pic = pub as Picture;
      return Foto(
        foto: pic,
      );
    }
  }
}
