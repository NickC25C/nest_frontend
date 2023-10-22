import 'package:flutter/material.dart';
import 'package:nest_fronted/widgets/barra_titulo.dart';

const tituloScreen = 'BÚSQUEDA';

class BusquedaScreen extends StatelessWidget {
  const BusquedaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [BarraTitulo(titulo: tituloScreen), FormBusqueda()],
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
              decoration: const InputDecoration(
                  hintText: 'Nombre de usuario',
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2)),
                  labelStyle: TextStyle(color: Colors.green)),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'El usuario introducido no existe';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState!.validate()) {
                    // Process data.
                  }
                },
                child: const Text(
                  'Enviar Solicitud',
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
