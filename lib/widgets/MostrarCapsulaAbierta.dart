import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../models/capsule.dart';
import '../screens/capsulaAbierta.dart';

class CapsulaAbierta extends StatelessWidget {
  final Capsule capsula;
  const CapsulaAbierta({Key? key, required this.capsula}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String txt;
    if (capsula.description.length <= 40) {
      txt = capsula.description;
    } else {
      txt = '${capsula.description.substring(0, 39)}...';
    }
    return Container(
      height: 150.0,
      width: double.infinity,
      child: RawMaterialButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              child: CapsulaAbiertaScreen(
                capsula: capsula,
              ),
              type: PageTransitionType.fade,
            ),
          );
        },
        elevation: 2.0,
        fillColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0), // Bordes más gruesos
          side: BorderSide(color: Colors.black, width: 2.0), // Borde más grueso
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 8.0),
                  Text(
                    capsula.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    txt,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}