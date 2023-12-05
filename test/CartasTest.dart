import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nest_fronted/models/letter.dart';
import 'package:nest_fronted/models/user.dart';
import 'package:nest_fronted/screens/cartica.dart';
import 'package:nest_fronted/widgets/CartasAbiertas.dart';
import 'package:nest_fronted/widgets/CartasCerradas.dart';


void main() {
  // Se muestran correctamente las cartas Abiertas
  testWidgets('CartasAbiertas se muestra correctamente', (WidgetTester tester) async {

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CartasAbiertas(
            carta: Letter(
              id: '',
              title: 'Título de prueba',
              text: 'Texto de prueba',
              originUserId: '1',
              date: '',
              opened: false,
              receiverUserId: '0',
            ), usuarios: [User(id: '1', name: 'name', lastname: 'lastname', username: 'username', password: 'password', mail: 'mail')],
          ),
        ),
      ),
    );

    expect(find.byType(CartasAbiertas), findsOneWidget);
    expect(find.text('Título de prueba'), findsOneWidget);
    expect(find.text('username'), findsOneWidget);

  });

  // Comprobamos que se vea bien la información cuando le demos click a una carta
  testWidgets('CartaScreen se muestra correctamente', (WidgetTester tester) async {
    // Crea un mock de la lista de usuarios
    Letter letter = Letter(
      id: '',
      title: 'Título de prueba',
      text: 'Texto de prueba',
      originUserId: '1',
      date: '',
      opened: true,
      receiverUserId: '0',
    );
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CartaScreen(
          tituloCarta: letter.title,
          mensaje: letter.text,
          usuario: letter.originUserId,
          ),
        ),
      ),
    );

    expect(find.byType(CartaScreen), findsOneWidget);
    expect(find.text('Título de prueba'), findsOneWidget);
    expect(find.text('Texto de prueba'), findsOneWidget);
    expect(find.text('De: 1'), findsOneWidget);

  });

  // Se muestran correctamente las cartas Abiertas
  testWidgets('CartasCerradas se muestra correctamente', (WidgetTester tester) async {
    // Crea un mock de la lista de usuarios

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CartasCerradas(
            carta: Letter(
              id: '',
              title: 'Título de prueba',
              text: 'Texto de prueba',
              originUserId: '1',
              date: '',
              opened: false,
              receiverUserId: '0',
            ),
            usuarios: [User(id: '1', name: 'name', lastname: 'lastname', username: 'username', password: 'password', mail: 'mail')],
          ),
        ),
      ),
    );

    expect(find.byType(CartasCerradas), findsOneWidget);
    expect(find.text('Título de prueba'), findsOneWidget);
    expect(find.text('username'), findsOneWidget);

  });
}