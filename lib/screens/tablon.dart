import 'package:flutter/material.dart';
import 'package:nest_fronted/screens/amis_grup.dart';
import 'package:nest_fronted/screens/configuracion.dart';
import 'package:nest_fronted/widgets/barra_titulo.dart';
import 'package:nest_fronted/widgets/boton_circular.dart';
import 'package:nest_fronted/widgets/nota.dart';
import 'package:nest_fronted/widgets/foto.dart';

const tituloScreen = 'MI TABLÓN PERSONAL';
int selectedIndex = 0;
clickar() {}

class TablonScreen extends StatefulWidget {
  @override
  _TablonScreenState createState() => _TablonScreenState();
}

class _TablonScreenState extends State<TablonScreen> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const Tablon(), // Esta sería tu "página" de inicio
      Text('Página de búsqueda'),
      const AmisGrupScreen(),
      const ConfiguracionScreen(),
      // Agrega aquí tus otras pantallas
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Tablón o contenido principal
            screens[selectedIndex],
          ],
        ),
      ),
      bottomNavigationBar: BarraNavegacion(
        selectedIndex: selectedIndex,
        onItemSelected: onItemTapped,
      ),
    );
  }
}

class BarraNavegacion extends StatelessWidget  {
  final int selectedIndex;
  final Function(int) onItemSelected;
  const BarraNavegacion({
    super.key,
    required  this.selectedIndex,
    required  this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: selectedIndex,
        onTap: onItemSelected,
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
    return Column(
      children: [
        const BarraTitulo(titulo: tituloScreen),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          height: 600,
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
                  ),
                  Foto(url: ('assets/images/rata.png'))
                ],
              ),
              Container(
                  alignment: Alignment.bottomRight,
                  margin: const EdgeInsets.all(10),
                  child: const BotonCircular(
                    iconoBoton: Icon(Icons.add),
                    click: clickar,
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
