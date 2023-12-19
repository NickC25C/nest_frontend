import 'package:flutter/material.dart';
import 'package:nest_fronted/main.dart';
import 'package:nest_fronted/screens/configuracion.dart';
import 'package:nest_fronted/screens/crear_grupos.dart';
import 'package:nest_fronted/widgets/barra_publi.dart';
import 'package:page_transition/page_transition.dart';
import 'package:nest_fronted/models/user.dart';
import 'dart:async';
import '../models/diffusionList.dart';
import 'busqueda.dart';

//const tituloScreen = 'GRUPOS Y AMISTADES';
int selectedIndex = 0;
String texto = '';

class AmisGrupScreen extends StatefulWidget {
  const AmisGrupScreen({super.key});

  @override
  AmisGrupScreenState createState() => AmisGrupScreenState();
}

class AmisGrupScreenState extends State<AmisGrupScreen> {
  late User usuario;

  @override
  void initState() {
    super.initState();
    usuario = api.loggedUser;
    Timer.periodic(Duration(seconds: 1), (timer) {
      _updateUser();
    });
  }

  void _updateUser() {
    if (usuario != api.loggedUser) {
      setState(() {
        usuario = api.loggedUser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80,
                  width: 70,
                ),
                Container(
                  width: 200.0,
                  height: 200.0, // Ajusta la altura según tus necesidades
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/${api.loggedUser.avatar}.png', // Reemplaza con la ruta de tu imagen
                    fit: BoxFit.contain, // Ajusta la imagen al contenedor
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 10),
                  child: SizedBox(
                    child: ElevatedButton(
                      onPressed: () {
                        // Mostrar el menú desplegable desde la parte inferior
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(Icons.settings),
                                    title: Text('Configuración'),
                                    onTap: () {
                                      // Acciones al seleccionar Música
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          child: ConfiguracionScreen(),
                                          type: PageTransitionType.fade,
                                        ),
                                      );
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.group),
                                    title: Text('Búsqueda de amigos'),
                                    onTap: () {
                                      // Acciones al seleccionar Fotos
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          child: BusquedaScreen(),
                                          type: PageTransitionType.fade,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        child: Icon(
                          Icons.menu,
                          size: 36,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: actual.colorScheme.background,
                        elevation: 0.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            UserInfoWidget(),
            EstadoUser(),
            //BarraPublicar(titulo: tituloScreen),
            GruposAmistadesTxt(),
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
        SizedBox(width: 8.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Text(
            'Tus Amigos:',
            style: TextStyle(
              fontSize: 19.0,
              //fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
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
              IconButton(
                onPressed: () async {
                  User aux = await api.getUserByUsername(items[index]);
                  api.deleteFriend(api.loggedUser.id, aux.id);
                  onItemRemoved(index);
                },
                icon: Icon(
                  Icons.delete_outline,
                  color: Colors.black,
                ),
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
        SizedBox(width: 8.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Text(
            'Tus Grupos:',
            style: TextStyle(
              fontSize: 19.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
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
                    fontSize: 20.0, color: actual.colorScheme.onBackground),
              ),
              SizedBox(
                width: 10.0,
              ),
              Icon(
                Icons.group,
                color: actual.colorScheme.onBackground,
                size: 30.0,
              ),
            ],
          ),
        );
      },
    );
  }
}

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5.0),
        Text(
          '@${api.loggedUser.username}',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5.0), // Espacio adicional
        Text(
          api.loggedUser.name +
              ' ' +
              api.loggedUser
                  .lastname, // Reemplaza con la propiedad correcta del usuario
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
      ],
    );
  }
}

class GruposAmistadesTxt extends StatelessWidget {
  const GruposAmistadesTxt({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30.0),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            'Grupos y amistades',
            style: TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 15.0),
        Container(
          width: double.infinity,
          height: 1.5,
          color: actual.colorScheme.secondary,
        ),
      ],
    );
  }
}

class EstadoUser extends StatelessWidget {
  const EstadoUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Text(
            'Tu Estado:',
            style: TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Row(
            children: [
              Container(
                width: 205,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: actual.colorScheme.secondary),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                ),
                child: TextFormField(
                  onChanged: (value) => {texto = value},
                  decoration: InputDecoration(
                    hintText: 'Cómo te encuentras hoy?',
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                width: 66,
                height: 66,
                child: ElevatedButton(
                  onPressed: () {
                    api.loggedUser.state = texto;
                    api.updateUser(api.loggedUser.id, api.loggedUser);

                  },
                  child: Icon(Icons.check, color: actual.colorScheme.onSecondary,),
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: actual.colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                        )),
                  ),
                ),
              )
            ],
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
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          height: 50,
          width: 150,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  child: CrearGrupos(),
                  type: PageTransitionType.fade,
                ),
              );
            },
            style: TextButton.styleFrom(
                backgroundColor: actual.colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                )),
            child: Text(
              'Crear grupo',
              style:
                  TextStyle(color: actual.colorScheme.onPrimary, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
