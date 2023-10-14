import 'package:flutter/material.dart';

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
      width: 370,
      margin: const EdgeInsets.only(top: 40),
      color: Colors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_circle_left, color: Colors.white, size: 30),
          ),
          Text(
            titulo,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_circle_right, color: Colors.white, size: 30),
          ),
        ],
      ),
    );
  }
}