import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nest_fronted/widgets/barra_publi.dart';
import 'package:nest_fronted/widgets/listado.dart';
import 'package:nest_fronted/widgets/selector_fecha.dart';
import 'package:nest_fronted/widgets/titulo_pub.dart';
import 'package:nest_fronted/models/capsule.dart';
import 'package:nest_fronted/models/user.dart';
import 'package:nest_fronted/main.dart';
import 'package:image_picker/image_picker.dart';

const tituloScreen = 'Crear Cápkkksula';
int selectedIndex = 0;
Titulo titulin = Titulo();
Listado listadito = Listado();

class CrearCapsula extends StatefulWidget {
  const CrearCapsula({Key? key}) : super(key: key);

  @override
  _CrearCapsulaState createState() => _CrearCapsulaState();
}

class _CrearCapsulaState extends State<CrearCapsula> {
  File? _selectedImage;

  void _updateImage(File image) {
    setState(() {
      _selectedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    listadito.createState;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Barra de título
            BarraPublicar(titulo: tituloScreen),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Titulo(),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0),
              child: EscogerPortada(
                onImageSelected: _updateImage,
                selectedImage: _selectedImage,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: EscribirDescripcion(),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: FechaApertura(texto: 'Fecha de apertura'),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Listado(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
              child: BotonCrearCapsula(imageToPub: _selectedImage),
            ),
          ],
        ),
      ),
    );
  }
}

// Escoger foto de portada
class EscogerPortada extends StatelessWidget {
  final Function(File) onImageSelected;
  final File? selectedImage;

  const EscogerPortada({
    Key? key,
    required this.onImageSelected,
    required this.selectedImage,
  }) : super(key: key);

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      onImageSelected(File(image.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton.icon(
          onPressed: () async {
            await _pickImage(context);
          },
          icon: Icon(Icons.photo),
          label: Text('Añadir foto'),
        ),
        SizedBox(width: 16),
        //mostrar la fotito
        selectedImage != null
            ? Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Image.file(selectedImage!),
              )
            : Container(),
      ],
    );
  }
}

// Escribir descripcion a la cápsula
String descripcion = '';

class EscribirDescripcion extends StatelessWidget {
  const EscribirDescripcion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Descripción:',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            width: double.infinity,
            child: TextField(
              onChanged: (value) => descripcion = value,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Descripción',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//Crear capsula boton
class BotonCrearCapsula extends StatelessWidget {
  final File? imageToPub;
  const BotonCrearCapsula({
    super.key,
    this.imageToPub,
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
            onPressed: () {
              crearCapsula();
              print('pimpampum');
              //cositas
            },
            icon: Icon(
              Icons.hourglass_bottom,
            ),
            label: Text(
              'Crear cápsula',
              style: TextStyle(),
            ),
            style: TextButton.styleFrom(
                backgroundColor: actual.colorScheme.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                )),
          ),
        ),
      ),
    );
  }

  void crearCapsula() async {
    await listadito.getIds();

    Capsule capsulita = Capsule(
      id: "",
      title: titulin.darValor(),
      description: descripcion,
      openDate: DateTime.parse(fecha),
      members: ids,
    );
    api.createCapsule(capsulita, ids);
  }
}
