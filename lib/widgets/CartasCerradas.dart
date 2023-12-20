import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../main.dart';
import '../models/letter.dart';
import '../models/user.dart';
import '../screens/cartica.dart';

class CartasCerradas extends StatefulWidget {
  final Letter carta;
  final List<User> usuarios;

  CartasCerradas({
    required this.carta,
    required this.usuarios,
  });

  @override
  _CartasCerradasState createState() => _CartasCerradasState();
}

class _CartasCerradasState extends State<CartasCerradas> {
  late String avatar = api.loggedUser.avatar;
  late bool isFavorita;

  @override
  void initState() {
    super.initState();
    extractUser();
    isFavorita = widget.carta.favUserId != null;
  }

  Future<void> extractUser() async {
    try {
      User usu =
      await api.getUser(widget.carta.originUserId);
      setState(() {
        avatar = usu.avatar;
      });
    } catch (e) {
      // Manejar el error de la solicitud
      print('Error en la solicitud: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: RawMaterialButton(
        onPressed: () async {
          await api.updateLetter(widget.carta.id, widget.carta);
          Navigator.push(
            context,
            PageTransition(
              child: CartaScreen(
                  tituloCarta: widget.carta.title,
                  mensaje: widget.carta.text,
                  usuario: widget.usuarios
                      .firstWhere((element) => element.id == widget.carta.originUserId)
                      .username),
              type: PageTransitionType.fade,
            ),
          );
        },
        elevation: 8.0,
        fillColor: actual.colorScheme.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        constraints: BoxConstraints(
          minWidth: double.infinity,
          minHeight: 100.0,
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
                      'assets/images/${avatar}.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  )
                ],
              ),
              Container(
                width: 122,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '@' + widget.usuarios
                          .firstWhere((element) => element.id == widget.carta.originUserId)
                          .username,
                      style: TextStyle(
                        color: actual.colorScheme.onSecondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      widget.carta.title,
                      style: TextStyle(
                        color: actual.colorScheme.onSecondary,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 50,
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isFavorita = !isFavorita;
                      });

                      if (isFavorita) {
                        api.addToFavourite(widget.carta.id);
                      } else {
                        api.deleteFromFavourite(widget.carta.id);
                      }
                    },
                    icon: Icon(
                      isFavorita ? Icons.favorite : Icons.favorite_outline,
                      color: isFavorita ? Colors.black : actual.colorScheme.onSecondary,
                    ),
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
