import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nest_fronted/models/capsule.dart';
import 'package:nest_fronted/screens/pub_imagen_cap.dart';
import 'package:nest_fronted/screens/pub_nota_capsula.dart';
import 'package:page_transition/page_transition.dart';

class CapsulaCerradaScreen extends StatelessWidget {
  final Capsule capsula;
  const CapsulaCerradaScreen({Key? key, required this.capsula});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              BotonAtras(),
            ],
          ),
          Titulo(
            titulo: capsula.title,
          ),
          BarraDivisoria(),
          Descripcion(
            descripcion: capsula.description,
          ),
          Spacer(), // ocupa t0do el espacio q puede
          BarraDivisoria(),
          CuentaAtras(
            fechaApertura: capsula.openDate,
          ),
          SizedBox(height: 16),
          BarraDivisoria(),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BotonAnyadirFoto(
                  capsula: capsula
              ),
              BotonAnyadirNota(
                capsula: capsula,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Foteque extends StatelessWidget {
  const Foteque({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          MediaQuery.of(context).size.height / 4, // ocupa 1/4 de la pantalla
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/rata.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class BotonAtras extends StatelessWidget {
  const BotonAtras({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_circle_left, size: 30),
      onPressed: () {},
    );
  }
}

class Titulo extends StatelessWidget {
  final String titulo;
  const Titulo({Key? key, required this.titulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 16),
        Text(
          titulo,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

class Descripcion extends StatelessWidget {
  final String descripcion;
  const Descripcion({Key? key, required this.descripcion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Text(
        descripcion,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}

class BarraDivisoria extends StatelessWidget {
  const BarraDivisoria({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.black,
      thickness: 2,
      indent: 16,
      endIndent: 16,
    );
  }
}

class BotonAnyadirNota extends StatelessWidget {
  final Capsule capsula;
  const BotonAnyadirNota({Key? key, required this.capsula}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          PageTransition(
            child: PubNotaCapsula(
              capsula: capsula,
            ),
            type: PageTransitionType.fade,
          ),
        );
      },
      child: Icon(Icons.text_snippet),
    );
  }
}

class BotonAnyadirFoto extends StatelessWidget {
  final Capsule capsula;
  const BotonAnyadirFoto({Key? key, required this.capsula}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PubImagenCapScreen(),
          ),
        );
      },
      child: Icon(Icons.image_outlined),
    );
  }
}

class CuentaAtras extends StatefulWidget {
  final DateTime fechaApertura;

  const CuentaAtras({Key? key, required this.fechaApertura}) : super(key: key);

  @override
  _CuentaAtrasState createState() => _CuentaAtrasState();
}

class _CuentaAtrasState extends State<CuentaAtras> {
  late StreamController<Duration> _durationController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _durationController = StreamController<Duration>();
    _updateDuration();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      _updateDuration();
    });
  }

  @override
  void dispose() {
    _durationController.close();
    _timer.cancel();
    super.dispose();
  }

  void _updateDuration() {
    Duration difference = widget.fechaApertura.difference(DateTime.now());
    _durationController.add(difference);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Tiempo hasta desbloqueo:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        SizedBox(height: 8),
        StreamBuilder<Duration>(
          stream: _durationController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                _formatDuration(snapshot.data!),
                style: TextStyle(
                  fontSize: 20,
                ),
              );
            } else {
              return Text(
                'Calculando...',
                style: TextStyle(
                  fontSize: 20,
                ),
              );
            }
          },
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = (duration.inMinutes % 60);
    int seconds = (duration.inSeconds % 60);
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
