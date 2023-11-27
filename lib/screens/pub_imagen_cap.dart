import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nest_fronted/main.dart';
import 'package:nest_fronted/models/capsule.dart';
import 'package:nest_fronted/models/picture.dart';
import 'package:nest_fronted/models/publication.dart';
import 'package:nest_fronted/widgets/barra_publi.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nest_fronted/widgets/titulo_pub.dart';

const tituloScreen = 'PUBLICAR IMAGEN';
Titulo titulete = const Titulo();

class PubImagenCapScreen extends StatelessWidget {
  final Capsule capsula;
  const PubImagenCapScreen({super.key, required this.capsula});
  @override
  Widget build(BuildContext context) {
    return ImagenScreen(
      capsula: capsula,
    );
  }
}

class ImagenScreen extends StatefulWidget {
  final Capsule capsula;
  const ImagenScreen({super.key, required this.capsula});
  @override
  _ImagenScreen createState() => _ImagenScreen();
}

class _ImagenScreen extends State<ImagenScreen> {
  File? _selectedImagen;

  void _updateImage(File image) {
    setState(() {
      _selectedImagen = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BarraPublicar(titulo: tituloScreen),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BotonIzquierdo(onImageSelected: _updateImage),
                  BotonDerecho(onImageDone: _updateImage),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                children: [
                  if (_selectedImagen != null)
                    AnyadirImagen(
                      imagen: _selectedImagen!,
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0),
              child: titulete,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
              child: BotonCrear(
                imageToPub: _selectedImagen,
                capsula: widget.capsula,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BotonIzquierdo extends StatelessWidget {
  final Function(File) onImageSelected;
  const BotonIzquierdo({super.key, required this.onImageSelected});

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      onImageSelected(File(image.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 110,
      child: ElevatedButton(
        onPressed: () async {
          await _pickImage();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.photo,
              color: actual.colorScheme.onSecondary,
            ),
            SizedBox(
              height: 3.0,
            ),
            Text(
              'Seleccionar foto',
              style: TextStyle(
                fontSize: 16,
                color: actual.colorScheme.onSecondary,
              ),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 30.0),
          backgroundColor: actual.colorScheme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
            ),
          ),
        ),
      ),
    );
  }
}

class BotonDerecho extends StatelessWidget {
  final Function(File) onImageDone;
  const BotonDerecho({
    super.key,
    required this.onImageDone,
  });

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      onImageDone(File(image.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 110,
      child: ElevatedButton(
        onPressed: () async {
          await _pickImage();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.camera_alt,
              color: actual.colorScheme.onSecondary,
            ),
            SizedBox(
              height: 3.0,
            ),
            Text(
              'Hacer foto',
              style: TextStyle(
                fontSize: 16,
                color: actual.colorScheme.onSecondary,
              ),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 30.0),
          backgroundColor: actual.colorScheme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
        ),
      ),
    );
  }
}

class AnyadirImagen extends StatelessWidget {
  final File imagen;

  const AnyadirImagen({
    super.key,
    required this.imagen,
  });

  @override
  Widget build(BuildContext context) {
    return Image.file(
      imagen,
      fit: BoxFit.fill,
    );
  }
}

class BotonCrear extends StatelessWidget {
  final Capsule capsula;
  final File? imageToPub;
  const BotonCrear({
    super.key,
    this.imageToPub,
    required this.capsula,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          height: 50,
          width: 170,
          child: TextButton.icon(
            onPressed: () async {
              if (imageToPub != null) {
                print('va');
                await api.addPictureToCapsule(
                  Picture(
                    id: '',
                    owner: api.loggedUser,
                    date: DateTime.now(),
                    publiType: PublicationType.picture,
                    description: titulete.darValor(),
                    url: '',
                    image: imageToPub!,
                    watchers: [],
                  ),
                  capsula.id,
                );
              }
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.image_outlined,
            ),
            label: Text(
              'Subir imagen',
              style: TextStyle(),
            ),
            style: TextButton.styleFrom(
              backgroundColor: actual.colorScheme.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
