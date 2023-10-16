import 'package:flutter/material.dart';

class Foto extends StatelessWidget {
  final String url;
  const Foto({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 250,
      width: 200,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/foto.png'),
              alignment: Alignment.center,
              fit: BoxFit.contain)),
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          height: 150,
          width: 150,
          child: Image(
            image: AssetImage(url),
            fit: BoxFit.cover,
          )),
    );
  }
}
