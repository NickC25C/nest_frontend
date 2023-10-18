import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nest_fronted/widgets/barra_titulo.dart';
import 'package:nest_fronted/widgets/boton_circular.dart';
import 'package:nest_fronted/widgets/nota.dart';
import 'package:nest_fronted/widgets/foto.dart';

const tituloScreen = 'MI TABLÓN PERSONAL';
int selectedIndex = 0;

double _opacityLevel = 0;
double _sigmaLevel = 0;

class TablonScreen extends StatefulWidget {
  const TablonScreen({super.key});

  @override
  TablonState createState() => TablonState();
}

class TablonState extends State<TablonScreen> {
  void publicar() {
    setState(() {
      _opacityLevel = 0.5;
      _sigmaLevel = 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Stack(
      children: <Widget>[
        tablon(),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: _sigmaLevel, sigmaY: _sigmaLevel),
          child: Container(
            color: Colors.black.withOpacity(_opacityLevel),
          ),
        )
      ],
    ));
  }

//Se ha de cambiar por un stack para la foto de fondo

  Widget tablon() {
    return Column(
      children: [
        const BarraTitulo(titulo: tituloScreen),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          height: 600,
          width: 700,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ListView(
                children: const [
                  Nota(
                    tituloNota: 'SALUDO',
                  ),
                  Foto(url: ('assets/images/rata.png'))
                ],
              ),
              Container(
                alignment: Alignment.bottomRight,
                margin: const EdgeInsets.all(10),
                child: BotonCircular(
                    iconoBoton: const Icon(Icons.add), click: publicar),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
