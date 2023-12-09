import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nest_fronted/models/capsule.dart';
import 'package:nest_fronted/widgets/barra_publi.dart';
import 'package:nest_fronted/widgets/foto.dart';
import 'package:nest_fronted/widgets/nota.dart';
import 'package:photo_view/photo_view.dart';

import '../main.dart';
import '../models/note.dart';
import '../models/picture.dart';
import '../models/publication.dart';
import '../widgets/publication_widget.dart';

const tituloScreen = 'Título Capsula';
bool open = false;
bool openNote = false;
double _opacityLevel = 0;
double _sigmaLevel = 0;

class CapsulaAbiertaScreen extends StatefulWidget {
  final Capsule capsula;
  const CapsulaAbiertaScreen({Key? key, required this.capsula})
      : super(key: key);

  @override
  CapsulaAbiertaState createState() => CapsulaAbiertaState();
}

class CapsulaAbiertaState extends State<CapsulaAbiertaScreen> {
  late List<Publication> publis = [];
  int selectedIndex = 0;

  Future<List<Publication>> initializePublis() async {
    Completer<List<Publication>> completer = Completer();

    try {
      if (publis.isEmpty) {
        publis = await api.getPublications(widget.capsula.id);
      }

      completer.complete(publis);
    } catch (error) {
      completer.completeError(error);
    }
    return completer.future;
  }

  @override
  void initState() {
    super.initState();
    initializePublis();
  }

  _buildContentView() {
    setState(() {
      open = !open;
      openNote =
          false; // Pa asegurarse de que la nota esté cerrada al abrir la imagen
    });
  }

  _buildNoteView() {
    setState(() {
      openNote = !openNote;
      open =
          false; // Pa asegurarse de que la imagen esté cerrada al abrir la nota
    });
  }

  Widget buildPhotoView(Picture fotita) {
    return PhotoView(
      key: Key('photoViewKeyCapsula'),
      imageProvider: NetworkImage(fotita.image!.path),
      backgroundDecoration: BoxDecoration(color: Colors.transparent),
    );
  }

  Widget buildNoteViewContent(Note notita) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              notita.title,
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 2,
            ),
            Text(
              notita.message,
              style: TextStyle(fontSize: 18.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'De: ${notita.owner.username}',
                )
              ],
            )
          ],
        )),
      ),
    );
  }

  Widget fotoAbierta(Picture fotita) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: 310,
        height: 551,
        child: Column(children: [
          Row(
            children: [
              Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/bobby_formulario.png'),
                        fit: BoxFit.fitWidth),
                  )),
              Text(
                '@' + fotita.owner.username,
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
            width: 310,
            height: 491,
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
            child: Column(children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      open = !open;
                      openNote = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    shape: CircleBorder(),
                    backgroundColor: Colors.transparent,
                  ),
                  child: Icon(Icons.close, color: Colors.black),
                ),
              ]),
              Container(
                width: 250,
                height: 335,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: buildPhotoView(fotita),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                fotita.description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, height: 1.5),
              ),
            ]),
          )
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Publication>>(
        future: initializePublis(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Scaffold(
              body: Column(children: [
                Stack(
                  children: <Widget>[
                    capsula(),
                    _building(),
                  ],
                ),
              ]),
            );
          }
        });
  }

  Widget _building() {
    if (open) {
      return Stack(
        alignment: Alignment.center,
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: fotoAbierta(publis[selectedIndex] as Picture),
          )
        ],
      );
    } else if (openNote) {
      return Card(
        child: GestureDetector(
          onTap: () => {_buildNoteView()},
          child: Container(
            height: 625,
            width: double.infinity,
            child: Stack(
              children: [buildNoteViewContent(publis[selectedIndex] as Note)],
            ),
          ),
        ),
      );
    } else {
      return Stack();
    }
  }

  Widget capsula() {
    return SingleChildScrollView(
      child: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            children: [
              BarraPublicar(titulo: widget.capsula.title),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  widget.capsula.description,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              Container(
                height: 600,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ListView.builder(
                      itemCount: publis.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (publis[index].publiType == PublicationType.note) {
                          return Padding(
                              padding: EdgeInsets.only(top: 20, left: 90),
                              child: GestureDetector(
                                onTap: () {
                                  _buildNoteView();
                                  selectedIndex = index;
                                },
                                child: PublicationWidget(pub: publis[index]),
                              ));
                        } else {
                          return Padding(
                            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                            child: GestureDetector(
                              onTap: () {
                                _buildContentView();
                                selectedIndex = index;
                              },
                              child: PublicationWidget(pub: publis[index]),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
