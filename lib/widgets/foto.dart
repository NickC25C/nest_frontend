import 'package:flutter/material.dart';
import 'package:nest_fronted/main.dart';

class Foto extends StatefulWidget {
  final String url;
  const Foto({
    super.key,
    required this.url,
  });
  @override
  State<Foto> createState() => _FotoState();
}

class _FotoState extends State<Foto> {
  late final String fotoUrl;

  void initState() {
    super.initState();
    fotoUrl = widget.url;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: actual.colorScheme.secondary),
        ),
        height: 300,
        width: 300,
        child: Image(
          image: AssetImage(fotoUrl),
          fit: BoxFit.cover,
        ));
  }
}
