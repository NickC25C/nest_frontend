import 'package:flutter/material.dart';
import 'package:nest_fronted/screens/cartica.dart';
import 'package:nest_fronted/screens/enviar_carta.dart';
import 'package:page_transition/page_transition.dart';
import 'package:nest_fronted/models/letter.dart';

import '../main.dart';
import '../widgets/CartasAbiertas.dart';
import '../widgets/CartasCerradas.dart';

class CorreoScreen extends StatefulWidget {
  CorreoScreen({super.key});

  @override
  _CorreoScreenState createState() => _CorreoScreenState();
}

class _CorreoScreenState extends State<CorreoScreen> {
  late Future<List<Letter>> _cartasRecibidasFuture;

  @override
  void initState() {
    super.initState();
    _cartasRecibidasFuture = api.getLetterByUserId(api.loggedUser.id);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Stack(
        children: [
          FutureBuilder<List<Letter>>(
            future: _cartasRecibidasFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Mientras se carga, puedes mostrar un indicador de carga.
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // En caso de error, muestra un mensaje de error.
                return Text('Error: ${snapshot.error}');
              } else {
                // Si la operación es exitosa, construye el ListView.
                List<Letter> cartasRecibidas = snapshot.data ?? [];
                return Container(
                  height: screenSize.height - 150,
                  child: ListView.builder(
                    itemCount: cartasRecibidas.length,
                    itemBuilder: (context, index) {
                      if (cartasRecibidas[index].opened) {
                        return CartasAbiertas(
                          carta: cartasRecibidas[index],
                          usuarios: usuarios
                        );
                      } else {
                        return CartasCerradas(
                          carta: cartasRecibidas[index],
                          usuarios: usuarios
                        );
                      }
                    },
                  ),
                );
              }
            },
          ),
          Positioned(
            bottom: 20,
            right: 8.0,
            child: BotonEnviarCarta(),
          ),
        ],
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
