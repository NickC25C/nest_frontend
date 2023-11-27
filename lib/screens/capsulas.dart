import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../main.dart';
import '../models/capsule.dart';
import 'capsulaAbierta.dart';
import 'capsulaCerrada.dart';
import 'crear_capsula.dart';

class CapsulaScreen extends StatefulWidget {
  CapsulaScreen({super.key});

  @override
  _CapsulaScreenState createState() => _CapsulaScreenState();
}

class _CapsulaScreenState extends State<CapsulaScreen> {
  late List<Capsule> _cartasRecibidas;
  late StreamController<List<Capsule>> _cartasRecibidasController;

  @override
  void initState() {
    super.initState();
    _cartasRecibidas = [];
    _cartasRecibidasController = StreamController<List<Capsule>>.broadcast();
    _initializeCapsules();

    // Iniciar un temporizador para actualizar la lista cada 30 segundos
    Timer.periodic(Duration(seconds: 1), (timer) {
      _updateCapsules();
    });
  }

  Future<void> _initializeCapsules() async {
    try {
      _cartasRecibidas = await api.getCapsulesByUserId(api.loggedUser.id);
      _cartasRecibidasController.add(_cartasRecibidas);
    } catch (error) {
      print('Error al cargar las cápsulas: $error');
    }
  }

  Future<void> _updateCapsules() async {
    try {
      List<Capsule> nuevasCapsulas =
          await api.getCapsulesByUserId(api.loggedUser.id);

      if (_cartasRecibidas != nuevasCapsulas) {
        setState(() {
          _cartasRecibidas = nuevasCapsulas;
        });

        // Agregar las nuevas cápsulas al stream
        _cartasRecibidasController.add(_cartasRecibidas);
      }
    } catch (error) {
      print('Error al cargar las cápsulas: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return StreamBuilder<List<Capsule>>(
      stream: _cartasRecibidasController.stream,
      initialData: _cartasRecibidas,
      builder: (context, snapshot) {
        return SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: screenSize.height,
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    if (snapshot.data![index].openDate
                        .isAfter(DateTime.now())) {
                      return CapsulaCerrada(
                        capsula: snapshot.data![index],
                      );
                    } else {
                      return CapsulaAbierta(capsula: snapshot.data![index]);
                    }
                  },
                ),
              ),
              Positioned(
                bottom: 170,
                right: 8.0,
                child: BotonCrearCapsula(),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _cartasRecibidasController.close();
    super.dispose();
  }
}

class CapsulaCerrada extends StatefulWidget {
  final Capsule capsula;

  const CapsulaCerrada({Key? key, required this.capsula}) : super(key: key);

  @override
  _CapsulaCerradaState createState() => _CapsulaCerradaState();
}

class _CapsulaCerradaState extends State<CapsulaCerrada> {
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

  String _formatDuration(Duration duration) {
    // Obtener las horas, minutos y segundos de la duración
    int hours = duration.inHours;
    int minutes = (duration.inMinutes % 60);
    int seconds = (duration.inSeconds % 60);
    String formattedDuration =
        '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    return formattedDuration;
  }

  @override
  void dispose() {
    _durationController.close();
    _timer.cancel();
    super.dispose();
  }

  void _updateDuration() {
    Duration difference = widget.capsula.openDate.difference(DateTime.now());
    _durationController.add(difference);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Opacity(
        opacity: 0.6,
        child: Container(
          color: Colors.black,
          child: RawMaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  child: CapsulaCerradaScreen(
                    capsula: widget.capsula,
                  ),
                  type: PageTransitionType.fade,
                ),
              );
            },
            elevation: 2.0,
            fillColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(color: Colors.white),
            ),
            constraints: BoxConstraints(
              minWidth: double.infinity,
              minHeight: 150.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.capsula.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                StreamBuilder<Duration>(
                  stream: _durationController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        _formatDuration(snapshot.data!),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      );
                    } else {
                      return Container(); // Puedes mostrar un indicador de carga aquí si lo deseas
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CapsulaAbierta extends StatelessWidget {
  final Capsule capsula;
  const CapsulaAbierta({Key? key, required this.capsula}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String txt;
    if (capsula.description.length <= 40) {
      txt = capsula.description;
    } else {
      txt = '${capsula.description.substring(0, 39)}...';
    }
    return Container(
      height: 150.0,
      width: double.infinity,
      child: RawMaterialButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              child: CapsulaAbiertaScreen(
                capsula: capsula,
              ),
              type: PageTransitionType.fade,
            ),
          );
        },
        elevation: 2.0,
        fillColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0), // Bordes más gruesos
          side: BorderSide(color: Colors.black, width: 2.0), // Borde más grueso
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 8.0),
                  Text(
                    capsula.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    txt,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BotonCrearCapsula extends StatelessWidget {
  const BotonCrearCapsula({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          PageTransition(
            child: CrearCapsula(),
            type: PageTransitionType.fade,
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0), // Bordes redondeados
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          'Crear Cápsula',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
