import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../models/capsule.dart';
import '../screens/capsulaCerrada.dart';

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