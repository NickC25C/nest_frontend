import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nest_fronted/widgets/barra_titulo.dart';
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
double _opacityLevel = 0;
double _sigmaLevel = 0;

class TablonScreen extends StatefulWidget {
  const TablonScreen({super.key});

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

  _buildPhotoView() {
    setState(() {
      open = !open;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    if (open) {
      return GestureDetector(
              onTap: () => {_buildPhotoView()},
              child: Container(
                height: screenSize.height,
                width: double.infinity,
                child: PhotoView(
                    imageProvider: AssetImage('assets/images/rata.png')),
              ));
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

//Se ha de cambiar por un stack para la foto de fondo

  Widget tablon() {
    return Column(
      children: [
        const BarraTitulo(titulo: tituloScreen),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          height: 600,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ListView(
                children: [
                  Nota(tituloNota: 'SALUDO'),
                  GestureDetector(
                    onTap: () => {_buildPhotoView()},
                    child: Foto(url: ('assets/images/rata.png')),
                  )
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
    super.key,
  });

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
                  type: PageTransitionType.fade
              )
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
                    type: PageTransitionType.fade
                )
            )
          },
        ),
      ],
    );
  }
}


