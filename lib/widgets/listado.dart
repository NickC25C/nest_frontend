import 'package:flutter/material.dart';
import 'package:nest_fronted/main.dart';
import 'package:nest_fronted/models/user.dart';

List<String> selectedItems = [];
List<String> ids = [];

class Listado extends StatefulWidget {
  const Listado({
    Key? key,
  }) : super(key: key);

  @override
  _ListadoState createState() => _ListadoState();

  getSelectedItems() {
    return selectedItems;
  }
  Future<List<String>> getIds() async {
    await Ids();
    return ids;
  }

  Future<List<String>> Ids() async {
    List<User> usuariosSeleccionados = [];

    for (String username in selectedItems) {
      User user = await api.getUserByUsername(username);
      usuariosSeleccionados.add(user);
    }
    print(usuariosSeleccionados);
    print('holisa');

    ids = usuariosSeleccionados.map((user) => user.id).toList();
    return ids;
  }
}

class _ListadoState extends State<Listado> {
  List<User> userFriends = [];
  List<bool> isSelectedList = [];
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    selectedItems = [];
    ids = [];
    refreshFriends();
  }

  void refreshFriends() async {
    userFriends = await api.getUserFriends(api.loggedUser.id);
    isSelectedList = List.generate(userFriends.length, (index) => false);
    setState(() {});
  }

  Future<List<String>> Ids() async {
    List<User> usuariosSeleccionados = [];

    for (String username in selectedItems) {
      User user = await api.getUserByUsername(username);
      usuariosSeleccionados.add(user);
    }
    print(usuariosSeleccionados);
    print('holi');

    ids = usuariosSeleccionados.map((user) => user.id).toList();
    return ids;
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Añadir a:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 250,
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: actual.colorScheme.secondary),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListView.builder(
            clipBehavior: Clip.hardEdge,
            padding: EdgeInsets.all(0.0),
            itemCount: userFriends.length,
            // ignore: body_might_complete_normally_nullable
            itemBuilder: (BuildContext context, int index) {
              if (index < userFriends.length) {
                // Amigos
                return Material(
                  child: ListTile(
                    title: Text(userFriends[index].username),
                    tileColor: isSelectedList[index]
                        ? actual.colorScheme.primary
                        : null,
                    onTap: () {
                      if (selectedItems.contains(userFriends[index].username)) {
                        selectedItems.remove(userFriends[index].username);
                      } else {
                        selectedItems.add(userFriends[index].username);
                      }
                      setState(() {
                        isSelectedList[index] = !isSelectedList[index];
                      });
                    },
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
