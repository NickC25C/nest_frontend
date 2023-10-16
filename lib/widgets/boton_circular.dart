import 'package:flutter/material.dart';

class BotonCircular extends StatelessWidget {
  final Icon iconoBoton;
  final Function() click;
  const BotonCircular({
    super.key,
    required this.iconoBoton,
    required this.click,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const ShapeDecoration(
        color: Colors.lightBlue,
        shape: CircleBorder(),
      ),
      child: IconButton(
        onPressed: click,
        icon: iconoBoton,
        color: Colors.white,
      ),
    );
  }
}
