import 'package:flutter/material.dart';
import 'package:nest_fronted/widgets/barra_titulo.dart';

const tituloScreen = 'GRUPOS Y AMISTADES';
int selectedIndex = 0;

class AmisGrupScreen extends StatelessWidget {
  const AmisGrupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [

          BarraTitulo(titulo: tituloScreen),

          Solicitudes(),

          Grupos(),

          Crear(),
        ],
      ),
      bottomNavigationBar: BarraNavegacion(),
    );
  }
}

//barra de navegacion inferior
class BarraNavegacion extends StatefulWidget {
  const BarraNavegacion({
    super.key,
  });

  @override
  State<BarraNavegacion> createState() => _BarraNavegacionState();
}

class _BarraNavegacionState extends State<BarraNavegacion> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            activeIcon: Icon(Icons.home_filled),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            activeIcon: Icon(Icons.saved_search),
            label: 'Search',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            activeIcon: Icon(Icons.group_add),
            label: 'Friends',
            backgroundColor: Colors.purpleAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            activeIcon: Icon(Icons.settings_applications),
            label: 'Settings',
            backgroundColor: Colors.teal,
          ),
        ]);
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
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'Solicitudes:',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          height: 190.0,
          width: 350.0,
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
                      ),
                      SizedBox(width: 8.0),
                      ElevatedButton(
                        onPressed: () {
                          //ja vorem
                        },
                        child: Text('❌'),
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
                      ),
                      SizedBox(width: 8.0),
                      ElevatedButton(
                        onPressed: () {
                          //ja vorem
                        },
                        child: Text('❌'),
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
                      ),
                      SizedBox(width: 8.0),
                      ElevatedButton(
                        onPressed: () {
                          //ja vorem
                        },
                        child: Text('❌'),
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
                      ),
                      SizedBox(width: 8.0),
                      ElevatedButton(
                        onPressed: () {
                          //ja vorem
                        },
                        child: Text('❌'),
                      ),
                    ],
                  ),
                ),
              ],
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
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'Grupos:',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          height: 190.0,
          width: 350.0,
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
      ],
    );
  }
}

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
               //ja vorem
              },
              style: ElevatedButton.styleFrom(
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
