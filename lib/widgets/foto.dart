import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nest_fronted/models/picture.dart';

class Foto extends StatefulWidget {
  final Picture foto;
  const Foto({
    super.key,
    required this.foto,
  });
  @override
  State<Foto> createState() => _FotoState();
}

class _FotoState extends State<Foto> {
  late final Picture foto;

  void initState() {
    super.initState();
    foto = widget.foto;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: SingleChildScrollView(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/Anselmo.png'),
                        fit: BoxFit.fitWidth),
                  )),
              Text(
                '@' + foto.owner.username,
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                        offset: Offset(0, 1),
                        blurRadius: 13)
                  ],
                  image: DecorationImage(
                    image: NetworkImage(foto.image!.path),
                    fit: BoxFit.cover,
                  ))),
        ]),
      ),
    );
  }
}
