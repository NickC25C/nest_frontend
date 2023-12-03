import 'dart:io';

import 'package:flutter/material.dart';

class Foto extends StatefulWidget {
  final File file;
  final String username;
  const Foto({
    super.key,
    required this.file,
    required this.username,
  });
  @override
  State<Foto> createState() => _FotoState();
}

class _FotoState extends State<Foto> {
  late final File image;
  late final String ownerName;

  void initState() {
    super.initState();
    image = widget.file;
    ownerName = widget.username;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: SingleChildScrollView(
        child: Column(children: [
          Text(
            ownerName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              height: 300,
              width: 300,
              child: Image(
                image: NetworkImage(image.path),
                fit: BoxFit.cover,
              ))
        ]),
      ),
    );
  }
}
