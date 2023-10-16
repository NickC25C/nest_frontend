import 'package:flutter/material.dart';

class BarraTitulo extends StatelessWidget {
  final String titulo;
  const BarraTitulo({
    super.key,
    required this.titulo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(top: 40),
      color: Colors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            titulo,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
