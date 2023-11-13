import 'package:flutter/material.dart';

class CapsulaCerradaScreen extends StatelessWidget {
  const CapsulaCerradaScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Foteque(),
              Positioned(
                top: 0,
                left: 16,
                child: BotonAtras(),
              ),
            ],
          ),
          Titulo(),
          BarraDivisoria(),
          Descripcion(),
          Spacer(), // ocupa t0do el espacio q puede
          BarraDivisoria(),
          CuentaAtras(),
          SizedBox(height: 16),
          BarraDivisoria(),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BotonCompartir(),
              BotonAnyadir(),
            ],
          ),
        ],
      ),
    );
  }
}

class Foteque extends StatelessWidget {
  const Foteque({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4, // ocupa 1/4 de la pantalla
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/rata.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class BotonAtras extends StatelessWidget {
  const BotonAtras({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_circle_left, size: 30),
      onPressed: () {      },
    );
  }
}

class Titulo extends StatelessWidget {
  const Titulo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 16),
        Text(
          'Titulin',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

class Descripcion extends StatelessWidget {
  const Descripcion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Text(
        'Quien se ha follao a tu bitch? Yung beef. Quien? Seko boy Aka Yung beef',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}


class BarraDivisoria extends StatelessWidget {
  const BarraDivisoria({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.black,
      thickness: 2,
      indent: 16,
      endIndent: 16,
    );
  }
}

class BotonCompartir extends StatelessWidget {
  const BotonCompartir({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {      },
      child: Icon(Icons.share),
    );
  }
}

class BotonAnyadir extends StatelessWidget {
  const BotonAnyadir({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {      },
      child: Icon(Icons.add),
    );
  }
}

class CuentaAtras extends StatelessWidget {
  const CuentaAtras({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Tiempo hasta desbloqueo:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        SizedBox(height: 8),
        Center(
          child: Text(
            'CUENTA ATRAS',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}
