import 'package:flutter/material.dart';
import 'package:nest_fronted/main.dart';
import 'package:nest_fronted/screens/crear_grupos.dart';
import 'package:nest_fronted/widgets/barra_publi.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fluttertoast/fluttertoast.dart';

const tituloScreen = 'GRUPOS Y AMISTADES';
int selectedIndex = 0;

class AmisGrupScreen extends StatelessWidget {
  const AmisGrupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BarraPublicar(titulo: tituloScreen),
          TusAmigos(),
          Grupos(),
          BotonCrear(),
        ],
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
  final List<String> listaAuxiliar = [
    'Guillem_proxeneta69',
    'Ivan_politoxicomano33',
    'Magic_Patrisio777',
    'Pepe_Viyuela'
  ];

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
                onPressed: () {
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
class Grupos extends StatelessWidget {
  const Grupos({
    Key? key,
  }) : super(key: key);

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
              border: Border.all(
                color: actual.colorScheme.secondary,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Scrollbar(
              child: ListView(
                padding: EdgeInsets.only(left: 10.0),
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.only(right: 60.0),
                    title: Text('Familia'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '1',
                          style: TextStyle(color: actual.colorScheme.secondary),
                        ),
                        Icon(
                          Icons.group,
                          color: actual.colorScheme.secondary,
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(right: 60.0),
                    title: Text('Colegio'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '18',
                          style: TextStyle(color: actual.colorScheme.secondary),
                        ),
                        Icon(
                          Icons.group,
                          color: actual.colorScheme.secondary,
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(right: 60.0),
                    title: Text('mckdhvudif'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '18334',
                          style: TextStyle(color: actual.colorScheme.secondary),
                        ),
                        Icon(
                          Icons.group,
                          color: actual.colorScheme.secondary,
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(right: 60.0),
                    title: Text('Nest'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '12',
                        ),
                        Icon(
                          Icons.group,
                        ),
                      ],
                    ),
                  ),
                ],
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
