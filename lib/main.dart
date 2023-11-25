import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nest_fronted/models/user.dart';
import 'package:nest_fronted/screens/busqueda.dart';
import 'package:nest_fronted/models/letter.dart';
import 'package:nest_fronted/screens/capsulaCerrada.dart';
import 'package:nest_fronted/screens/enviar_carta.dart';
import 'package:nest_fronted/screens/pub_imagen.dart';
import 'package:nest_fronted/screens/pub_nota.dart';
import 'package:nest_fronted/screens/crear_grupos.dart';
import 'package:nest_fronted/screens/tablon.dart';
import 'package:nest_fronted/screens/amis_grup.dart';
import 'package:nest_fronted/screens/configuracion.dart';
import 'package:nest_fronted/screens/capsulas.dart';
import 'package:nest_fronted/screens/correo.dart';
import 'package:nest_fronted/services/api_service.dart';
import 'package:nest_fronted/themes/temasClaros.dart';
import 'package:page_transition/page_transition.dart';

List<User> usuarios = List.empty();
ApiService api = ApiService();
ThemeData actual = matcha;
void main() {
  //Poblar la base de datos con usuarios nuevos
  void enviarSolicitudAmistad() async {
    User usuarioActual = await api.getUserByUsername('El_nicoloau');
    User usuarioDestino = await api.getUserByUsername('g4net');

    try {
      await api.postRequest(usuarioActual.id, usuarioDestino.id);
      print('Solicitud de amistad enviada exitosamente.');
    } catch (e) {
      print('Error al enviar la solicitud de amistad: $e');
    }
  }

  void tuPropioAmigo(User u1, User u2) async {
    await api.addFriend(u1.id, u2.id);
  }

  void crearCarta() {
    Letter cartita = Letter(
      id: "",
      title: "saludo",
      text: "seko boy",
      date: "2002-12-12",
      originUserId: api.loggedUser.id,
      receiverUserId: api.loggedUser.id,
      opened: true,
    );
    print('adios');
    api.createLetter(cartita);
  }

  void poblarUsers() {
    User newUser = User(
      id: "",
      name: "Guillemon",
      lastname: "Fornet",
      username: "g4net",
      password: "pass123",
      mail: "g@g.com",
    );
    User newUser1 = User(
      id: "",
      name: "Nick",
      lastname: "Contreras",
      username: "El_nicoloau",
      password: "123",
      mail: "ahhrh@hmail.com",
    );
    User newUser2 = User(
      id: "",
      name: "Javier",
      lastname: "Lanza",
      username: "Reshulon21",
      password: "123",
      mail: "ahhsh@hmail.com",
    );
    print('hola');
    api.createUser(newUser).whenComplete(() =>
        api.createUser(newUser1).whenComplete(() => api.createUser(newUser2)));
  }

  //poblarUsers();

  // enviarSolicitudAmistad();

  api.getUsers().then((data) {
    usuarios = data;
  }).whenComplete(
    () => api
        .getUserByUsername('g4net')
        .then((value) => api.loggedUser = value)
        .whenComplete(() => {
              tuPropioAmigo(api.loggedUser, api.loggedUser),
              WidgetsFlutterBinding.ensureInitialized(),
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
                DeviceOrientation.portraitDown,
              ]),
              //crearCarta(),
              runApp(const MyApp())
            }),
  );
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
        'correo': (_) => CorreoScreen(),
        'capsulas': (_) => const CapsulaScreen(),
        'enviar_correo': (_) => const EnviarCartaScreen(),
        'capsulaAbierta': (_) => const CapsulaAbierta(),
        'capsulaCerrada': (_) => const CapsulaCerradaScreen(),
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Listado de screens o widgets
  final List<Widget> _children = [
    Center(child: TablonScreen()),
    Center(child: BusquedaScreen()),
    Center(child: CorreoScreen()),
    Center(child: CapsulaScreen()),
  ];

  final List<String> _nombresitos = [
    'MI TABLÓN PERSONAL',
    'BÚSQUEDA',
    'CORREO',
    'CÁPSULAS',
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void openDrawer() {
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
              accountName: Text(api.loggedUser.name),
              accountEmail: Text(api.loggedUser.username),
              currentAccountPicture: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: actual.colorScheme.onPrimary,
                      width: 2.0,
                    )),
                child: CircleAvatar(
                  backgroundColor: actual.colorScheme.surface,
                  backgroundImage: AssetImage('assets/images/PAJAROTOS.png'),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text('Amistades y Grupos'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  PageTransition(
                    child: AmisGrupScreen(),
                    type: PageTransitionType.fade,
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configuración'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  PageTransition(
                    child: ConfiguracionScreen(),
                    type: PageTransitionType.fade,
                  ),
                );
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
                  color: actual.colorScheme.surface,
                  border: Border.all(
                    color: actual.colorScheme.onPrimary,
                    width: 2.0,
                  )),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/PAJAROTOS.png',
                  width: 40, // Ancho deseado de la imagen
                  height: 40, // Alto deseado de la imagen
                  fit: BoxFit
                      .cover, // Puedes ajustar el ajuste de la imagen según tus necesidades
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
              icon: Icon(Icons.email_outlined),
              activeIcon: Icon(Icons.email_rounded),
              label: 'Mail',
              backgroundColor: actual.colorScheme.primary,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.hourglass_top),
              activeIcon: Icon(Icons.hourglass_bottom),
              label: 'Capsule',
              backgroundColor: actual.colorScheme.primary,
            ),
          ]),
    );
  }
}
