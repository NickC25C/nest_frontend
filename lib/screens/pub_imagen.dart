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
          SizedBox(height: 20.0,),
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
      width: 150,
      height: 110,
      child: ElevatedButton(
        onPressed: (){},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.photo, color: Colors.white,),
            SizedBox(height: 3.0,),
            Text('Seleccionar foto', style: TextStyle(fontSize: 16))
          ],
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 30.0),
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
              )
          ),
        ),
      )
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
        width: 150,
        height: 110,
        child: ElevatedButton(
        onPressed: (){},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt, color: Colors.white,),
            SizedBox(height: 3.0,),
            Text('Hacer foto', style: TextStyle(fontSize: 16))
          ],
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 30.0),
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