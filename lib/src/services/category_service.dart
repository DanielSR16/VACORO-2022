import 'dart:convert';

import 'package:http/http.dart' as http;

String ip = "192.168.100.15";

Future getCategoryAll() async {
  print('hola estoy obteniendo categorias xd');
  try {
    final response = await http.get(
      Uri.http(ip + ":3006", "/categoria/allCategorias"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);

      return data;
    } else {
      return "No se pudo conectar al servidor :(\n Codigo de error: ${response.statusCode}";
    }
  } catch (e) {
    return "Error: $e";
  }
}
