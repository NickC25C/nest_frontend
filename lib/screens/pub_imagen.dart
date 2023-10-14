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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BotonIzquierdo(),
              BotonDerecho(),
            ],
          )
        ],
      )
    );
  }
}

class BotonIzquierdo extends StatelessWidget {
  const BotonIzquierdo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.0,
      height: 50.0,
      child: TextButton.icon(
        onPressed: (){},
        icon: Icon(Icons.photo, color: Colors.white,),
        label: Text('Seleccionar foto',
            style: const TextStyle(color: Colors.white)),
        style: TextButton.styleFrom(
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
              )
          ),
        ),
      ),
    );
  }
}

class BotonDerecho extends StatelessWidget {
  const BotonDerecho({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.0,
      height: 50.0,
      child: TextButton.icon(
        onPressed: (){},
        icon: Icon(Icons.camera_alt, color: Colors.white,),
        label: Text('Hacer foto',
            style: const TextStyle(color: Colors.white)),
        style: TextButton.styleFrom(
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              )
          ),
        ),
      ),
    );
  }
}