import 'package:flutter/material.dart';
import 'package:nest_fronted/widgets/barra_titulo.dart';
import 'package:nest_fronted/screens/crear_grupos.dart';

const tituloScreen = 'GRUPOS Y AMISTADES';
int selectedIndex = 0;

class AmisGrupScreen extends StatelessWidget {
  const AmisGrupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
        children: [

          BarraTitulo(titulo: tituloScreen),

          Solicitudes(),

          Grupos(),

          Crear(),
        ],
    );
  }
}

//Aceptar o denegar solicitudes
class Solicitudes extends StatelessWidget {
  const Solicitudes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 40.5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
            'Solicitudes:',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Container(
          height: 190.0,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Scrollbar(
            child: ListView(
              padding: EdgeInsets.only(top: 0.0),
              children: [
                ListTile(
                  title: Text('Guillem_proxeneta69'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          //ja vorem
                        },
                        child: Text('✔️'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purpleAccent,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      ElevatedButton(
                        onPressed: () {
                          //ja vorem
                        },
                        child: Text('✖️'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purpleAccent,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Text('Ivan_politoxicomano33'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          //ja vorem
                        },
                        child: Text('✔️'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purpleAccent,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      ElevatedButton(
                        onPressed: () {
                          //ja vorem
                        },
                        child: Text('✖️'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purpleAccent,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Text('Magic_Patrisio777'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          //ja vorem
                        },
                        child: Text('✔️'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purpleAccent,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      ElevatedButton(
                        onPressed: () {
                          //ja vorem
                        },
                        child: Text('✖️'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purpleAccent,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Text('Pepe_Viyuela'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          //ja vorem
                        },
                        child: Text('✔️'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purpleAccent,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      ElevatedButton(
                        onPressed: () {
                          //ja vorem
                        },
                        child: Text('✖️'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purpleAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        ),
      ],
    );
  }
}

//visualizar los grupos y la contidad de gente de estos
class Grupos extends StatelessWidget {
  const Grupos({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 40.5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
            'Grupos:',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Container(
          height: 190.0,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Scrollbar(
            child: ListView(
              padding: EdgeInsets.only(left: 10.0),
              children: [
                ListTile(
                  contentPadding: EdgeInsets.only(right: 60.0),

                  title: Text('Familia'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '1',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Icon(
                        Icons.group,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),

                ListTile(
                  contentPadding: EdgeInsets.only(right: 60.0),

                  title: Text('Colegio'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '18',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Icon(
                        Icons.group,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(right: 60.0),

                  title: Text('mckdhvudif'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '18334',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Icon(
                        Icons.group,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(right: 60.0),

                  title: Text('Nest'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '12',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Icon(
                        Icons.group,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
          ),
      ],
    );
  }
}

//boton de redireccion a crear grupos
class Crear extends StatelessWidget {
  const Crear({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CrearGrupos()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purpleAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.group),
                  SizedBox(width: 8.0),
                  Text('Crear grupo'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
