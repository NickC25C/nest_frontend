import 'package:flutter/material.dart';

String texto = '';

class Titulo extends StatelessWidget {
  const Titulo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        width: double.infinity,
        child: TextField(
          onChanged: (value) => {texto = value},
          decoration: InputDecoration(
            labelText: 'Titulo',
            border: UnderlineInputBorder(),
            hintText: 'La Rata Ladrona',
          ),
        ),
      ),
    );
  }

  String darValor() {
    return texto;
  }
}
