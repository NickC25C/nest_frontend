import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../main.dart';
import '../models/letter.dart';
import '../models/user.dart';
import '../screens/cartica.dart';

class CartasAbiertas extends StatefulWidget {
  final Letter carta;
  final List<User> usuarios;

  CartasAbiertas({
    required this.carta,
    required this.usuarios,
  });

  @override
  _CartasAbiertasState createState() => _CartasAbiertasState();
}

class _CartasAbiertasState extends State<CartasAbiertas> {

  late bool isFavorita;

  @override
  void initState() {
    super.initState();
    isFavorita = widget.carta.favUserId != null;
  }

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
                tituloCarta: widget.carta.title,
                mensaje: widget.carta.text,
                usuario: widget.usuarios
                    .firstWhere((element) => element.id == widget.carta.originUserId)
                    .username,
              ),
              type: PageTransitionType.fade,
            ),
          );
        },
        elevation: 10.0,
        fillColor: actual.colorScheme.surface,
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
                      'assets/images/${api.loggedUser.avatar}.png',
                      fit: BoxFit.contain,
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
                    '@' + widget.usuarios
                        .firstWhere((element) => element.id == widget.carta.originUserId)
                        .username,
                    style: TextStyle(
                      color: actual.colorScheme.onPrimary,
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
                      color: isFavorita ? Colors.black : actual.colorScheme.onPrimary,
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
