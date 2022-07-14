import 'dart:convert';
import 'package:http/http.dart' as http;

String ip = '192.168.56.1';
Future<String> register_user(
    String name,
    String apellidos,
    String correoElectronico,
    String contrasenia,
    String estado,
    String ciudad,
    int edad,
    String nombreRancho,
    String urlImage) async {
  try {
    print('/////////////////////////////////////////');
    print(nombreRancho);

    final response = await http.post(
      Uri.http(ip + ':3000', '/usuario/usuarioNuevo'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: json.encode(
        {
          "nombre": name,
          "apellido": apellidos,
          "correo_electronico": correoElectronico,
          "contrasenia": contrasenia,
          "ciudad": ciudad,
          "estado": estado,
          "edad": edad,
          "nombre_rancho": nombreRancho,
          "url_image": urlImage
        },
      ),
    );
    print(response.body);
    if (response.statusCode == 200) {
      // final data = json.decode(response.body);
      var data = response.body;
      print(data);
      if (data == 'Usuario Existente') {
        return 'El usuario ya existe';
      } else {
        return data;
      }
    } else {
      return 'No se ha podido conectar al servidor';
    }
  } catch (e) {
    return 'Error';
  }
}

Future estados_all() async {
  try {
    final response = await http.get(
      Uri.http(ip + ':3002', '/estado/all'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );

    if (response.statusCode == 200) {
      var data = response.body;
      if (data == 'Usuario Existente') {
        return 'El usuario ya existe';
      } else {
        return data;
      }
    } else {
      return 'No se ha podido conectar al servidor';
    }
  } catch (e) {
    return 'Error';
  }
}

Future municipios_id(int id) async {
  try {
    final response = await http.post(
        Uri.http(ip + ':3002', '/municipio/municipioEstado'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode({"id": id}));
    print(response.statusCode);
    if (response.statusCode == 200) {
      var data = response.body;
      if (data == 'Usuario Existente') {
        return 'El usuario ya existe';
      } else {
        return data;
      }
    } else {
      return 'No se ha podido conectar al servidor';
    }
  } catch (e) {
    print(e);
    return 'Error';
  }
}
