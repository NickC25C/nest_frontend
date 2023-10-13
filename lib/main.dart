import 'package:flutter/material.dart';
import 'package:nest_fronted/screens/tablon.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'tablon',
      routes: {'tablon': (_) => TablonScreen()},
    );
  }
}
