import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nest_fronted/models/capsule.dart';
import 'package:nest_fronted/models/picture.dart';
import 'package:nest_fronted/models/publication.dart';
import 'package:nest_fronted/models/user.dart';
import 'package:nest_fronted/screens/capsulaAbierta.dart';
import 'package:nest_fronted/screens/capsulaCerrada.dart';
import 'package:nest_fronted/widgets/MostrarCapsulaAbierta.dart';
import 'package:nest_fronted/widgets/MostrarCapsulaCerrada.dart';
import 'package:photo_view/photo_view.dart';

CapsulaAbiertaState a = CapsulaAbiertaState();
void main() {
  testWidgets(
      'CapsulaCerrada se muestra correctamente y se muestra correctamente la ventana de la capsula Cerrada',
      (WidgetTester tester) async {
    // Construye nuestro widget en un entorno de prueba
    await tester.pumpWidget(
      MaterialApp(
        home: CapsulaCerrada(
          capsula: Capsule(
              id: '',
              title: 'Título de prueba',
              description: 'Descripcion de prueba',
              openDate: DateTime.now(),
              members: ['1', '2']),
        ),
      ),
    );

    // Puedes agregar afirmaciones aquí para verificar que el widget se construya correctamente
    expect(find.text('Título de prueba'), findsOneWidget);
    expect(find.byType(RawMaterialButton), findsOneWidget);

    // Puedes realizar interacciones y esperar por reconstrucciones
    await tester.tap(find.byType(RawMaterialButton));
    await tester.pumpAndSettle();

    // Asegúrate de que la pantalla siguiente se haya construido correctamente
    expect(find.byType(CapsulaCerradaScreen), findsOneWidget);
  });

  testWidgets('CapsulaAbierta se muestra correctamente',
      (WidgetTester tester) async {
    // Construye nuestro widget en un entorno de prueba
    await tester.pumpWidget(
      MaterialApp(
        home: CapsulaAbierta(
          capsula: Capsule(
              id: '',
              title: 'Título de prueba',
              description: 'Descripcion de prueba',
              openDate: DateTime.now(),
              members: ['1', '2']),
        ),
      ),
    );

    // Puedes agregar afirmaciones aquí para verificar que el widget se construya correctamente
    expect(find.text('Título de prueba'), findsOneWidget);
    expect(find.text('Descripcion de prueba'), findsOneWidget);
    expect(find.byType(RawMaterialButton), findsOneWidget);
  });

  testWidgets('CapsulaCerradaScreen muestra correctamente',
      (WidgetTester tester) async {
    // Construir nuestro widget fuera del alcance de los Widgets de prueba.
    await tester.pumpWidget(
      MaterialApp(
        home: CapsulaCerradaScreen(
          capsula: Capsule(
              id: '',
              title: 'Título de prueba',
              description: 'Descripcion de prueba',
              openDate: DateTime.now(),
              members: ['1', '2']),
        ),
      ),
    );
    // Asegúrate de que el widget de título esté presente.
    expect(find.text('Título de prueba'), findsOneWidget);
    expect(find.text('Descripcion de prueba'), findsOneWidget);

    // Asegúrate de que los widgets de botones estén presentes.
    expect(find.byIcon(Icons.text_snippet), findsOneWidget);
    expect(find.byIcon(Icons.photo), findsOneWidget);
  });
  testWidgets('fotoAbiertaCapsula muestra correctamente la información',
      (WidgetTester tester) async {
    // Mock del objeto Picture para simular datos
    final file = File('assets/images/anyadir_imagen.png');
    Picture mockPicture = Picture(
        id: '',
        owner: User(
            id: '',
            name: '',
            lastname: '',
            username: 'username',
            password: '',
            mail: ''),
        date: DateTime.now(),
        publiType: PublicationType.picture,
        description: 'description',
        url: 'url',
        image: file,
        watchers: []);

    // Construye el widget
    await tester.pumpWidget(a.fotoAbierta(mockPicture));

    // Verifica que se muestre el nombre del propietario con la arroba delante
    expect(find.text('@username'), findsOneWidget);

    // Verifica que se muestre la descripción de la imagen
    expect(find.text('description'), findsOneWidget);

    // Verifica la presencia de PhotoView
    expect(find.byType(PhotoView), findsOneWidget);
  });

  testWidgets('Test de buildPhotoView', (WidgetTester tester) async {
    // Construye nuestro widget en un ambiente de prueba
    final file = File('assets/images/anyadir_imagen.png');
    await tester.pumpWidget(a.buildPhotoView(Picture(
        id: '',
        owner: User(
            id: '',
            name: '',
            lastname: '',
            username: 'username',
            password: '',
            mail: ''),
        date: DateTime.now(),
        publiType: PublicationType.picture,
        description: 'description',
        url: 'url',
        image: file,
        watchers: [])));

    final photoViewFinder = find.byKey(Key('photoViewKeyCapsula'));
    expect(photoViewFinder, findsOneWidget);

    final photoViewWidget = tester.widget<PhotoView>(photoViewFinder);
    expect(photoViewWidget.backgroundDecoration,
        BoxDecoration(color: Colors.transparent));
  });
}
