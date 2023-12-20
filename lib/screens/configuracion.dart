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
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200.0,
                ),
                Text(
                  '¡Bienvenido a Nest!',
                  style: TextStyle(color: actual.colorScheme.secondary ,fontSize: 30, fontWeight: FontWeight.w500),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    'Tu app favorita para hablar con tus seres queridos stress-free.',
                    style: TextStyle(color: Colors.grey ,fontSize: 20, fontWeight: FontWeight.w300),),
                ),
                Container(
                  width: 200,
                  height: 200,
                  child: Image.asset('assets/images/Huevo2.png')),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CambiarUser1(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CambiarUser2(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CambiarUser3(),
                ),
              ]),
        ),
      ),
    );
  }
}

class CambiarUser1 extends StatelessWidget {
  const CambiarUser1({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 150,
      child: ElevatedButton(
        onPressed: () async {
          api.loggedUser = await api.getUserByUsername('g4net');
          Navigator.pop(context);
        },
        child: Text('Cambiar Guillem'),
      ),
    );
  }
}

class CambiarUser2 extends StatelessWidget {
  const CambiarUser2({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 150,
      child: ElevatedButton(
        onPressed: () async {
          api.loggedUser = await api.getUserByUsername('El_nicoloau');
          Navigator.pop(context);
        },
        child: Text('Cambiar Nick'),
      ),
    );
  }
}

class CambiarUser3 extends StatelessWidget {
  const CambiarUser3({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 150,
      child: ElevatedButton(
        onPressed: () async {
          api.loggedUser = await api.getUserByUsername('Javila21');
          Navigator.pop(context);
        },
        child: Text('Cambiar Lanza'),
      ),
    );
  }
}
