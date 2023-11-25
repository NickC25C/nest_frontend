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
  List<String> listaNombres = [];
  List<bool> isSelectedList = [];
  List<String> names = [];
  List<String> selectedItemsPruebas = [];
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
    listaNombres = [...diffusionList.map((diffusionList) => diffusionList.name).toList(), ...userFriends.map((user) => user.username).toList()];
    isSelectedList = List.generate(listaNombres.length, (index) => false);
    setState(() {});
  }

  void addFriendsFromGroups(int index) async{
    for(int i = 0; i < diffusionList[index].friendsIds.length; i++){
      User usu = await api.getUser(diffusionList[index].friendsIds[i]);
      if(!selectedItems.contains(usu.username)){
        selectedItems.add(usu.username);
        selectedItemsPruebas.add(usu.username);
      }
    }
  }

  void removeFriendsFromGroups(int index) async{
    for(int i = 0; i < diffusionList[index].friendsIds.length; i++){
      User usu = await api.getUser(diffusionList[index].friendsIds[i]);
      int indexFriend = getIndexFriend(usu.username);
      if(indexFriend != 0){
        selectedItems.remove(usu.username);
        selectedItemsPruebas.remove(usu.username);
      }
    }
  }

  int getIndexFriend(String username){
    for(int index = diffusionList.length - 1; index < listaNombres.length; index++){
      if(listaNombres[index] == username){
        return index;
      }
    }
    return 0;
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
                            listaNombres.length,
                                (index) => true,
                          );
                        } else {
                          isSelectedList = List.generate(
                            listaNombres.length,
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
            itemCount: listaNombres.length,
            itemBuilder: (BuildContext context, int index) {
              if (index < diffusionList.length) {
                // Amigos
                return Material(
                  child: ListTile(
                    title: Text(listaNombres[index]),
                    tileColor: isSelectedList[index]
                        ? actual.colorScheme.primary
                        : null,
                    onTap: () {
                      if (names
                          .contains(listaNombres[index])) {
                        removeFriendsFromGroups(index);
                        names.remove(listaNombres[index]);
                        print(selectedItems.length);
                      } else {
                        addFriendsFromGroups(index);
                        names.add(listaNombres[index]);
                        print(selectedItems.length);
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
                    title: Text(listaNombres[index]),

                    tileColor: isSelectedList[index] ? actual.colorScheme.surface : null,
                    onTap: () {
                      if (selectedItems
                          .contains(listaNombres[index]) ) {
                        if(isSelectedList[index]){
                          selectedItems.remove(listaNombres[index]);
                          selectedItemsPruebas.remove(listaNombres[index]);
                          setState(() {
                            isSelectedList[index] = !isSelectedList[index];
                          });
                          print(selectedItems.length);
                        }
                      } else {
                          selectedItems.add(listaNombres[index]);
                          selectedItemsPruebas.add(listaNombres[index]);
                          setState(() {
                            isSelectedList[index] = !isSelectedList[index];
                          });
                          print(selectedItems.length);
                      }
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
