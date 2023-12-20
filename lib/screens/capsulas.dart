import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../main.dart';
import '../models/capsule.dart';
import '../widgets/MostrarCapsulaAbierta.dart';
import '../widgets/MostrarCapsulaCerrada.dart';
import 'capsulaAbierta.dart';
import 'capsulaCerrada.dart';
import 'crear_capsula.dart';

class CapsulaScreen extends StatefulWidget {
  CapsulaScreen({super.key});

  @override
  _CapsulaScreenState createState() => _CapsulaScreenState();
}

class _CapsulaScreenState extends State<CapsulaScreen> {
  late List<Capsule> _capsulasRecibidas;
  late StreamController<List<Capsule>> _capsulasRecibidasController;

  @override
  void initState() {
    super.initState();
    _capsulasRecibidas = [];
    _capsulasRecibidasController = StreamController<List<Capsule>>.broadcast();
    _initializeCapsules();

    // Iniciar un temporizador para actualizar la lista cada 5 segundos
    Timer.periodic(Duration(seconds: 5), (timer) {
      _updateCapsules();
    });
  }

  Future<void> _initializeCapsules() async {
    try {
      _capsulasRecibidas = await api.getCapsulesByUserId(api.loggedUser.id);
      _capsulasRecibidasController.add(_capsulasRecibidas);
    } catch (error) {
      print('Error al cargar las cápsulas: $error');
    }
  }

  Future<void> _updateCapsules() async {
    try {
      List<Capsule> nuevasCapsulas =
          await api.getCapsulesByUserId(api.loggedUser.id);

      if (_capsulasRecibidas != nuevasCapsulas) {
        setState(() {
          _capsulasRecibidas = nuevasCapsulas;
        });

        // Agregar las nuevas cápsulas al stream
        _capsulasRecibidasController.add(_capsulasRecibidas);
      }
    } catch (error) {
      print('Error al cargar las cápsulas: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 50.0, 15.0, 20.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Tus Cápsulas',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 32.0,
                  ),
                )),
          ),
          TextDivider(text: 'Cerradas'),
          StreamBuilder<List<Capsule>>(
            stream: _capsulasRecibidasController.stream,
            initialData: _capsulasRecibidas,
            builder: (context, snapshot) {
              return Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 200,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              if (snapshot.data![index].openDate
                                  .isAfter(DateTime.now())) {
                                return CapsulaCerrada(
                                  capsula: snapshot.data![index],
                                );
                              } else {
                                return Stack();
                              }
                            }),
                      ),
                      TextDivider(text: 'Abiertas'),
                      Container(
                        height: 200,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              if (snapshot.data![index].openDate
                                  .isBefore(DateTime.now())) {
                                return CapsulaAbierta(
                                    capsula: snapshot.data![index]);
                              } else {
                                return Stack();
                              }
                            }),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
          Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20, bottom: 10),
              child: BotonCrearCapsula()),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _capsulasRecibidasController.close();
    super.dispose();
  }
}

class TextDivider extends StatelessWidget {
  final String text;

  const TextDivider({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 40.0, 15.0, 20.0),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 23.0,
              ),
            )),
      ),
      SizedBox(height: 5.0),
      Container(
        width: double.infinity,
        height: 1.5,
        color: actual.colorScheme.secondary,
      ),
    ]);
  }
}

class BotonCrearCapsula extends StatelessWidget {
  const BotonCrearCapsula({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 150,
      child: ElevatedButton(
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
              color: actual.colorScheme.onPrimary,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
