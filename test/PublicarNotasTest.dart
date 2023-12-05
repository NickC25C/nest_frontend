import 'package:flutter_test/flutter_test.dart';
import 'package:nest_fronted/widgets/nota.dart';

void main() {
  test('Inicialización de Nota', () {
    final tituloNota = 'Título de prueba';
    final mensaje = 'Mensaje de prueba';
    final username = 'Usuario de prueba';

    final nota = Nota(tituloNota: tituloNota, mensaje: mensaje, usu: username);

    expect(nota.tituloNota, equals(tituloNota));
    expect(nota.mensaje, equals(mensaje));
    expect(nota.usu, equals(username));
  });

  testWidgets('Widget Nota muestra información correctamente', (WidgetTester tester) async {
    final tituloNota = 'Título de prueba';
    final mensaje = 'Mensaje de prueba';
    final usu = 'Usuario de prueba';

    await tester.pumpWidget(Nota(tituloNota: tituloNota, mensaje: mensaje, usu: usu));
    await tester.pump();

    // Verificar que el título de la nota y el nombre del usuario se muestran correctamente
    expect(find.text(tituloNota), findsOneWidget);
    expect(find.text('De: $usu'), findsOneWidget);
  });
}
