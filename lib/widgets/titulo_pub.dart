import 'package:flutter/material.dart';

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
          decoration: InputDecoration(
            labelText : 'Titulo',
            border: UnderlineInputBorder(),
            hintText: 'La Rata Ladrona',
          ),
        ),
      ),
    );
  }
}