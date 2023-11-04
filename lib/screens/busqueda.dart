import 'package:flutter/material.dart';

const tituloScreen = 'BÚSQUEDA';

class BusquedaScreen extends StatelessWidget {
  const BusquedaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FormBusqueda()
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
              decoration: const InputDecoration(
                  hintText: 'Nombre de usuario',
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.all(Radius.circular(30.0))
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(30.0))
                  ),
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
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 50.0,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )
                ),
                onPressed: _isButtonDisabled ? null : () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState!.validate()) {
                    // Process data.
                  }
                },
                child: const Text(
                  'Enviar solicitud',
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
