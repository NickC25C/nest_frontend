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
      if(publis.isEmpty){
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

  Widget _buildPhotoView() {
    Picture fotita = publis[selectedIndex] as Picture;
    return PhotoView(imageProvider: NetworkImage(fotita.image!.path));
  }

  Widget _buildNoteViewContent() {
    Note notita = publis[selectedIndex] as Note;
    return Container(
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
            if (open) {
              return Card(
                child: GestureDetector(
                  onTap: () => {_buildContentView()},
                  child: Container(
                    height: 625,
                    width: double.infinity,
                    child: _buildPhotoView(),
                  ),
                ),
              );
            } else if (openNote) {
              return Card(
                child: GestureDetector(
                  onTap: () => {_buildNoteView()},
                  child: Container(
                    height: 625,
                    width: double.infinity,
                    child: _buildNoteViewContent(),
                  ),
                ),
              );
            } else {
              return Scaffold(
                body: SingleChildScrollView(
                  child: Stack(
                    children: <Widget>[
                      capsula(),
                      BackdropFilter(
                        filter:
                        ImageFilter.blur(sigmaX: _sigmaLevel, sigmaY: _sigmaLevel),
                        child: Container(
                          color: Colors.black.withOpacity(_opacityLevel),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          }
        });
  }

  Widget capsula() {
    return Column(
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
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          height: 600,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ListView.builder(
                itemCount: publis.length,
                itemBuilder: (BuildContext context, int index) {
                  if(publis[index].publiType == PublicationType.note){
                    return GestureDetector(
                      onTap: () {
                        _buildNoteView();
                        selectedIndex = index;
                      },
                      child: PublicationWidget(pub: publis[index]),
                    );
                  }
                  else{
                    return GestureDetector(
                      onTap: () {
                        _buildContentView();
                        selectedIndex = index;
                      },
                      child: PublicationWidget(pub: publis[index]),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
