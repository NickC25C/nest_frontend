import 'dart:async';
import 'dart:ui';
import 'package:blur/blur.dart';
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
double _opacityLevel = 0;
double _sigmaLevel = 0;

class TablonScreen extends StatefulWidget {
  const TablonScreen({
    Key? key,
  }) : super(key: key);
  @override
  TablonState createState() => TablonState();
}

class TablonState extends State<TablonScreen> {
  late List<Publication> publis;
  List<Publication> notitas = [];
  List<Publication> imagensitas = [];
  int selectedIndexImage = 0;
  int selectedIndexNote = 0;
  bool open = false;
  bool openNote = false;

  Future<List<Publication>> initializePublis() async {
    Completer<List<Publication>> completer = Completer();

    try {
      publis = await api.getFeed(api.loggedUser.id);
      // Separar las publicaciones en listas de notas y fotos
      if (notitas.isEmpty) {
        notitas = publis
            .where((pub) => pub.publiType == PublicationType.note)
            .toList();
      }
      if (imagensitas.isEmpty) {
        imagensitas = publis
            .where((pub) => pub.publiType == PublicationType.picture)
            .toList();
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
    _opacityLevel = 0.2;
    _sigmaLevel = 10;
  }

  void publicar() {
    setState(() {
      _opacityLevel = 0.5;
      _sigmaLevel = 10;
    });
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

  Widget _buildNotas() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: notitas.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            _buildNoteView();
            selectedIndexNote = index;
          },
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
          onTap: () {
            _buildContentView();
            selectedIndexImage = index;
          },
          child: PublicationWidget(pub: imagensitas[index]),
        );
      },
    );
  }

  Widget buildPhotoView(Picture fotita) {
    return PhotoView(
      key: Key('photoViewKey'),
      imageProvider: NetworkImage(fotita.image!.path),
      backgroundDecoration: BoxDecoration(color: Colors.transparent),
    );
  }

  Widget _buildNoteViewContent() {
    Note notita = notitas[selectedIndexNote] as Note;
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
                IconButton(
                  onPressed: () {
                    setState(() {
                      open = !open;
                      openNote =
                          false; // Pa asegurarse de que la nota esté cerrada al abrir la imagen
                    });
                  },
                  icon: Icon(Icons.close),
                  alignment: Alignment.topRight,
                )
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

  Widget _building() {
    if (open) {
      return Stack(
        alignment: Alignment.center,
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: _sigmaLevel, sigmaY: _sigmaLevel),
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 80),
            child: fotoAbierta(imagensitas[selectedIndexImage] as Picture),
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
              children: [_buildNoteViewContent()],
            ),
          ),
        ),
      );
    } else {
      return Stack();
    }
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
            return SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  tablon(),
                  _building(),
                ],
              ),
            );
          }
        });
  }

  String monthNumberToString(int month) {
    switch (month) {
      case 1:
        return 'enero';
      case 2:
        return 'febrero';
      case 3:
        return 'marzo';
      case 4:
        return 'abril';
      case 5:
        return 'mayo';
      case 6:
        return 'junio';
      case 7:
        return 'julio';
      case 8:
        return 'agosto';
      case 9:
        return 'septiembre';
      case 10:
        return 'octubre';
      case 11:
        return 'noviembre';
      case 12:
        return 'diciembre';
      default:
        return 'mes no válido';
    }
  }

  Widget tablon() {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: 150.0,
                        child: Text(
                          '¡Hola ' + api.loggedUser.name + '!',
                          style: TextStyle(
                              fontSize: 31.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      height: 180.0,
                      width: 180.0,
                      child: Image.asset('assets/images/pollo_deportivo.png')),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tu tablón',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 7.0),
                      Text(
                        'Hoy, ' +
                            DateTime.now().day.toString() +
                            ' de ' +
                            monthNumberToString(DateTime.now().month),
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
