import 'package:flutter/material.dart';

class Nota extends StatelessWidget {
  final String tituloNota;
  final String mensaje;
  const Nota({super.key, required this.tituloNota, required this.mensaje});

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
      child: Text(
        tituloNota,
        style: const TextStyle(fontWeight: FontWeight.bold),
        textScaleFactor: 1,
        textAlign: TextAlign.center,
      ),
    );
  }
}
