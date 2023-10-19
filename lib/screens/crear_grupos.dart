import 'package:flutter/material.dart';
import 'package:nest_fronted/widgets/titulo_pub.dart';
import 'package:nest_fronted/main.dart';


const tituloScreen = 'NUEVO GRUPO';

class CrearGrupos extends StatelessWidget {
  const CrearGrupos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BarraGrupo(titulo: tituloScreen),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Titulo(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Descripcion(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                children: [
                  DropdownSample(),
                  Listado(),
                ],
              ),
            ),
            BotonCrear(),
          ],
        ),
      )
    );
  }
}

class BarraGrupo extends StatelessWidget {
  final String titulo;
  const BarraGrupo({
    super.key,
    required this.titulo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 40),
      color: Colors.grey,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          IconButton(
            onPressed: () {
              Navigator.pop(
                context
              );
            },
            icon: Icon(Icons.arrow_circle_left, color: Colors.white, size: 30),
          ),
          Text(
            titulo,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
            SizedBox(
              width: 50,
            )
          ],
      ),
    );
  }
}

class Descripcion extends StatelessWidget {
  const Descripcion({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        width: double.infinity,
        child: TextField(
          maxLines: 8,
          decoration: InputDecoration(
            labelText : 'Descripción',
            border: OutlineInputBorder(),
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
      height: 150,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView(
        padding: EdgeInsets.all(0.0),
        children: [
          ListTile(title: Text('Ítem 1'),),
          ListTile(title: Text('Ítem 2')),
          ListTile(title: Text('Ítem 3')),
        ],
      ),
    );
  }
}

class BotonCrear extends StatelessWidget {
  const BotonCrear({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          height: 60,
          width: 150,
          child: TextButton.icon(
            onPressed: (){},
            icon: Icon(Icons.groups, color: Colors.white,),
            label: Text('Crear grupo', style: TextStyle(color: Colors.white),),
            style: TextButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  )
              ),
            ),
        ),
      ),
    );
  }
}