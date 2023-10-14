import 'package:flutter/material.dart';

class BotonCircular extends StatelessWidget {
  final Icon iconoBoton;
  const BotonCircular({
    super.key,
    required this.iconoBoton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      margin: const EdgeInsets.only(right: 20, top: 10),
      child: Ink(
        decoration: const ShapeDecoration(
          color: Colors.lightBlue,
          shape: CircleBorder(),
        ),
        child: IconButton(
          onPressed: () {},
          icon: iconoBoton,
          color: Colors.white,
        ),
      ),
    );
  }
}
