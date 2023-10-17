import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class ApiService {
  final String baseUrl = 'http://tu_servidor/api';

  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Error al obtener usuarios');
    }
  }
}
