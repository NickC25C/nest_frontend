import 'package:flutter/material.dart';

class FechaApertura extends StatefulWidget {
  final String texto;
  const FechaApertura({Key? key, required this.texto}) : super(key: key);

  @override
  _FechaAperturaState createState() => _FechaAperturaState();
}

class _FechaAperturaState extends State<FechaApertura> {
  late DateTime _selectedDate;
  late final String texto;
  @override
  void initState() {
    super.initState();
    // Inicializa la fecha seleccionada con la fecha actual
    _selectedDate = DateTime.now();
    texto = widget.texto;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(texto),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: () => _selectDate(context),
          child: Row(
            children: [
              Text(
                '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
              ),
              SizedBox(width: 5),
              Icon(Icons.date_range), // Añade el icono de calendario
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        // Puedes realizar acciones adicionales con la fecha seleccionada si lo deseas
      });
    }
  }
}
