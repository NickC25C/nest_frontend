
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nest_fronted/widgets/foto.dart';

void main() {
  test('Inicialización de Foto', () {
    final file = File('assets/images/anyadir_imagen.png');  // Reemplaza con una ruta de archivo válida
    final username = 'Usuario de prueba';

    final foto = Foto(file: file, username: username);

    expect(foto.file, equals(file));
    expect(foto.username, equals(username));
  });

  testWidgets('Widget Foto muestra información correctamente', (WidgetTester tester) async {
    final file = File('i.ytimg.com/vi/CSIkNVZ7ZpY/maxresdefault.jpg');  // Reemplaza con una ruta de archivo válida
    final username = 'Usuario de prueba';

    await tester.pumpWidget(Foto(file: file, username: username));
    await tester.pump();

    // Verificar que el nombre del propietario y la imagen se muestran correctamente
    expect(find.text(username), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });
}