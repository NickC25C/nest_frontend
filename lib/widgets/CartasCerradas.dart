import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../main.dart';
import '../models/letter.dart';
import '../models/user.dart';
import '../screens/cartica.dart';

class CartasCerradas extends StatelessWidget {
  final Letter carta;
  final List<User> usuarios;

  CartasCerradas({
    required this.carta,
    required this.usuarios,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () async {
        await api.updateLetter(carta.id, carta);
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          PageTransition(
            child: CartaScreen(
                tituloCarta: carta.title,
                mensaje: carta.text,
                usuario: usuarios
                    .firstWhere((element) => element.id == carta.originUserId)
                    .username),
            type: PageTransitionType.fade,
          ),
        );
      },
      elevation: 2.0,
      // Altura de la sombra del botón
      fillColor: actual.colorScheme.secondary,
      // Color de fondo del botón
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
                  usuarios
                      .firstWhere((element) => element.id == carta.originUserId)
                      .username,
                  style: TextStyle(
                      color: actual.colorScheme.onSecondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  carta.title,
                  style: TextStyle(
                    color: actual.colorScheme.onSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Container(
              width: 80,
            ),
            Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Icon(
                  Icons.star,
                  color: actual.colorScheme.onSecondary,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}