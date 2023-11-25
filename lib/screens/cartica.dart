import 'package:flutter/material.dart';

import '../main.dart';
import '../widgets/barra_publi.dart';

class CartaScreen extends StatelessWidget {
  final String tituloCarta;
  final String usuario;
  final String mensaje;
  const CartaScreen(
      {super.key,
      required this.tituloCarta,
      required this.mensaje,
      required this.usuario});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: actual.colorScheme.background,
        child: Column(
          children: [
            BarraPublicar(titulo: tituloCarta),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    mensaje,
                    style: TextStyle(fontSize: 19.0),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'De: ' + usuario,
                      )
                    ],
                  )
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
