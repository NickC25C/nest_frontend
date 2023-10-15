import 'package:flutter/material.dart';
import 'package:nest_fronted/widgets/barra_titulo.dart';
import 'package:nest_fronted/widgets/boton_circular.dart';
import 'package:nest_fronted/widgets/nota.dart';

const tituloScreen = 'MI TABLÓN PERSONAL';
int selectedIndex = 0;
clickar() {}

class TablonScreen extends StatelessWidget {
  const TablonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //Barra de título
          const BarraTitulo(titulo: tituloScreen),

          //Tablón
          const Tablon(),

          //Botón para publicar
          Container(
              alignment: Alignment.bottomRight,
              margin: const EdgeInsets.only(right: 20, top: 10),
              child: const BotonCircular(
                iconoBoton: Icon(Icons.add),
                click: clickar,
              ))
        ],
      ),
      bottomNavigationBar: const BarraNavegacion(),
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

//Se ha de cambiar por un stack para la foto de fondo
class Tablon extends StatelessWidget {
  const Tablon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      height: 500,
      width: 700,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10.0),
                image: const DecorationImage(
                    image: AssetImage('assets/images/fondoTablon.jpg'),
                    fit: BoxFit.fill)),
          ),
          ListView(
            children: const [
              Nota(
                tituloNota: 'SALUDO',
              )
            ],
          )
        ],
      ),
    );
  }
}
