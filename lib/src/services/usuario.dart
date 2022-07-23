import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String host = '192.168.89.48:3000';
// String host = 'user-vacoro-1804981318.us-east-1.elb.amazonaws.com';

Future<Map<String, dynamic>> serviceusuario(int id_usuario) async {
  Map<String, String> headers = {'Content-Type': 'application/json'};
  String usuarioAPI = '/usuario/getUserbyId/';

  try {
    final response = await http.post(
      Uri.http(host, usuarioAPI),
      headers: headers,
      body: json.encode(
        {'id': id_usuario},
      ),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      Map<String, dynamic> responseMap = {
        'id': data['id'],
        'nombre': data['nombre'],
        'apellido': data['apellido'],
        'correo_electronico': data['correo_electronico'],
        'contrasenia': data['contrasenia'],
        'estado': data['estado'],
        'ciudad': data['ciudad'],
        'edad': data['edad'],
        'nombre_rancho': data['nombre_rancho'],
        'url_image': data['url_image'],
      };

      return responseMap;
    } else {
      return {'status': 'Error'};
    }
  } catch (e) {
    return {'status': 'Error al conectarse con el servidor'};
  }
}

Future<Map<String, dynamic>> serviceeditarusuario(
  int id_usuario,
  String name,
  String apellidos,
  String correo,
  String contrasenia,
  String estado,
  String ciudad,
  int edad,
  String nombreRancho,
  String urlImage,
) async {
  Map<String, String> headers = {'Content-Type': 'application/json'};

  String usuarioAPI = '/usuario/actualizarUsuario/';

  try {
    final response = await http.post(
      Uri.http(host, usuarioAPI),
      headers: headers,
      body: json.encode(
        {
          'id': id_usuario,
          "nombre": name,
          "apellido": apellidos,
          "correo_electronico": correo,
          "contrasenia": contrasenia,
          "ciudad": ciudad,
          "estado": estado,
          "edad": edad,
          "nombre_rancho": nombreRancho,
          "url_image": urlImage
        },
      ),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      Map<String, dynamic> responseMap = {
        'status': data['status'],
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

Future<Map<String, dynamic>> serviceUserPassword(
    int id_usuario, String contrasenaNueva) async {
  Map<String, String> headers = {'Content-Type': 'application/json'};
  String loginAPI = '/usuario/getUserPasswordbyId/';

  try {
    final response = await http.post(
      Uri.http(host, loginAPI),
      headers: headers,
      body: json.encode(
        {'id': id_usuario, 'contrasenia': contrasenaNueva},
      ),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      Map<String, dynamic> responseMap = {
        'status': data['status'],
      };

      return responseMap;
    } else {
      return {'status': 'Error'};
    }
  } catch (e) {
    return {'status': 'Error al conectarse con el servidor'};
  }
}

Future<Map<String, dynamic>> serviceeditarPassword(
    Map<String, dynamic> usuario, String contrasenia) async {
  Map<String, String> headers = {'Content-Type': 'application/json'};

  String usuarioAPI = '/usuario/actualizarUsuarioPassword/';

  try {
    final response = await http.post(
      Uri.http(host, usuarioAPI),
      headers: headers,
      body: json.encode(
        {
          'id': usuario['id'],
          "nombre": usuario['nombre'],
          "apellido": usuario['apellido'],
          "correo_electronico": usuario['correo_electronico'],
          "contrasenia": contrasenia,
          "ciudad": usuario['ciudad'],
          "estado": usuario['estado'],
          "edad": usuario['edad'],
          "nombre_rancho": usuario['nombre_rancho'],
          "url_image": usuario['url_image'],
        },
      ),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      Map<String, dynamic> responseMap = {
        'status': data['status'],
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
