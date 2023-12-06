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
      width: double.infinity,
      margin: const EdgeInsets.only(top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              shape: CircleBorder(),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            child: Icon(Icons.arrow_circle_left, size: 30, color: Colors.black),
          ),
          Text(
            titulo,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_circle_right, size: 30),
          ),
        ],
      ),
    );
  }
}
