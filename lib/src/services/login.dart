import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> servicelogin(
    TextEditingController email, TextEditingController password) async {
  Map<String, String> headers = {'Content-Type': 'application/json'};
  String loginAPI = '/usuario/getUserlogin/';
  String host = '192.168.0.6:3000';

  try {
    final response = await http.post(
      Uri.http(host, loginAPI),
      headers: headers,
      body: json.encode(
        {'correo_electronico': email.text, 'contrasenia': password.text},
      ),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      Map<String, dynamic> responseMap = {
        'id': data['id'],
        'nombre': data['nombre'],
        'correo_electronico': data['correo_electronico'],
      };
      return responseMap;
    } else {
      return {'status': 'Error'};
    }
  } catch (e) {
    print("Error al conectarse con el servidor");
    return {'status': 'Error al conectarse con el servidor'};
  }
}
