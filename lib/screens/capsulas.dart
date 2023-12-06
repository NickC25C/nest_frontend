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

    // Iniciar un temporizador para actualizar la lista cada 30 segundos
    Timer.periodic(Duration(seconds: 1), (timer) {
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

    return StreamBuilder<List<Capsule>>(
      stream: _capsulasRecibidasController.stream,
      initialData: _capsulasRecibidas,
      builder: (context, snapshot) {
        return SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: screenSize.height - 160,
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
                bottom: 0,
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
    _capsulasRecibidasController.close();
    super.dispose();
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
