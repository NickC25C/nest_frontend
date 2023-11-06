import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nest_fronted/main.dart';

class BarraPublicar extends StatelessWidget {
  final String titulo;
  const BarraPublicar({
    super.key,
    required this.titulo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 40),
      color: actual.colorScheme.surface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_circle_left, size: 30),
          ),
          Text(
            titulo,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: actual.colorScheme.onSurface),
          ),
          SizedBox(
            width: 50,
          )
        ],
      ),
    );
  }
}
