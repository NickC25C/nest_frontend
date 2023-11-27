import 'package:flutter/material.dart';
import 'package:nest_fronted/screens/cartica.dart';
import 'package:nest_fronted/screens/enviar_carta.dart';
import 'package:page_transition/page_transition.dart';
import 'package:nest_fronted/models/letter.dart';

import '../main.dart';

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
                        );
                      } else {
                        return CartasCerradas(
                          carta: cartasRecibidas[index],
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

class CartasAbiertas extends StatelessWidget {
  final Letter carta;

  CartasAbiertas({
    required this.carta,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
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
      elevation: 2.0,
      // Altura de la sombra del botón
      fillColor: actual.colorScheme.primary,
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
              backgroundColor: actual.colorScheme.secondary,
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
                      color: actual.colorScheme.onPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  carta.title,
                  style: TextStyle(
                    color: actual.colorScheme.secondary,
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

class CartasCerradas extends StatelessWidget {
  final Letter carta;

  CartasCerradas({
    required this.carta,
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
