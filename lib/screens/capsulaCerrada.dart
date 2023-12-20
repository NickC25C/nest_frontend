import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nest_fronted/main.dart';
import 'package:nest_fronted/models/capsule.dart';
import 'package:nest_fronted/screens/pub_imagen_cap.dart';
import 'package:nest_fronted/screens/pub_nota_capsula.dart';
import 'package:page_transition/page_transition.dart';

class CapsulaCerradaScreen extends StatelessWidget {
  final Capsule capsula;
  const CapsulaCerradaScreen({Key? key, required this.capsula});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300.0,
        height: 600.0,
        child: Card(

          child: Column(
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
              Descripcion(
                descripcion: capsula.description,
              ),
              Container(
                height: 200,
                width: 50,
                child: Image.asset('assets/images/Huevo2.png'),
              ),
              Spacer(), // ocupa t0do el espacio q puede
              CuentaAtras(
                fechaApertura: capsula.openDate,
              ),
              SizedBox(height: 16),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BotonAnyadir(
                      capsula: capsula,
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
                      icon: Icon(Icons.text_snippet),
                    ),
                    BotonAnyadir(
                      capsula: capsula,
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: PubImagenCapScreen(
                              capsula: capsula,
                            ),
                            type: PageTransitionType.fade,
                          ),
                        );
                      },
                      icon: Icon(Icons.photo),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
      onPressed: () {
        Navigator.pop(context);
      },
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
        textAlign: TextAlign.center,
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

class BotonAnyadir extends StatelessWidget {
  final Capsule capsula;
  final Function() onPressed;
  final Icon icon;
  const BotonAnyadir(
      {Key? key,
      required this.capsula,
      required this.onPressed,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: actual.colorScheme.secondary, // Color del círculo de fondo
      ),
      child: IconButton(
        icon: icon,
        color: actual.colorScheme.onSecondary,
        onPressed: onPressed,
      ),
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
          'Cuenta atrás:',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
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
