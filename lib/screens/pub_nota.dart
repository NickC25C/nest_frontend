import 'package:flutter/material.dart';
import 'package:nest_fronted/widgets/barra_publicar.dart';
import 'package:nest_fronted/widgets/titulo_pub.dart';

const tituloScreen = 'PUBLICAR NOTA';
int selectedIndex = 0;


class PubNotaScreen extends StatelessWidget {
  const PubNotaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Barra de título
            BarraPublicar(titulo: tituloScreen),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Titulo(),
            ),

            EscribirNota(),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                children: [
                  DropdownSample(),
                  Listado(),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}

//contenido de la nota
class EscribirNota extends StatelessWidget {
  const EscribirNota({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Mensaje:',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            width: double.infinity,
            child: TextField(
              maxLines: 8,
              decoration: InputDecoration(
                labelText : 'Mensaje',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
//Seleccionar a los usuarios/grupos a los q enviar
class DropdownSample extends StatefulWidget {
  @override
  _Enviar createState() => _Enviar();
}

class _Enviar extends State<DropdownSample> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Enviar A:', style: TextStyle(fontWeight: FontWeight.bold),),
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
      height: 150,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView(
        padding: EdgeInsets.all(0.0),
        children: [
          ListTile(title: Text('Antón'),),
          ListTile(title: Text('Lanza')),
          ListTile(title: Text('Colau')),
        ],
      ),
    );
  }
}