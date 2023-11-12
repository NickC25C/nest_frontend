import 'package:flutter/material.dart';
import 'package:nest_fronted/widgets/barra_publi.dart';
import 'package:nest_fronted/widgets/listado.dart';
import 'package:nest_fronted/widgets/selector_fecha.dart';
import 'package:nest_fronted/widgets/titulo_pub.dart';
import 'package:nest_fronted/main.dart';

const tituloScreen = 'ENVIAR CARTA';
Titulo titulin = Titulo();

class EnviarCartaScreen extends StatelessWidget {
  const EnviarCartaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Barra de título
          BarraPublicar(titulo: tituloScreen),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Listado(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Titulo(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0),
            child: FechaApertura(texto: 'Fecha de envío'),
          ),
          EscribirNota(),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),
            child: BotonCrear(),
          ),
        ],
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
            onPressed: () {},
            icon: Icon(
              Icons.send,
            ),
            label: Text(
              'Enviar',
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
