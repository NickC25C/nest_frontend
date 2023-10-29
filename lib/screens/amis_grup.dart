import 'package:flutter/material.dart';
import 'package:nest_fronted/models/user.dart';
import 'package:nest_fronted/widgets/barra_titulo.dart';
import 'package:nest_fronted/screens/crear_grupos.dart';
import 'package:page_transition/page_transition.dart';
import 'package:nest_fronted/main.dart';

const tituloScreen = 'GRUPOS Y AMISTADES';

class AmisGrupScreen extends StatelessWidget {
  const AmisGrupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BarraTitulo(titulo: tituloScreen),
        Solicitudes(),
        Grupos(),
        BotonCrear(),
      ],
    );
  }
}

class Solicitudes extends StatefulWidget {
  @override
  _Solicitudes createState() => _Solicitudes();
}

//Aceptar o denegar solicitudes
class _Solicitudes extends State<Solicitudes> {
  final List<User> listaAuxiliar = bd.loggedUser.solicitudesPend!;

  void _check(int index) {
    User u = listaAuxiliar[index];
    setState(() {
      listaAuxiliar.removeAt(index);
    });
    bd.addFriend(bd.loggedUser, u);
  }

  void _cross(int index) {
    User u = listaAuxiliar[index];
    setState(() {
      listaAuxiliar.removeAt(index);
    });
    bd.rejectFriend(bd.loggedUser, u);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Text(
            'Solicitudes:',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            height: 250.0,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Scrollbar(
              child: CustomListView(
                items: listaAuxiliar,
                onCheck: _check,
                onCross: _cross,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomListView extends StatelessWidget {
  final List<User> items;
  final Function(int) onCheck;
  final Function(int) onCross;

  CustomListView(
      {required this.items, required this.onCheck, required this.onCross});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 0.0),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(items[index].username),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  onCheck(index);
                },
                child: Icon(
                  Icons.check,
                  color: Colors.deepPurpleAccent,
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.deepPurpleAccent, width: 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0))),
              ),
              SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: () {
                  onCross(index);
                },
                child: Icon(
                  Icons.close,
                  color: Colors.deepPurpleAccent,
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.deepPurpleAccent, width: 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0))),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Grupos extends StatefulWidget {
  @override
  _Grupos createState() => _Grupos();
}

//visualizar los grupos y la contidad de gente de estos
class _Grupos extends State<Grupos> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Text(
            'Grupos:',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            height: 190.0,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Scrollbar(
              child: ListView.builder(
                padding: EdgeInsets.only(left: 10.0),
                itemCount: bd.loggedUser.diffusionGroups!.length,
                itemBuilder: (BuildContext context, int index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            bd.loggedUser.diffusionGroups![index].name,
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                            ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              bd.loggedUser.diffusionGroups![index].friends!.length.toString(),
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                              ),
                            ),
                            Icon(
                              Icons.group,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//boton de redireccion a crear grupos
class BotonCrear extends StatelessWidget {
  const BotonCrear({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          height: 50,
          width: 150,
          child: TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  child: CrearGrupos(),
                  type: PageTransitionType.fade,
                ),
              );
            },
            icon: Icon(
              Icons.groups,
              color: Colors.white,
            ),
            label: Text(
              'Crear grupo',
              style: TextStyle(color: Colors.white),
            ),
            style: TextButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                )),
          ),
        ),
      ),
    );
  }
}
