import 'dart:convert';

import 'package:http/http.dart' as http;

String ip = "192.168.0.31";

Future getMedicationAll() async {
  try {
    final response = await http.get(
      Uri.http(ip + ":3004", "/medicamento/allMedicamentos"),
      headers: {"Content-Type": "application/json; charset=UTF-8"},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return data;
    } else {
      return "No se pudo conectar al servidor :(\n Codigo de error: ${response.statusCode}";
    }
  } catch (e) {
    return "Error: $e";
  }
}
