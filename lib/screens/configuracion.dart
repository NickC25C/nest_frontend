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
          CambiarUser(),
        ]),
      ),
    );
  }
}

class CambiarUser extends StatelessWidget {
  const CambiarUser({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        api.loggedUser = await api.getUserByUsername('El_nicoloau');
      },
      child: Text('Cambiar Usuario'),
    );
  }
}
