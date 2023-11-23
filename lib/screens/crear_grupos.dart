import 'package:flutter/material.dart';
import 'package:nest_fronted/main.dart';
import 'package:nest_fronted/models/diffusionList.dart';
import 'package:nest_fronted/models/user.dart';
import 'package:nest_fronted/widgets/listado.dart';
import 'package:nest_fronted/widgets/titulo_pub.dart';
import 'package:nest_fronted/widgets/barra_publi.dart';

const tituloScreen = 'NUEVO GRUPO';
Listado listaditoMarianoRajoy = Listado();
Titulo titulitoPerroShanche = Titulo();

class CrearGrupos extends StatelessWidget {
  const CrearGrupos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BarraPublicar(titulo: tituloScreen),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: titulitoPerroShanche,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: listaditoMarianoRajoy,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
            child: BotonCrear(),
          ),
        ],
      ),
    ));
  }
}

class BotonCrear extends StatelessWidget {
  const BotonCrear({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          height: 50,
          width: 150,
          child: TextButton.icon(
            onPressed: () async {
              List<User> usuarios = await api.getUserFriends(api.loggedUser.id);
              List<String> idUsuarios = List.empty(growable: true);
              for (var element in usuarios) {
                idUsuarios.add(element.id);
              }
              await api.createDiffusionList(DiffusionList(
                  id: '',
                  name: titulitoPerroShanche.darValor(),
                  ownerId: api.loggedUser.id,
                  friendsIds: idUsuarios));
            },
            icon: Icon(
              Icons.groups,
            ),
            label: Text(
              'Crear grupo',
              style: TextStyle(),
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
