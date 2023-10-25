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
            child: Listado(),
          ),
          BotonCrear(),
        ],
      ),
    ));
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
              Navigator.pop(context);
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
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        width: double.infinity,
        child: TextField(
          maxLines: 8,
          decoration: InputDecoration(
            labelText: 'Descripción',
            border: OutlineInputBorder(),
          ),
        ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Enviar a:',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: 150,
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListView(
            padding: EdgeInsets.all(0.0),
            children: [
              ListTile(
                title: Text(usuarios[0].username),
              ),
              ListTile(title: Text('Ítem 2')),
              ListTile(title: Text('Ítem 3')),
            ],
          ),
        ),
      ],
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
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          height: 50,
          width: 150,
          child: TextButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.groups,
              color: Colors.white,
            ),
            label: Text(
              'Crear grupo',
              style: TextStyle(color: Colors.white),
            ),
            style: TextButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                )),
          ),
        ),
      ),
    );
  }
}
