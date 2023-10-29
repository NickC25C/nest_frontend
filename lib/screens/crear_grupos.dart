import 'package:flutter/material.dart';
import 'package:nest_fronted/widgets/titulo_pub.dart';
import 'package:nest_fronted/widgets/barra_publi.dart';
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
          BarraPublicar(titulo: tituloScreen),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Titulo(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Listado(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
            child: BotonCrear(),
          ),
        ],
      ),
    ));
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
          height: 420,
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListView.builder(
            padding: EdgeInsets.all(0.0),
            itemCount: bd.loggedUser.friends!.length,
            itemBuilder: (BuildContext context, int index){
              return ListTile(
                  title: Text(bd.loggedUser.friends![index].username),
              );
            },
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
