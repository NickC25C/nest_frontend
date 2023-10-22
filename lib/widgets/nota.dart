import 'package:flutter/material.dart';

class Nota extends StatelessWidget {
  final String tituloNota;
  final String usu;
  final String mensaje;
  const Nota(
      {super.key,
      required this.tituloNota,
      required this.mensaje,
      required this.usu});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 200,
      width: 200,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/nota.png'),
        alignment: Alignment.center,
      )),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            tituloNota,
            style: const TextStyle(fontWeight: FontWeight.bold),
            textScaleFactor: 1,
            textAlign: TextAlign.center,
          )
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'De: ' + usu,
            style: const TextStyle(fontWeight: FontWeight.normal),
            textScaleFactor: 1,
            textAlign: TextAlign.center,
          )
        ]),
      ]),
    );
  }
}
