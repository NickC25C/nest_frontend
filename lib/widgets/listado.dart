import 'package:flutter/material.dart';
import 'package:nest_fronted/main.dart';
import 'package:nest_fronted/models/user.dart';
import 'package:nest_fronted/screens/crear_grupos.dart';

class Listado extends StatefulWidget {
  const Listado({
    Key? key,
  }) : super(key: key);

  @override
  _ListadoState createState() => _ListadoState();
}

class _ListadoState extends State<Listado> {
  List<User> userFriends = [];
  List<bool> isSelectedList = [];
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    refreshFriends();
  }

  void refreshFriends() async {
    userFriends = await api.getUserFriends(api.loggedUser.id);
    isSelectedList = List.generate(userFriends.length, (index) => false);
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
                    width: 150.0,
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
            itemCount: userFriends.length,
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
