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
              child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'La porroflexia es una técnica que consiste en crear formas y estructuras'
                              ' a partir del liado de porros de marihuana. Esta técnica, que requiere de '
                              'habilidades manuales y una gran dosis de creatividad, ha evolucionado hasta '
                              'convertirse en una verdadera forma de arte. A través de la porroflexia, se pueden'
                              ' crear figuras y formas de todo tipo, desde animales hasta aviones, pasando por personajes '
                              'de ficción y elementos de la naturaleza.',
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
                              'De: Nombre_Usuario',
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