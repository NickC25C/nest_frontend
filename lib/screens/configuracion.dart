import 'package:flutter/material.dart';
import 'package:nest_fronted/main.dart';
import 'package:nest_fronted/themes/temasClaros.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../models/user.dart';

const tituloScreen = 'CONFIGURACIÓN';
int selectedIndex = 0;

class ConfiguracionScreen extends StatelessWidget {
  const ConfiguracionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: const Column(
          children: [CambiarUser()],
        ),
      ),
    );
  }
}

class CambiarUser extends StatelessWidget {
  const CambiarUser({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        api.loggedUser = usuarios[1];
      },
      child: Text('Cambiar Usuario'),
    );
  }
}
