import 'package:flutter/material.dart';
import 'package:nest_fronted/main.dart';
import 'package:nest_fronted/models/user.dart';

List<User> selectedItem = [];

class ListadoUnico extends StatefulWidget {
  const ListadoUnico({
    Key? key,
  }) : super(key: key);

  @override
  _ListadoUnicoState createState() => _ListadoUnicoState();

  getSelectedItem() {
    print(selectedItem);
    return selectedItem[0];
  }
}

class _ListadoUnicoState extends State<ListadoUnico> {
  List<User> userFriends = [];
  int selectedUserIndex = -1;

  @override
  void initState() {
    super.initState();
    refreshFriends();
    selectedItem = [];
  }

  void refreshFriends() async {
    userFriends = await api.getUserFriends(api.loggedUser.id);
    setState(() {});
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
                'Enviar a:',
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
                    tileColor: selectedUserIndex == index
                        ? actual.colorScheme.primary
                        : null,
                    onTap: () {
                      setState(() {
                        if (selectedUserIndex == index) {
                          // Deseleccionar usuario si ya estaba seleccionado
                          selectedUserIndex = -1;
                          selectedItem = []; // Limpiar la lista al deseleccionar
                        } else {
                          // Seleccionar nuevo usuario y deseleccionar el anterior
                          selectedUserIndex = index;
                          selectedItem = [userFriends[index]];

                          // Imprimir el usuario seleccionado en la consola
                          print('Usuario seleccionado: ${selectedItem.first}');
                        }
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
