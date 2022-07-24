import 'dart:convert';

import 'package:http/http.dart' as http;

String ip = "192.168.0.2";

Future getMedicationAll(id_usuario, token) async {
  print(id_usuario);
  String d = 'Bearer ' + token;
  print(d.runtimeType);
  try {
    final response = await http.post(
        Uri.http( "medicamentos-vacoro-1752549805.us-east-1.elb.amazonaws.com", "/medicamento/allMedicamentosbyUser"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer $token',
        },
        body: json.encode({"id_usuario": id_usuario}));

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

Future updateMedication(id, nombre, descripcion, cantidad, fecha_caducidad,
    id_usuario, token) async {
  String d = 'Bearer ' + token;

  try {
    final response = await http.post(
        Uri.http(ip + ":3004", "/medicamento/actualizarMedicamento"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer $token',
        },
        body: json.encode({
          "id": id,
          "nombre": nombre,
          "descripcion": descripcion,
          "cantidad": cantidad,
          "fecha_caducidad": fecha_caducidad,
          "id_usuario": id_usuario
        }));

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
