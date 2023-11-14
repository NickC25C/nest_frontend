import 'package:flutter/material.dart';
import 'package:nest_fronted/screens/cartica.dart';
import 'package:nest_fronted/screens/enviar_carta.dart';
import 'package:page_transition/page_transition.dart';

import '../main.dart';

class CorreoScreen extends StatelessWidget {
  const CorreoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Stack(
          children: [
            Container(
              height: screenSize.height,
              child: ListView(
                children: [
                  Column(
                    children: [
                      Cartas(),
                      Cartas(),
                      Cartas(),
                      Cartas(),
                      Cartas(),
                      Cartas(),
                      Cartas(),
                      Cartas(),
                      Cartas(),
                      Cartas(),
                      Cartas(),
                    ],
                  ),
                ]
              ),
            ),
            Positioned(
              bottom: 170,
              right: 8.0,
              child:
              BotonEnviarCarta(),
            ),
          ],
        ),
    );
  }
}

class Cartas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return   RawMaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          PageTransition(
            child: CartaScreen(
                tituloCarta: 'Almidon',
                mensaje: 'La porroflexia es una técnica que consiste en crear formas y estructuras'
                    ' a partir del liado de porros de marihuana. Esta técnica, que requiere de '
                    'habilidades manuales y una gran dosis de creatividad, ha evolucionado hasta '
                    'convertirse en una verdadera forma de arte. A través de la porroflexia, se pueden'
                    ' crear figuras y formas de todo tipo, desde animales hasta aviones, pasando por personajes '
                    'de ficción y elementos de la naturaleza.',
                usuario: 'Pepe'),
            type: PageTransitionType.fade,
          ),
        );
      },
      elevation: 2.0, // Altura de la sombra del botón
      fillColor: actual.colorScheme.secondary, // Color de fondo del botón
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
        side: BorderSide(color: Colors.white), // Borde blanco
      ),
      constraints: BoxConstraints(
        minWidth: double.infinity, // Ancho mínimo
        minHeight: 100.0, // Altura mínima
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: actual.colorScheme.onSecondary,
              radius: 35,
              backgroundImage: AssetImage('assets/images/PAJAROTOS.png'),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nombre_Usuario',
                  style: TextStyle(color: actual.colorScheme.onSecondary, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Almidon',
                  style: TextStyle(color: actual.colorScheme.onSecondary, fontSize: 14,),
                ),
              ],
            ),
            Container(
              width: 80,
            ),
            Column(
              children: [
                SizedBox(height: 30,),
                Icon(Icons.star, color: actual.colorScheme.onSecondary,)
              ],
            )
          ],
        ),
      ),
    );
  }

}
class BotonEnviarCarta extends StatelessWidget {
  const BotonEnviarCarta({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          height: 50,
          width: 150,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  child: EnviarCartaScreen(),
                  type: PageTransitionType.fade,
                ),
              );
            },
            child: Row(
              children: [
                Icon(
                  Icons.mark_email_unread_outlined,
                  color: actual.colorScheme.onPrimary,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                'Enviar Carta',
                style: TextStyle(color: actual.colorScheme.onPrimary),
                )
              ],
            ),
            style: TextButton.styleFrom(
                backgroundColor: actual.colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                )),
          ),
        ),
      ),
    );
  }
}