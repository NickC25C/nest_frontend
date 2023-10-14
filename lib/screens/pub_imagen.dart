import 'package:flutter/material.dart';
import 'package:nest_fronted/widgets/barra_publicar.dart';

const tituloScreen = 'PUBLICAR NOTA';

class PubImagenScreen extends StatelessWidget {
  const PubImagenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          BarraPublicar(titulo: tituloScreen),
        ],
      )
    );
  }
}