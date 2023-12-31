import 'package:flutter/material.dart';
import 'package:nest_fronted/widgets/barra_publi.dart';
import 'package:nest_fronted/widgets/titulo_pub.dart';
import 'package:nest_fronted/widgets/contenido_pub.dart';
import 'package:nest_fronted/main.dart';
import 'package:nest_fronted/widgets/listado.dart';

const tituloScreen = 'PUBLICAR NOTA';
int selectedIndex = 0;
Titulo titulin = Titulo();
Content mensajin = Content();

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
              child: titulin,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: mensajin,
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
      ),
    );
  }
}

//contenido de la nota
/*class EscribirNota extends StatelessWidget {
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
              maxLines: 5,
              decoration: InputDecoration(
                labelText : 'Mensaje',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}*/
//Seleccionar a los usuarios/grupos a los q enviar

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
              String titulo = titulin.darValor();
              String mensaje = mensajin.darValor();

              if (titulo.isNotEmpty && mensaje.isNotEmpty) {
                bd.addNota(bd.loggedUser, titulo, bd.usuarios, mensaje);
              }

              Navigator.pop(context);
            },
            icon: Icon(
              Icons.sticky_note_2_outlined,
              color: Colors.white,
            ),
            label: Text(
              'Publicar nota',
              style: TextStyle(color: Colors.white),
            ),
            style: TextButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                )),
          ),
        ),
      ),
    );
  }
}
