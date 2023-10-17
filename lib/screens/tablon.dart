import 'package:flutter/material.dart';
import 'package:nest_fronted/screens/amis_grup.dart';
import 'package:nest_fronted/screens/configuracion.dart';
import 'package:nest_fronted/widgets/barra_titulo.dart';
import 'package:nest_fronted/widgets/boton_circular.dart';
import 'package:nest_fronted/widgets/nota.dart';
import 'package:nest_fronted/widgets/foto.dart';

const tituloScreen = 'MI TABLÓN PERSONAL';
int selectedIndex = 0;
clickar() {}

class TablonScreen extends StatelessWidget {
  const TablonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Tablon(),
    );
  }
}

//Se ha de cambiar por un stack para la foto de fondo
class Tablon extends StatelessWidget {
  const Tablon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10.0),
                    image: const DecorationImage(
                        image: AssetImage('assets/images/fondoTablon.jpg'),
                        fit: BoxFit.fill)),
              ),
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
                  child: const BotonCircular(
                    iconoBoton: Icon(Icons.add),
                    click: clickar,
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
