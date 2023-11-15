import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'capsulaAbierta.dart';
import 'capsulaCerrada.dart';
import 'crear_capsula.dart';

class CapsulaScreen extends StatelessWidget {
  const CapsulaScreen({Key? key});

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
                  CapsulaCerrada(),
                  SizedBox(height: 16.0),
                  CapsulaAbierta(),
                  SizedBox(height: 16.0),
                ],
            ),
          ),
          Positioned(
              bottom: 170,
              right: 8.0,
              child:
              BotonCrearCapsula(),
          ),
        ],
      ),
    );
  }
}

class CapsulaCerrada extends StatelessWidget {
  const CapsulaCerrada({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/rata.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Opacity(
        opacity: 0.6,
        child: Container(
          color: Colors.black,
          child: RawMaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  child: CapsulaCerradaScreen(),
                  type: PageTransitionType.fade,
                ),
              );
            },
            elevation: 2.0,
            fillColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(color: Colors.white),
            ),
            constraints: BoxConstraints(
              minWidth: double.infinity,
              minHeight: 150.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Títulin',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'CUENTA ATRAS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CapsulaAbierta extends StatelessWidget {
  const CapsulaAbierta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double anchoImagen = 150.0;
    return Container(
      height: 150.0,
      width: double.infinity,
      child: RawMaterialButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              child: CapsulaAbiertaScreen(),
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
            Image.asset(
              'assets/images/rata.png',
              fit: BoxFit.cover,
              width: anchoImagen,
              height: double.infinity,
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.0),
                  Text(
                    'Títulin Titulon',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Las pirámides, son grandes y puntiagudas',
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

class BotonCrearCapsula extends StatelessWidget {
  const BotonCrearCapsula({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              child: CrearCapsula(),
              type: PageTransitionType.fade,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // Bordes redondeados
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Crear Cápsula',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
    );
  }
}
