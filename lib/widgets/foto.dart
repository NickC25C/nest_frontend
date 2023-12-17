import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nest_fronted/models/picture.dart';

import '../main.dart';

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
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/${api.loggedUser.avatar}.png'),
                            fit: BoxFit.fitWidth),
                      )),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    '@' + foto.owner.username,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
                  ),
                ],
              ),
              Container(
                  height: 300,
                  width: 300,
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
