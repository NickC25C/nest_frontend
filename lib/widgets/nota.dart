import 'package:flutter/material.dart';
import 'package:nest_fronted/models/note.dart';

class Nota extends StatelessWidget {
  final Note nota;

  const Nota({super.key, required this.nota});
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Column(
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/Anselmo.png'),
                            fit: BoxFit.fitWidth),
                      )),
                  Text(
                    '@' + nota.owner.username,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Container(
                  width: 158,
                  height: 105,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          offset: Offset(0, 1),
                          blurRadius: 13)
                    ],
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(nota.title),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 16,
                                ),
                              )
                            ]),
                      ])),
            ],
          ),
        ));
  }
}
