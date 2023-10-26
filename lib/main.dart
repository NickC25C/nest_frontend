import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nest_fronted/models/user.dart';
import 'package:nest_fronted/screens/busqueda.dart';
import 'package:nest_fronted/screens/pub_imagen.dart';
import 'package:nest_fronted/screens/pub_nota.dart';
import 'package:nest_fronted/screens/crear_grupos.dart';
import 'package:nest_fronted/screens/tablon.dart';
import 'package:nest_fronted/screens/amis_grup.dart';
import 'package:nest_fronted/screens/configuracion.dart';
import 'package:nest_fronted/services/api_service.dart';

List<User> usuarios = List.empty();
ApiService api = ApiService();
void main() {
  api.getUsers().then((data) {
    usuarios = data;
  });
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      routes: {
        'tablon': (_) => const TablonScreen(),
        'pub_notas': (_) => const PubNotaScreen(),
        'pub_imagen': (_) => const PubImagenScreen(),
        'crea_grupo': (_) => const CrearGrupos(),
        'amis_grup': (_) => const AmisGrupScreen(),
        'configuracion': (_) => const ConfiguracionScreen(),
      },
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0; // índice actual

  // Listado de screens o widgets
  final List<Widget> _children = [
    Center(child: TablonScreen()),
    Center(child: BusquedaScreen()),
    Center(child: AmisGrupScreen()),
    Center(child: ConfiguracionScreen()),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: _children[_currentIndex], // Mostramos el widget según el índice
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              activeIcon: Icon(Icons.home_filled),
              label: 'Home',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              activeIcon: Icon(Icons.saved_search),
              label: 'Search',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              activeIcon: Icon(Icons.group_add),
              label: 'Friends',
              backgroundColor: Colors.deepPurpleAccent,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              activeIcon: Icon(Icons.settings_applications),
              label: 'Settings',
              backgroundColor: Colors.teal,
            ),
          ]),
    );
  }
}
