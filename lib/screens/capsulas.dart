import 'package:flutter/material.dart';

class CapsulaScreen extends StatelessWidget {
  const CapsulaScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CapsulaCerrada(),
          SizedBox(height: 16.0),
          CapsulaAbierta(),
          SizedBox(height: 16.0),
          CrearCapsula(),
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
            onPressed: () {   },
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
          // fiaun fiaun
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

class CrearCapsula extends StatelessWidget {
  const CrearCapsula({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Acción cuando se presiona el botón
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
      ),
    );
  }
}
