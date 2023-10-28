import 'package:flutter/material.dart';
import 'package:nest_fronted/widgets/barra_titulo.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:nest_fronted/services/api_service.dart';

import '../models/user.dart';


const tituloScreen = 'CONFIGURACIÓN';
int selectedIndex = 0;
ApiService api = ApiService();

class ConfiguracionScreen extends StatelessWidget {
  const ConfiguracionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: const Column(
          children: [
            BarraTitulo(titulo: tituloScreen,),
            BotonNotif(),
            CambiarUser(),
          ],
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
        int userId = int.parse("bf776f0a-3591-4652-916b-f6ba5ebd16a3");

        User newUser = await api.getUser(userId);
        api.loggedUser = newUser;
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
  bool activado = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Text(
                'Activar/Desactivar Notificaciones',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Container(
                child: SlideAction(
                  borderRadius: 12,
                  elevation: 0,
                  text: activado ? 'Desactivadas' : 'Activadas',
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  outerColor: activado ? Colors.red : Colors.green,
                  onSubmit: () {
                    setState(() {
                      activado = !activado;
                    });
                    // Cositas que hará al deslizar (activar las notificaciones)
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
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
