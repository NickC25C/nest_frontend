import 'package:flutter/material.dart';
import 'package:nest_fronted/main.dart';
import 'package:nest_fronted/models/user.dart';
import 'package:nest_fronted/screens/crear_grupos.dart';

List<String> selectedItems = [];

class ListadoCreacion extends StatefulWidget {
  const ListadoCreacion({
    Key? key,
  }) : super(key: key);

  @override
  _ListadoState createState() => _ListadoState();

  getSelectedItems(){
    return selectedItems;
  }
}

class _ListadoState extends State<ListadoCreacion> {
  List<User> userFriendsAndDiffusionLists = [];
  List<bool> isSelectedList = [];
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    selectedItems = [];
    refreshFriends();
  }

  void refreshFriends() async {
    userFriendsAndDiffusionLists = await api.getUserFriends(api.loggedUser.id);
    isSelectedList = List.generate(userFriendsAndDiffusionLists.length, (index) => false);
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
              Row(
                children: [
                  Container(
                    width: 104.0,
                    child: Text(
                      'Enviar a todos',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 0.1),
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                        if (isChecked) {
                          isSelectedList = List.generate(
                            userFriendsAndDiffusionLists.length,
                                (index) => true,
                          );
                        } else {
                          isSelectedList = List.generate(
                            userFriendsAndDiffusionLists.length,
                                (index) => false,
                          );
                        }
                      });
                    },
                  ),
                ],
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
            itemCount: userFriendsAndDiffusionLists.length,
            itemBuilder: (BuildContext context, int index) {
              if (index < userFriendsAndDiffusionLists.length) {
                // Amigos
                return Material(
                  child: ListTile(
                    title: Text(userFriendsAndDiffusionLists[index].username),
                    tileColor: isSelectedList[index]
                        ? actual.colorScheme.primary
                        : null,
                    onTap: () {
                      if (selectedItems
                          .contains(userFriendsAndDiffusionLists[index].username)) {
                        selectedItems
                            .remove(userFriendsAndDiffusionLists[index].username);
                      } else {
                        selectedItems
                            .add(userFriendsAndDiffusionLists[index].username);
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
