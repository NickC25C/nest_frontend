import 'package:flutter/material.dart';
import 'package:nest_fronted/main.dart';
import 'package:nest_fronted/models/diffusionList.dart';
import 'package:nest_fronted/widgets/listado.dart';
import 'package:nest_fronted/widgets/titulo_pub.dart';
import 'package:nest_fronted/widgets/barra_publi.dart';

import '../models/user.dart';

const tituloScreen = 'NUEVO GRUPO';
List<String> coleguillasPalGrupo = List.empty(growable: true);
Titulo titulete = const Titulo();
Listado listado = const Listado();

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
            child: titulete,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: listado,
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

  Future<List<String>> getIds (List<String> listita) async {
    List<String> ids = [];
    for(int i = 0; i < listita.length; i++){
      User usu = await api.getUserByUsername(listita[i]);
      ids.add(usu.id);
    }
    return ids;
  }

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
            onPressed: () async{
              if(titulete.darValor() != null && !listado.getSelectedItems().isEmpty){
                try{
                  print(listado.getSelectedItems());
                  DiffusionList diff = DiffusionList(
                    id: '',
                    name: titulete.darValor(),
                    ownerId: api.loggedUser.id,
                    friendsIds: await getIds(listado.getSelectedItems()),
                  );
                  print(diff.name);
                  api.createDiffusionList(diff);
                }
                catch(e){
                  print('Error del tipo: $e');
                }

              }
              Navigator.pop(context);
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
