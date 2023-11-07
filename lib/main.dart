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
import 'package:nest_fronted/themes/temasClaros.dart';
import 'package:nest_fronted/screens/crear_capsula.dart';

List<User> usuarios = List.empty();
ApiService api = ApiService();
ThemeData actual = matcha;
void main() {
  //Poblar la base de datos con usuarios nuevos
  void poblarUsers() {
    User newUser = User(
        id: "",
        name: "Guillem",
        lastname: "Fornet",
        username: "g4net",
        password: "pass123",
        mail: "g@g.com",
        enableNotifications: true);
    User newUser1 = User(
        id: "",
        name: "Nick",
        lastname: "Contreras",
        username: "El_nicoloau",
        password: "123",
        mail: "ahhrh@hmail.com",
        enableNotifications: true);
    User newUser2 = User(
        id: "",
        name: "Javier",
        lastname: "Lanza",
        username: "Reshulon21",
        password: "123",
        mail: "ahhsh@hmail.com",
        enableNotifications: true);
    api.createUser(newUser).whenComplete(() =>
        api.createUser(newUser1).whenComplete(() => api.createUser(newUser2)));
  }

  //poblarUsers();
  api.getUsers().then((data) {
    usuarios = data;
  }).whenComplete(() => {
        api
            .getUserByUsername('g4net')
            .then((value) => api.loggedUser = value)
            .whenComplete(() => null),
        WidgetsFlutterBinding.ensureInitialized(),
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]),
        runApp(const MyApp()),
      });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: actual,
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
      home: CrearCapsula(),//MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0; // índice actual
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Listado de screens o widgets
  final List<Widget> _children = [
    Center(child: TablonScreen()),
    Center(child: BusquedaScreen()),
    Center(child: AmisGrupScreen()),
    Center(child: ConfiguracionScreen()),
  ];

  final List<String> _nombresitos = [
    'MI TABLÓN PERSONAL',
    'BÚSQUEDA',
    'GRUPETES',
    'CONFIGURACIÓN',
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void openDrawer(){
    print('abrir drawer');
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Nombre de usuario'),
              accountEmail: Text('usuario@gmail.com'),
              currentAccountPicture: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: actual.colorScheme.onPrimary,
                      width: 2.0,
                    )
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('assets/images/PAJAROTOS.png'),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('inicio'),
              onTap: () {
//Acción chavalin
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configuración'),
              onTap: () {
//Otra acción chavalines
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          _nombresitos[_currentIndex],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
          onTap: openDrawer,
          child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 18,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: actual.colorScheme.onPrimary,
                      width: 2.0,
                    )
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/PAJAROTOS.png',
                    width: 40, // Ancho deseado de la imagen
                    height: 40, // Alto deseado de la imagen
                    fit: BoxFit.cover, // Puedes ajustar el ajuste de la imagen según tus necesidades
                  ),
                ),
              ),
            ),
          ),
        ),
      body: SingleChildScrollView(
        child: _children[_currentIndex], // Mostramos el widget según el índice
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          elevation: 0,
          selectedItemColor: actual.colorScheme.onPrimary,
          unselectedItemColor: actual.colorScheme.onPrimary,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              activeIcon: Icon(Icons.home_filled),
              label: 'Home',
              backgroundColor: actual.colorScheme.primary,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              activeIcon: Icon(Icons.saved_search),
              label: 'Search',
              backgroundColor: actual.colorScheme.primary,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              activeIcon: Icon(Icons.group_add),
              label: 'Friends',
              backgroundColor: actual.colorScheme.primary,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              activeIcon: Icon(Icons.settings_applications),
              label: 'Settings',
              backgroundColor: actual.colorScheme.primary,
            ),
          ]),
    );
  }
}
