import 'package:flutter/material.dart';
import 'package:nest_fronted/models/group.dart';
import 'package:nest_fronted/widgets/titulo_pub.dart';
import 'package:nest_fronted/widgets/barra_publi.dart';
import 'package:nest_fronted/main.dart';

import '../models/user.dart';

const tituloScreen = 'NUEVO GRUPO';
List<String> selectedItems = [];
Titulo titulin = Titulo();

class CrearGrupos extends StatefulWidget {
  @override
  _CrearGrupos createState() => _CrearGrupos();
}

class _CrearGrupos extends State<CrearGrupos> {
  @override
  void initState() {
    super.initState();
    selectedItems = [];
  }

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
            child: titulin,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Listado(),
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

class Listado extends StatefulWidget {
  @override
  _Listado createState() => _Listado();
}

class _Listado extends State<Listado> {
  List<bool> _selectedItems =
      List.generate(bd.loggedUser.friends!.length, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Añadir a:',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: 420,
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListView.builder(
            padding: EdgeInsets.all(0.0),
            itemCount: bd.loggedUser.friends!.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(bd.loggedUser.friends![index].username),
                tileColor:
                    _selectedItems[index] ? Colors.deepPurpleAccent[100] : null,
                onTap: () {
                  if (selectedItems
                      .contains(bd.loggedUser.friends![index].username)) {
                    selectedItems
                        .remove(bd.loggedUser.friends![index].username);
                  } else {
                    selectedItems.add(bd.loggedUser.friends![index].username);
                  }
                  setState(() {
                    _selectedItems[index] = !_selectedItems[index];
                  });
                },
              );
            },
          ),
        ),
      ],
    );
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
            onPressed: () {
              print(selectedItems);
              if (titulin.darValor() != null && selectedItems.length != 0) {
                bd.addGroup(bd.loggedUser, titulin.darValor(), selectedItems);
                Navigator.pop(context);
              } else {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('Error al crear grupo'),
                          content: const Text(
                              'Un grupo debe tener un Nombre y al menos un integrante'),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'))
                          ],
                        ));
              }
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
