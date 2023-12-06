import 'package:flutter_test/flutter_test.dart';
import 'package:nest_fronted/widgets/nota.dart';
import 'package:nest_fronted/widgets/publication_widget.dart';
import 'package:nest_fronted/models/publication.dart';
import 'package:nest_fronted/models/note.dart';
import 'package:nest_fronted/services/api_service.dart';
import 'package:nest_fronted/screens/tablon.dart';


ApiService api = ApiService();

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

 /* testWidgets('Widget Nota muestra información correctamente', (WidgetTester tester) async {
    final tituloNota = 'Título de prueba';
    final mensaje = 'Mensaje de prueba';
    final usu = 'Usuario de prueba';

    await tester.pumpWidget(Nota(tituloNota: tituloNota, mensaje: mensaje, usu: usu));
    await tester.pump();

    // Imprimir el estado actual de la aplicación
    print('Antes de pumpAndSettle:');
    print(tester.binding.renderView.toString());

    // Esperar a que la aplicación se establezca
    await tester.pumpAndSettle();
    print('Después de pumpAndSettle:');

    // Verificar que la nota se ve bien antes del toquesito
    expect(find.text(tituloNota), findsOneWidget);
    expect(find.text('De: $usu'), findsOneWidget);

    // Simular el toquesito
    await tester.tap(find.byType(PublicationType.note));
    await tester.pump(); // Esperar a que la aplicación se actualice después del toque
    print('Después del toque:');
    print(tester.binding.renderView.toString());

    // Verificar que la pantalla de vista de la nota se muestra correctamente
    expect(find.text(tituloNota), findsOneWidget);
    print("tuki");
    expect(find.text(mensaje), findsOneWidget);
    print("tuki2");
    expect(find.text('De: $usu'), findsOneWidget);
  });*/

  //Ni puto caso a esta basura lo comentado tiene mas sentido
  testWidgets('Widget PublicationWidget muestra información correctamente', (WidgetTester tester) async {
    final tituloNota = 'Título de prueba';
    final mensaje = 'Mensaje de prueba';
    final usu = 'Usuario de prueba';

    final  List<String> U = [api.loggedUser.id];
    Note nota = Note(
      id: '',
      owner: api.loggedUser,
      date: DateTime.now(),
      publiType: PublicationType.note,
      title: 'Título de prueba',
      message: 'Mensaje de prueba',
      watchers: U,
    );

    await tester.pumpWidget(PublicationWidget(pub: nota));
    await tester.pump();

    // Verificar que el título de la nota y el nombre del usuario se muestran correctamente antes de tocar la nota
    expect(find.text(tituloNota), findsOneWidget);
    expect(find.text('De: $usu'), findsOneWidget);

    // Simular el toque en la nota
    await tester.tap(find.byType(PublicationWidget));
    await tester.pump(); // Esperar a que la aplicación se actualice después del toque
    print('Después del toque:');

    // Verificar que la pantalla de vista de la nota se muestra correctamente
    expect(find.text(tituloNota), findsOneWidget);
    print("tuki");
    expect(find.text(mensaje), findsOneWidget);
    print("tuki2");
    expect(find.text('De: $usu'), findsOneWidget);
  });

}
