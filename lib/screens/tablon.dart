import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nest_fronted/models/note.dart';
import 'package:nest_fronted/models/picture.dart';
import 'package:nest_fronted/models/publication.dart';
import 'package:nest_fronted/widgets/barra_titulo.dart';
import 'package:nest_fronted/widgets/boton_expandible.dart';
import 'package:nest_fronted/widgets/nota.dart';
import 'package:nest_fronted/widgets/foto.dart';
import 'package:nest_fronted/screens/pub_imagen.dart';
import 'package:nest_fronted/screens/pub_nota.dart';
import 'package:nest_fronted/widgets/publication_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:photo_view/photo_view.dart';

import '../main.dart';

const tituloScreen = 'MI TABLÓN PERSONAL';
int selectedIndex = 0;
bool open = false;
bool openNote = false;
double _opacityLevel = 0;
double _sigmaLevel = 0;

class TablonScreen extends StatefulWidget {
  const TablonScreen({Key? key}) : super(key: key);
  @override
  TablonState createState() => TablonState();
}

class TablonState extends State<TablonScreen> {
  late List<Publication> publis;

  Future<List<Publication>> initializePublis() async {
    Completer<List<Publication>> completer = Completer();

    try {
      publis = await api.getFeed(api.loggedUser.id);
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

  void publicar() {
    setState(() {
      _opacityLevel = 0.5;
      _sigmaLevel = 10;
    });
  }

  _buildContentView(int index) {
    setState(() {
      selectedIndex = index;
      open = !open;
      openNote =
          false; // Pa asegurarse de que la nota esté cerrada al abrir la imagen
    });
  }

  _buildNoteView(int index) {
    setState(() {
      selectedIndex = index;
      openNote = !openNote;
      open =
          false; // Pa asegurarse de que la imagen esté cerrada al abrir la nota
    });
  }

  ListView _buildTablon(List<Publication> publications) {
    return ListView.builder(
        itemCount: publications.length,
        itemBuilder: (BuildContext context, int index) {
          if (publications[index].publiType == PublicationType.note) {
            return GestureDetector(
              onTap: () => {_buildNoteView(index)},
              child: PublicationWidget(
                pub: publications[index],
              ),
            );
          } else {
            return GestureDetector(
              onTap: () => {_buildContentView(index)},
              child: PublicationWidget(
                pub: publications[index],
              ),
            );
          }
          ;
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
                'De: ${notita.owner!.username}',
              )
            ],
          )
        ],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
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
                  onTap: () => {_buildContentView(selectedIndex)},
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
                  onTap: () => {_buildNoteView(selectedIndex)},
                  child: Container(
                    height: 625,
                    width: double.infinity,
                    child: _buildNoteViewContent(),
                  ),
                ),
              );
            } else {
              return Stack(
                children: <Widget>[
                  tablon(),
                  BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: _sigmaLevel, sigmaY: _sigmaLevel),
                    child: Container(
                      color: Colors.black.withOpacity(_opacityLevel),
                    ),
                  )
                ],
              );
            }
          }
        });
  }

  Widget tablon() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          height: 600,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              _buildTablon(publis),
              BotonPublicar(),
            ],
          ),
        ),
      ],
    );
  }
}

class BotonPublicar extends StatelessWidget {
  const BotonPublicar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BotonExpandible(
        distance: 112,
        children: [
          ActionButton(
            icon: const Icon(Icons.photo),
            onPressed: () => {
              Navigator.push(
                context,
                PageTransition(
                  child: PubImagenScreen(),
                  type: PageTransitionType.fade,
                ),
              )
            },
          ),
          ActionButton(
            icon: const Icon(Icons.text_snippet),
            onPressed: () => {
              Navigator.push(
                context,
                PageTransition(
                  child: PubNotaScreen(),
                  type: PageTransitionType.fade,
                ),
              )
            },
          ),
        ],
      ),
    );
  }
}
