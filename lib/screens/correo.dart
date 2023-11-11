import 'package:flutter/material.dart';

import '../main.dart';

class CorreoScreen extends StatelessWidget {
  const CorreoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          RawMaterialButton(
            onPressed: () {
              // Acción cuando se presiona el botón
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
          ),
        ],
      )
    );
  }
}