import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../models/capsule.dart';
import '../screens/capsulaAbierta.dart';

class CapsulaAbierta extends StatelessWidget {
  final Capsule capsula;
  const CapsulaAbierta({Key? key, required this.capsula}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String txt;
    String fecha = capsula.openDate.day.toString() +
        '/' +
        capsula.openDate.month.toString() +
        '/' +
        capsula.openDate.year.toString();
    if (capsula.description.length <= 15) {
      txt = capsula.description;
    } else {
      txt = '${capsula.description.substring(0, 15)}...';
    }
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Column(
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  PageTransition(
                    child: CapsulaAbiertaScreen(
                      capsula: capsula,
                    ),
                    type: PageTransitionType.fade,
                  ),
                ),
                child: Container(
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 2, 10, 8),
                            child: Text(
                              capsula.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                            child: Text(
                              txt,
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 10, top: 10),
                                child: Text(
                                  fecha,
                                  style: TextStyle(fontSize: 10),
                                ),
                              )
                            ],
                          )
                        ])),
              )
            ],
          ),
        ));
  }
}
