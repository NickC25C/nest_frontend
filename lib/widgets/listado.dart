import 'package:flutter/material.dart';
import 'package:nest_fronted/main.dart';

class Listado extends StatefulWidget {
  const Listado({
    Key? key,
  }) : super(key: key);


  @override
  _ListadoState createState() => _ListadoState();
}

class _ListadoState extends State<Listado> {
  List<bool> isSelectedList = [];
  bool isChecked = false;

  @override
  void initState() {
    super.initState();

    isSelectedList = List.generate(
      bd.loggedUser.diffusionGroups!.length + bd.loggedUser.friends!.length,
          (index) => false,
    );
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
                      'Enviar a todo cristo',
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
                            isSelectedList.length,
                                (index) => true,
                          );
                        } else {
                          isSelectedList = List.generate(
                            isSelectedList.length,
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
            border: Border.all(width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Scrollbar(
            child: ListView.builder(
              padding: EdgeInsets.all(0.0),
              itemCount: bd.loggedUser.diffusionGroups!.length + bd.loggedUser.friends!.length,
              itemBuilder: (BuildContext context, int index) {
                if (index < bd.loggedUser.diffusionGroups!.length) {
                  // Grupetes
                  return ListTile(
                    title: Text(bd.loggedUser.diffusionGroups![index].name),

                    tileColor: isSelectedList[index] ? Colors.blue : null,
                    onTap: () {
                      setState(() {

                        isSelectedList[index] = !isSelectedList[index];
                      });
                    },
                  );
                } else {
                  // Amiguetes
                  final friendIndex = index - bd.loggedUser.diffusionGroups!.length;
                  return ListTile(
                    title: Text(bd.loggedUser.friends![friendIndex].username),

                    tileColor: isSelectedList[index] ? Colors.blue : null,
                    onTap: () {
                      setState(() {

                        isSelectedList[index] = !isSelectedList[index];
                      });
                    },
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}