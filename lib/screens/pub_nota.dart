import 'package:flutter/material.dart';
import 'package:nest_fronted/widgets/barra_titulo.dart';

const tituloScreen = 'PUBLICAR NOTA';
int selectedIndex = 0;


class PubNotaScreen extends StatelessWidget {
  const PubNotaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          //Barra de título
          BarraTitulo(titulo: tituloScreen),

          Flechas(),

          Titulin(),

          Nota(),

          EnviarA(),

        ],
      ),
      bottomNavigationBar: BarraNavegacion(),
    );
  }
}

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

//iconos de flechas para retroceder o pasar a siguiente
class Flechas extends StatelessWidget {
  const Flechas({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward),
          onPressed: () {},
        ),
      ],
    );
  }
}

//titulo de la nota
class Titulin extends StatelessWidget {
  const Titulin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        width: double.infinity,
        child: TextField(
          decoration: InputDecoration(
            labelText : 'Título',
            border: UnderlineInputBorder(),
            hintText: 'Nick putero',
          ),
        ),
      ),
    );
  }
}

//contenido de la nota
class Nota extends StatelessWidget {
  const Nota({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 40.5),
        Text(
          'Mensaje:',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 25.5),
        Container(
          width: 350,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.black),
          ),
          child: TextField(
            maxLines: 15,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Lanza porreta',
            ),
          ),
        ),
      ],
    );
  }
}
//Seleccionar a los usuarios/grupos a los q enviar
class EnviarA extends StatelessWidget {
  const EnviarA({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 25.5),
        Text(
          'Enviar a:',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 25.5),
        Container(
          height: 120.0,
          width: 350,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ListView(
            padding: EdgeInsets.all(0.0),
            children: [
              ListTile(
                title: Text(
                'Antón',
                style: TextStyle(fontSize: 20.0),
                ),
              ),
              ListTile(
                title: Text(
                'Lanza',
                style: TextStyle(fontSize: 20.0),
                ),
              ),
              ListTile(
                title: Text(
                  'Colau',
                style: TextStyle(fontSize: 20.0),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}