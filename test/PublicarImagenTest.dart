import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nest_fronted/models/picture.dart';
import 'package:nest_fronted/models/publication.dart';
import 'package:nest_fronted/models/user.dart';
import 'package:nest_fronted/widgets/foto.dart';
import 'package:photo_view/photo_view.dart';
import 'package:nest_fronted/screens/tablon.dart';

TablonState a = TablonScreen().createState();

void main() {
  test('Inicialización de Foto', () {
    final file = File(
        'assets/images/anyadir_imagen.png'); // Reemplaza con una ruta de archivo válida
    final username = 'Usuario de prueba';

    final foto = Foto(file: file, username: username);

    expect(foto.file, equals(file));
    expect(foto.username, equals(username));
  });

  testWidgets('Widget Foto muestra información correctamente',
      (WidgetTester tester) async {
    final file = File(
        'i.ytimg.com/vi/CSIkNVZ7ZpY/maxresdefault.jpg'); // Reemplaza con una ruta de archivo válida
    final username = 'Usuario de prueba';

    await tester.pumpWidget(Foto(file: file, username: username));
    await tester.pump();

    // Verificar que el nombre del propietario y la imagen se muestran correctamente
    expect(find.text(username), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
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
        watchers: []))); // Reemplaza MyApp con el nombre de tu aplicación o widget principal

    // Accede a tu widget _buildPhotoView
    final photoViewFinder = find.byKey(
        Key('photoViewKey')); // Asegúrate de darle un Key único a tu widget
    expect(photoViewFinder, findsOneWidget);

    // Realiza tus pruebas específicas para el widget
    // Por ejemplo, puedes verificar si el widget contiene ciertos elementos, interacciones, etc.
    // Puedes acceder a funciones específicas del widget para obtener información o interactuar con él

    // Ejemplo de verificación de la existencia del widget PhotoView
    final photoViewWidget = tester.widget<PhotoView>(photoViewFinder);
    expect(photoViewWidget.backgroundDecoration,
        BoxDecoration(color: Colors.transparent));

    // Puedes agregar más aserciones según tus necesidades
  });
  /*testWidgets('fotoAbierta muestra correctamente la información',
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
  });*/
}
