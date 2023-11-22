import 'dart:io';

import 'package:flutter/material.dart';

class Foto extends StatefulWidget {
  final String url;
  final File file;
  const Foto({
    super.key,
    required this.url,
    required this.file,
  });
  @override
  State<Foto> createState() => _FotoState();
}

class _FotoState extends State<Foto> {
  late final String fotoUrl;
  late final File image;

  void initState() {
    super.initState();
    fotoUrl = widget.url;
    image = widget.file;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        height: 300,
        width: 300,
        child: Image(
          image: NetworkImage(image.path),
          fit: BoxFit.cover,
        ));
  }
}
