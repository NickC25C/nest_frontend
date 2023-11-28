import 'package:flutter/material.dart';
import 'package:nest_fronted/main.dart';

const tituloScreen = 'CONFIGURACIÓN';
int selectedIndex = 0;

class ConfiguracionScreen extends StatelessWidget {
  const ConfiguracionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: 250.0,
          ),
          CambiarUser1(),
          CambiarUser2(),
          CambiarUser3(),
          CambiarUser4(),
        ]),
      ),
    );
  }
}

class CambiarUser1 extends StatelessWidget {
  const CambiarUser1({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        api.loggedUser = await api.getUserByUsername('g4net');
      },
      child: Text('Cambiar Guillem'),
    );
  }
}

class CambiarUser2 extends StatelessWidget {
  const CambiarUser2({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        api.loggedUser = await api.getUserByUsername('El_nicoloau');
      },
      child: Text('Cambiar Nick'),
    );
  }
}

class CambiarUser3 extends StatelessWidget {
  const CambiarUser3({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        api.loggedUser = await api.getUserByUsername('LaBeas');
      },
      child: Text('Cambiar Bea'),
    );
  }
}

class CambiarUser4 extends StatelessWidget {
  const CambiarUser4({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        api.loggedUser = await api.getUserByUsername('Reshulon21');
      },
      child: Text('Cambiar Lanza'),
    );
  }
}
