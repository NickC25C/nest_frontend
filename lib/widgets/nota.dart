import 'package:flutter/material.dart';
import 'package:nest_fronted/models/note.dart';

import '../main.dart';

class Nota extends StatelessWidget {
  final Note nota;

  const Nota({super.key, required this.nota});
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: SingleChildScrollView(
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
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/${api.loggedUser.avatar}.png'),
                              fit: BoxFit.fitWidth),
                        )),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      '@' + nota.owner.username,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
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
                          SizedBox(
                            width: 10.0,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                  nota.title,
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ),
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
          ),
        ));
  }
}
