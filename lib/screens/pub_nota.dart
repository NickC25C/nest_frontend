import 'package:flutter/material.dart';
import 'package:nest_fronted/models/note.dart';
import 'package:nest_fronted/models/publication.dart';
import 'package:nest_fronted/models/user.dart';
import 'package:nest_fronted/widgets/barra_publi.dart';
import 'package:nest_fronted/widgets/listado.dart';
import 'package:nest_fronted/widgets/listadoMarianoRajoy.dart';
import 'package:nest_fronted/widgets/titulo_pub.dart';
import 'package:nest_fronted/main.dart';

const tituloScreen = 'PUBLICAR NOTA';
int selectedIndex = 0;
Titulo titulin = Titulo();
ListadoCreacion listado = ListadoCreacion();

class PubNotaScreen extends StatelessWidget {
  const PubNotaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Barra de título
            BarraPublicar(titulo: tituloScreen),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Titulo(),
            ),

            EscribirNota(),

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
      ),
    );
  }
}

String msj = '';

//contenido de la nota
class EscribirNota extends StatelessWidget {
  const EscribirNota({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Mensaje:',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            width: double.infinity,
            child: TextField(
              onChanged: (value) => msj = value,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Mensaje',
                border: OutlineInputBorder(),
              ),
            ),
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

  Future<List<String>> getIds(List<String> listita) async {
    List<String> ids = [];
    for (int i = 0; i < listita.length; i++) {
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
          child: ElevatedButton(
            onPressed: () async {
              Note n = Note(
                  id: '',
                  owner: api.loggedUser,
                  date: DateTime.now(),
                  publiType: PublicationType.note,
                  title: titulin.darValor(),
                  watchers: await getIds(listado.getSelectedItems()),
                  message: msj);
              api.createNote(n).whenComplete(() => print('¿Nota subida?'));
              Navigator.pop(context);
            },
            child: Text(
              'Publicar nota',
              style: TextStyle(color: actual.colorScheme.onPrimary, fontSize: 16),
            ),
            style: TextButton.styleFrom(
                backgroundColor: actual.colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                )),
          ),
        ),
      ),
    );
  }
}
