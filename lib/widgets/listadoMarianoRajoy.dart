import 'package:flutter/material.dart';
import 'package:nest_fronted/main.dart';
import 'package:nest_fronted/models/diffusionList.dart';
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
  List<User> userFriends = [];
  List<DiffusionList> diffusionList = [];
  List<String> listaConcatenada = [];
  List<bool> isSelectedList = [];
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    selectedItems = [];
    refreshFriends();
  }

  void refreshFriends() async {
    userFriends = await api.getUserFriends(api.loggedUser.id);
    diffusionList = await api.getDiffusionLists(api.loggedUser.id);
    for(int i = 0; i < diffusionList.length; i++){
      listaConcatenada.add(diffusionList[i].name);
    }
    for(int j = 0; j < userFriends.length; j++){
      listaConcatenada.add(userFriends[j].username);
    }
    isSelectedList = List.generate(listaConcatenada.length, (index) => false);
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
                            userFriends.length,
                                (index) => true,
                          );
                        } else {
                          isSelectedList = List.generate(
                            userFriends.length,
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
            itemCount: listaConcatenada.length,
            itemBuilder: (BuildContext context, int index) {
              if (index < diffusionList.length) {
                // Amigos
                return Material(
                  child: ListTile(
                    title: Text(diffusionList[index].name),
                    tileColor: isSelectedList[index]
                        ? actual.colorScheme.primary
                        : null,
                    onTap: () {
                      if (selectedItems
                          .contains(diffusionList[index].name)) {
                        selectedItems
                            .remove(diffusionList[index].name);
                      } else {
                        selectedItems
                            .add(diffusionList[index].name);
                      }
                      setState(() {
                        isSelectedList[index] = !isSelectedList[index];
                      });
                    },
                  ),
                );
              }else{
                // Amiguetes
                return Material(
                  child: ListTile(
                    title: Text(listaConcatenada[index]),

                    tileColor: isSelectedList[index] ? actual.colorScheme.surface : null,
                    onTap: () {
                      if (selectedItems
                          .contains(userFriends[index].username)) {
                        selectedItems
                            .remove(userFriends[index].username);
                      } else {
                        selectedItems
                            .add(userFriends[index].username);
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
