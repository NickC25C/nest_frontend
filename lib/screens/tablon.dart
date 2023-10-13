import 'package:flutter/material.dart';
import 'package:nest_fronted/widgets/barra_titulo.dart';

const tituloScreen = 'MI TABLÓN PERSONAL';

class TablonScreen extends StatelessWidget {
  const TablonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [
        //Barra de título
        BarraTitulo(titulo: tituloScreen),

        //Tablón
        Tablon()
      ],
    ));
  }
}

//Se ha de cambiar por un stack para la foto de fondo
class Tablon extends StatelessWidget {
  const Tablon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      color: Colors.brown,
      height: 700,
      width: 700,
      child: const Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('prueba')],
          )
        ],
      ),
    );
  }
}
