import 'package:flutter/material.dart';
import 'package:nest_fronted/screens/pub_nota.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'tablon',
      routes: {'tablon': (_) => const PubNotaScreen()},
    );
  }
}
//iconos de flechas para retroceder o pasar a siguiente
class flechas extends StatelessWidget {
  const flechas({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(top: 25.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {},
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 25.0),
          child: IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

