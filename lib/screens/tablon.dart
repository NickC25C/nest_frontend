import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nest_fronted/widgets/boton_expandible.dart';
import 'package:nest_fronted/widgets/nota.dart';
import 'package:nest_fronted/widgets/foto.dart';
import 'package:nest_fronted/screens/pub_imagen.dart';
import 'package:nest_fronted/screens/pub_nota.dart';
import 'package:page_transition/page_transition.dart';
import 'package:photo_view/photo_view.dart';

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

  Widget _buildPhotoView() {
    return PhotoView(
      imageProvider: AssetImage('assets/images/rata.png'),
    );
  }

  Widget _buildNoteViewContent() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: const Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'SALUDO',
            style: TextStyle(fontWeight: FontWeight.bold),
            textScaleFactor: 2,
          ),
          Text(
            'La porroflexia es una técnica que consiste en crear formas y estructuras'
            ' a partir del liado de porros de marihuana. Esta técnica, que requiere de '
            'habilidades manuales y una gran dosis de creatividad, ha evolucionado hasta '
            'convertirse en una verdadera forma de arte. A través de la porroflexia, se pueden'
            ' crear figuras y formas de todo tipo, desde animales hasta aviones, pasando por personajes '
            'de ficción y elementos de la naturaleza.',
            style: TextStyle(fontSize: 18.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'De: PEPA',
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

    if (open) {
      return GestureDetector(
        onTap: () => {_buildContentView()},
        child: Container(
          height: screenSize.height,
          width: double.infinity,
          child: _buildPhotoView(),
        ),
      );
    } else if (openNote) {
      return GestureDetector(
        onTap: () => {_buildNoteView()},
        child: Container(
          height: screenSize.height,
          width: double.infinity,
          child: _buildNoteViewContent(),
        ),
      );
    } else {
      return Stack(
        children: <Widget>[
          tablon(),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: _sigmaLevel, sigmaY: _sigmaLevel),
            child: Container(
              color: Colors.black.withOpacity(_opacityLevel),
            ),
          )
        ],
      );
    }
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
              ListView(
                children: [
                  GestureDetector(
                    onTap: () => {_buildContentView()},
                    child: Foto(
                      url: ('assets/images/rata.png'),
                      file: File(''),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {_buildNoteView()},
                    child: const Nota(
                      tituloNota: 'SALUDO',
                      mensaje: "",
                      usu: 'PEPA',
                    ),
                  ),
                ],
              ),
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
    return BotonExpandible(
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
    );
  }
}
