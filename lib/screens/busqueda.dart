import 'package:flutter/material.dart';
import 'package:nest_fronted/main.dart';
import 'package:nest_fronted/models/user.dart';

const tituloScreen = 'BÚSQUEDA';

class BusquedaScreen extends StatelessWidget {
  const BusquedaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FormBusqueda(),
          Solicitudes(),
        ],
      ),
    );
  }
}

class FormBusqueda extends StatefulWidget {
  const FormBusqueda({super.key});

  @override
  State<FormBusqueda> createState() => _FormBusquedaState();
}

class _FormBusquedaState extends State<FormBusqueda> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  bool _isButtonDisabled = true;

  //deshabilitará al boton cuando no haya nada puesto
  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      if (_controller.text.isEmpty && !_isButtonDisabled) {
        setState(() {
          _isButtonDisabled = true;
        });
      } else if (_controller.text.isNotEmpty && _isButtonDisabled) {
        setState(() {
          _isButtonDisabled = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                  hintText: 'Nombre de usuario',
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: actual.colorScheme.secondary),
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: actual.colorScheme.secondary, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  labelStyle: TextStyle(color: actual.colorScheme.secondary)),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'El usuario introducido no existe';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 50.0,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: actual.colorScheme.secondary,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )),
                onPressed: _isButtonDisabled
                    ? null
                    : () async {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        User u = await api.getUserByUsername(_controller.text);
                        if (u.id == '') {
                          await api.postRequest(api.loggedUser.id, u.id);
                        } else {}
                      },
                child: Text(
                  'Enviar solicitud',
                  style: TextStyle(color: actual.colorScheme.onSecondary),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Solicitudes extends StatefulWidget {
  @override
  _Solicitudes createState() => _Solicitudes();
}

//Aceptar o denegar solicitudes
class _Solicitudes extends State<Solicitudes> {
  late List<User> listaU = List.empty(growable: true);
  late List<String> listaAuxiliar = List.empty(growable: true);

  Future<void> extractUsers() async {
    try {
      List<User> users = await api.getRequests(api.loggedUser.id);
      setState(() {
        listaU = users;
        listaAuxiliar = users.map((user) => user.username).toList();
      });
    } catch (e) {
      // Manejar el error de la solicitud
      print('Error en la solicitud: $e');
    }
  }

  void _removeItem(int index) {
    setState(() {
      listaAuxiliar.removeAt(index);
    });
  }

  @override
  void initState() {
    extractUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Text(
            'Solicitudes:',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            height: 380.0,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: actual.colorScheme.secondary),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Scrollbar(
              child: CustomListView(
                items: listaAuxiliar,
                onItemRemoved: _removeItem,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomListView extends StatelessWidget {
  final List<String> items;
  final Function(int) onItemRemoved;

  CustomListView({required this.items, required this.onItemRemoved});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 0.0),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(items[index]),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  onItemRemoved(index);
                },
                child: Icon(
                  Icons.check,
                  color: actual.colorScheme.secondary,
                ),
                style: ElevatedButton.styleFrom(
                    side: BorderSide(
                      width: 1,
                      color: actual.colorScheme.secondary,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0))),
              ),
              SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: () {
                  onItemRemoved(index);
                },
                child: Icon(
                  Icons.close,
                  color: actual.colorScheme.secondary,
                ),
                style: ElevatedButton.styleFrom(
                    side: BorderSide(
                      color: actual.colorScheme.secondary,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0))),
              ),
            ],
          ),
        );
      },
    );
  }
}
