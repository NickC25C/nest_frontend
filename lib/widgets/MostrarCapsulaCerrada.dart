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
    String txt;
    if (widget.capsula.description.length <= 15) {
      txt = widget.capsula.description;
    } else {
      txt = '${widget.capsula.description.substring(0, 15)}...';
    }
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Column(
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: 158,
                  height: 105,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          offset: Offset(0, 1),
                          blurRadius: 13)
                    ],
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 2, 10, 8),
                          child: Text(
                            widget.capsula.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 12),
                          child: Text(
                            txt,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        StreamBuilder<Duration>(
                          stream: _durationController.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                _formatDuration(snapshot.data!),
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              );
                            } else {
                              return Container(); // Puedes mostrar un indicador de carga aquí si lo deseas
                            }
                          },
                        ),
                      ])),
            ],
          ),
        ));
  }
}




/*StreamBuilder<Duration>(
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
                ), */
