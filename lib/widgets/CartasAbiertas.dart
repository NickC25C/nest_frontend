import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../main.dart';
import '../models/letter.dart';
import '../models/user.dart';
import '../screens/cartica.dart';

class CartasAbiertas extends StatelessWidget {
  final Letter carta;
  final List<User> usuarios;

  CartasAbiertas({
    required this.carta,
    required this.usuarios,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: RawMaterialButton(
        onPressed: () {
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
        elevation: 10.0,
        // Altura de la sombra del botón
        fillColor: actual.colorScheme.surface,
        // Color de fondo del botón
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0), // Bordes redondeados
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
              Column(
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    child: Image.asset(
                      'assets/images/2.png', // Reemplaza con la ruta de tu imagen
                      fit: BoxFit.contain, // Ajusta la imagen al contenedor
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '@' + usuarios
                        .firstWhere((element) => element.id == carta.originUserId)
                        .username,
                    style: TextStyle(
                        color: actual.colorScheme.onPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    carta.title,
                    style: TextStyle(
                      color: actual.colorScheme.onPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Container(
                width: 80,
              ),
              Column(
                children: [
                  IconButton(
                    color: actual.colorScheme.onPrimary,
                    onPressed: () {  },
                    icon: Icon(Icons.favorite_outline),
                  ),
                  SizedBox(
                    height: 35,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}