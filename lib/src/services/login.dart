import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> servicelogin(
    TextEditingController email, TextEditingController password) async {
  Map<String, String> headers = {'Content-Type': 'application/json'};
  String loginAPI = '/usuario/getUserlogin';
  String host = '192.168.0.2:3000';
  //String host = 'user-vacoro-1804981318.us-east-1.elb.amazonaws.com';

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
      Map<String, dynamic> responseMap = {
        'token': data['token'],
        'id': data['usuario']['id'],
        'nombre': data['usuario']['nombre'],
        'correo_electronico': data['usuario']['correo_electronico'],
      };
      print(responseMap);
      return responseMap;
    } else {
      return {'status': 'Error'};
    }
  } catch (e) {
    return {'status': 'Error al conectarse con el servidor'};
  }
}
