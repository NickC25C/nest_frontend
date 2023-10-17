import 'package:flutter/material.dart';
import 'package:nest_fronted/widgets/barra_titulo.dart';
import 'package:slide_to_act/slide_to_act.dart';

const tituloScreen = 'CONFIGURACIÓN';
int selectedIndex = 0;

class ConfiguracionScreen extends StatelessWidget {
  const ConfiguracionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BarraTitulo(titulo: tituloScreen,),
          BotonNotif()
        ],
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
      child: Padding(
        padding: const EdgeInsets.only(top: 230.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Activar/Desactivar Notificaciones',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 25),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SlideAction(
                borderRadius: 12,
                elevation: 0,
                text: activado ? 'Desactivadas' : 'Activadas',
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
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
            SizedBox(height: 25),
            Text(
              'Recomendamos no activar las notificaciones por si te da amsiedad',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
