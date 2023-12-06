import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nest_fronted/models/capsule.dart';
import 'package:nest_fronted/screens/capsulaAbierta.dart';
import 'package:nest_fronted/screens/capsulaCerrada.dart';
import 'package:nest_fronted/widgets/MostrarCapsulaAbierta.dart';
import 'package:nest_fronted/widgets/MostrarCapsulaCerrada.dart';

void main() {
  testWidgets('CapsulaCerrada se muestra correctamente y se muestra correctamente la ventana de la capsula Cerrada',
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
}