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
          children: [BotonNotif(), CambiarUser()],
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

class BotonNotif extends StatefulWidget {
  const BotonNotif({Key? key}) : super(key: key);

  @override
  _BotonNotifState createState() => _BotonNotifState();
}

class _BotonNotifState extends State<BotonNotif> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: Text(
              'Activar/Desactivar Notificaciones',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Container(
              child: SlideAction(
                borderRadius: 12,
                elevation: 0,
                text: api.loggedUser.enableNotifications
                    ? 'Activadas'
                    : 'Desactivadas',
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                outerColor: api.loggedUser.enableNotifications
                    ? Colors.green
                    : Colors.red,
                onSubmit: () {
                  setState(() {
                    api.loggedUser.enableNotifications =
                        !api.loggedUser.enableNotifications;
                    api
                        .updateUser(api.loggedUser.id, api.loggedUser)
                        .whenComplete(() => print('Usuario updated'));
                  });
                  // Cositas que hará al deslizar (activar las notificaciones)
                },
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
            child: Text(
              'Recomendamos no activar las notificaciones por si te da amsiedad',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
