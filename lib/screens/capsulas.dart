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
  late List<Capsule> _cartasRecibidasFuture;

  Future<List<Capsule>> initializeCapsules() async {
    Completer<List<Capsule>> completer = Completer();

    try {
      _cartasRecibidasFuture = await api.getCapsulesByUserId(api.loggedUser.id);

      completer.complete(_cartasRecibidasFuture);
    } catch (error) {
      completer.completeError(error);
    }
    return completer.future;
  }

  @override
  void initState() {
    super.initState();
    initializeCapsules();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Stack(
        children: [
          FutureBuilder<List<Capsule>>(
            future: initializeCapsules(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Mientras se carga, puedes mostrar un indicador de carga.
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // En caso de error, muestra un mensaje de error.
                return Text('Error: ${snapshot.error}');
              } else {
                // Si la operación es exitosa, construye el ListView.
                List<Capsule> cartasRecibidas = snapshot.data ?? [];
                return Container(
                  height: screenSize.height,
                  child: ListView.builder(
                    itemCount: cartasRecibidas.length,
                    itemBuilder: (context, index) {
                      if (cartasRecibidas[index]
                          .openDate
                          .isAfter(DateTime.now())) {
                        return CapsulaCerrada(
                          capsula: cartasRecibidas[index],
                        );
                      } else {
                        return CapsulaAbierta();
                      }
                    },
                  ),
                );
              }
            },
          ),
          Positioned(
            bottom: 170,
            right: 8.0,
            child: BotonCrearCapsula(),
          ),
        ],
      ),
    );
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
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/rata.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Opacity(
        opacity: 0.6,
        child: Container(
          color: Colors.black,
          child: RawMaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  child: CapsulaCerradaScreen(),
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
  const CapsulaAbierta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double anchoImagen = 150.0;
    return Container(
      height: 150.0,
      width: double.infinity,
      child: RawMaterialButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              child: CapsulaAbiertaScreen(),
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
            Image.asset(
              'assets/images/rata.png',
              fit: BoxFit.cover,
              width: anchoImagen,
              height: double.infinity,
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.0),
                  Text(
                    'Títulin Titulon',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Las pirámides, son grandes y puntiagudas',
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
