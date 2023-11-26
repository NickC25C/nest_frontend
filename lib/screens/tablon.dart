import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nest_fronted/models/note.dart';
import 'package:nest_fronted/models/picture.dart';
import 'package:nest_fronted/models/publication.dart';
import 'package:nest_fronted/widgets/boton_expandible.dart';
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
  List<Publication> notitas = [];
  List<Publication> imagensitas = [];

  Future<List<Publication>> initializePublis() async {
    Completer<List<Publication>> completer = Completer();

    try {
      publis = await api.getFeed(api.loggedUser.id);

      // Separar las publicaciones en listas de notas y fotos
      notitas = publis.where((pub) => pub.publiType == PublicationType.note).toList();
      imagensitas = publis.where((pub) => pub.publiType == PublicationType.picture).toList();

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

  Widget _buildNotas() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: notitas.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () => _buildContentView(publis.indexOf(notitas[index])),
          child: PublicationWidget(pub: notitas[index]),
        );
      },
    );
  }

  Widget _buildImagenes() {
    return ListView.builder(
      itemCount: imagensitas.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () => _buildContentView(publis.indexOf(imagensitas[index])),
          child: PublicationWidget(pub: imagensitas[index]),
        );
      },
    );
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
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
              child: Text(
                  'Notitas:',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                  ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              height: 165,
              width: double.infinity,
              child: _buildNotas(),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
              child: Text(
                'Imagensitas:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
              height: 350,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _buildImagenes(),
                  BotonPublicar(),
                ],
              ),
            ),
          ],
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