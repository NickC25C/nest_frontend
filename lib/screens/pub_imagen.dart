import 'package:flutter/material.dart';
import 'package:nest_fronted/widgets/barra_publicar.dart';

const tituloScreen = 'PUBLICAR IMAGEN';

class PubImagenScreen extends StatelessWidget {
  const PubImagenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BarraPublicar(titulo: tituloScreen),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BotonIzquierdo(),
              BotonDerecho(),
            ],
          ),
          AnyadirImagen(imagen: 'assets/images/anyadir_imagen.png'),
          Titulo(),
          Column(
            children: [
              DropdownSample(),
              Listado(),
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

class AnyadirImagen extends StatelessWidget {
  final String imagen;
  const AnyadirImagen({
    super.key,
    required this.imagen,
  });

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(imagen),
      width: 150.0,
      height: 150.0,
      fit: BoxFit.fill,
    );
  }

}

class Titulo extends StatelessWidget {
  const Titulo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
            width: double.infinity,
            child: TextField(
              decoration: InputDecoration(
                labelText : 'Titulo',
                border: UnderlineInputBorder(),
                hintText: 'La Rata Ladrona',
              ),
            ),
      ),
    );
  }
}

class DropdownSample extends StatefulWidget {
  @override
  _Enviar createState() => _Enviar();
}

class _Enviar extends State<DropdownSample> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enviar A:'),
            Container(
              width: double.infinity,
              child: DropdownButton<String>(
              items: <String>['Opción 1', 'Opción 2'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),

              value: selectedValue,
              hint: Text('Selecciona una opción'),
              onChanged: (String? newValue){
                setState(() {
                  selectedValue = newValue;
                });
              }),
            ),
          ],
        ),
      );
  }
}

class Listado extends StatelessWidget {
  const Listado({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView(
        children: [
          ListTile(title: Text('Ítem 1'),),
          ListTile(title: Text('Ítem 2')),
          ListTile(title: Text('Ítem 3')),
        ],
      ),
    );
  }
}