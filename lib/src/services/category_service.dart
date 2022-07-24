import 'dart:convert';

import 'package:http/http.dart' as http;

Future getCategoryAll() async {
  print('hola estoy obteniendo categorias xd');
  try {
    final response = await http.get(
      Uri.http("categorias-vacoro-1164392975.us-east-1.elb.amazonaws.com",
          "/categoria/allCategorias"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('datasssssssssssssss');
      print(data);

      return data;
    } else {
      return "No se pudo conectar al servidor :(\n Codigo de error: ${response.statusCode}";
    }
  } catch (e) {
    return "Error: $e";
  }
}
