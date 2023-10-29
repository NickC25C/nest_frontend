import 'package:flutter/material.dart';
import 'package:nest_fronted/models/nota.dart';
import 'package:nest_fronted/models/picture.dart';
import 'package:nest_fronted/models/publiNoId.dart';
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
      NotaPub notaPubli = pub as NotaPub;
      return Nota(
          tituloNota: notaPubli.titulo,
          mensaje: notaPubli.mensaje,
          usu: notaPubli.owner.username);
    } else {
      Picture pic = pub as Picture;
      return Foto(url: pic.url!, file: pic.image!);
    }
  }
}
