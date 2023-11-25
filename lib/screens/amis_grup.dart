import 'package:flutter/material.dart';
import 'package:nest_fronted/main.dart';
import 'package:nest_fronted/screens/crear_grupos.dart';
import 'package:nest_fronted/widgets/barra_publi.dart';
import 'package:page_transition/page_transition.dart';
import 'package:nest_fronted/models/user.dart';

import '../models/diffusionList.dart';

const tituloScreen = 'GRUPOS Y AMISTADES';
int selectedIndex = 0;

class AmisGrupScreen extends StatelessWidget {
  const AmisGrupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            BarraPublicar(titulo: tituloScreen),
            TusAmigos(),
            Grupos(),
            BotonCrear(),
          ],
        ),
      ),
    );
  }
}

class TusAmigos extends StatefulWidget {
  @override
  _TusAmigos createState() => _TusAmigos();
}

//Aceptar o denegar solicitudes
class _TusAmigos extends State<TusAmigos> {
  late List<User> listaAmigos = List.empty(growable: true);
  late List<String> listaAuxiliar = List.empty(growable: true);

  Future<void> extractUsers() async {
    try {
      List<User> users = await api.getUserFriends(api.loggedUser.id);
      setState(() {
        listaAmigos = users;
        listaAuxiliar = users.map((user) => user.username).toList();
      });
    } catch (e) {
      // Manejar el error de la solicitud
      print('Error en la solicitud: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    extractUsers();
  }

  void _removeItem(int index) {
    setState(() {
      listaAuxiliar.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Text(
            'Tus Amigos:',
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
              border: Border.all(color: actual.colorScheme.secondary),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Scrollbar(
              child: CustomListView(
                items: listaAuxiliar,
                onItemRemoved: _removeItem,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomListView extends StatelessWidget {
  final List<String> items;
  final Function(int) onItemRemoved;

  CustomListView({required this.items, required this.onItemRemoved});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 0.0),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(items[index]),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: () async {
                  User aux = await api.getUserByUsername(items[index]);
                  api.deleteFriend(api.loggedUser.id, aux.id);
                  onItemRemoved(index);
                },
                child: Icon(
                  Icons.delete_forever,
                  color: actual.colorScheme.secondary,
                ),
                style: ElevatedButton.styleFrom(
                    side: BorderSide(
                      color: actual.colorScheme.secondary,
                    ),
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

//visualizar los grupos y la contidad de gente de estos
class Grupos extends StatefulWidget {
  @override
  _Grupos createState() => _Grupos();
}

class _Grupos extends State<Grupos> {
  late List<DiffusionList> listaDifusion = List.empty(growable: true);

  Future<void> extractDiffusionLists() async {
    try {
      List<DiffusionList> diffusionLists =
          await api.getDiffusionLists(api.loggedUser.id);
      setState(() {
        listaDifusion = diffusionLists;
      });
    } catch (e) {
      // Manejar el error de la solicitud
      print('Error en la solicitud: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    extractDiffusionLists();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Text(
            'Tus Grupos:',
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
              border: Border.all(
                color: actual.colorScheme.secondary,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Scrollbar(
              child: CustomListViewGrupos(items: listaDifusion),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomListViewGrupos extends StatelessWidget {
  final List<DiffusionList> items;

  CustomListViewGrupos({required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 0.0),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(
            items[index].name,
            style: TextStyle(fontSize: 20.0),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                items[index].friendsIds.length.toString(),
                style: TextStyle(
                    fontSize: 20.0, color: actual.colorScheme.secondary),
              ),
              SizedBox(
                width: 10.0,
              ),
              Icon(
                Icons.group,
                color: actual.colorScheme.secondary,
                size: 30.0,
              ),
            ],
          ),
        );
      },
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
            ),
            label: Text(
              'Crear grupo',
            ),
            style: TextButton.styleFrom(
                backgroundColor: actual.colorScheme.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                )),
          ),
        ),
      ),
    );
  }
}
