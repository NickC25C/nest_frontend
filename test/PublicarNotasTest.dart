import 'package:flutter_test/flutter_test.dart';
import 'package:nest_fronted/widgets/nota.dart';
import 'package:nest_fronted/widgets/publication_widget.dart';
import 'package:nest_fronted/models/publication.dart';
import 'package:nest_fronted/models/note.dart';
import 'package:nest_fronted/services/api_service.dart';
import 'package:nest_fronted/screens/tablon.dart';
import 'package:nest_fronted/models/user.dart';

ApiService api = ApiService();
TablonState a = TablonScreen().createState();

void main() {
  test('Inicialización de Nota', () {
    final tituloNota = 'Título de prueba';
    final mensaje = 'Mensaje de prueba';
    final username = 'Usuario de prueba';
    final Note noti = Note(
        id: '',
        owner: User(
            id: '',
            name: ' Usuario de prueba',
            lastname: 'lastname',
            username: username,
            password: 'password',
            mail: 'mail'),
        date: DateTime.now(),
        publiType: PublicationType.note,
        title: tituloNota,
        message: mensaje);
    final nota = Nota(
      nota: noti,
    );

    /*expect(nota.tituloNota, equals(tituloNota));
    expect(nota.mensaje, equals(mensaje));
    expect(nota.usu, equals(username));*/
  });

  testWidgets('Widget Nota muestra información correctamente en el tablón',
      (WidgetTester tester) async {
    final tituloNota = 'Título de prueba';
    final mensaje = 'Mensaje de prueba';
    final usu = 'Usuario de prueba';
    final Note nota = Note(
        id: '',
        owner: User(
            id: '',
            name: ' Usuario de prueba',
            lastname: 'lastname',
            username: usu,
            password: 'password',
            mail: 'mail'),
        date: DateTime.now(),
        publiType: PublicationType.note,
        title: tituloNota,
        message: mensaje);

    await tester.pumpWidget(Nota(
      nota: nota,
    ));
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
  });

  testWidgets(
      'Verificar que la nota se ve correctamente al abrirla en el tablón',
      (WidgetTester tester) async {
    // Mock de la nota para simular datos
    final note = Note(
        id: '',
        owner: User(
            id: '',
            name: '',
            lastname: '',
            username: 'Usuario de prueba',
            password: '',
            mail: ''),
        date: DateTime.now(),
        publiType: PublicationType.note,
        title: 'Título de la nota',
        message: 'Contenido de la nota',
        watchers: []);

    // Construye el widget
    await tester.pumpWidget(a.buildNoteViewContent(note));
    // Verifica que se muestre el título de la nota
    expect(find.text('Título de la nota'), findsOneWidget);

    // Verifica que se muestre el contenido de la nota
    expect(find.text('Contenido de la nota'), findsOneWidget);

    // Verifica que se muestre el nombre del propietario con la arroba delante
    expect(find.text('De: Usuario de prueba'), findsOneWidget);
    ;
  });
}
