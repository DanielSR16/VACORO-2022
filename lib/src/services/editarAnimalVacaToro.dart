import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> serviceeditarvacatoro(
    int id_usuario,
    String tipoAnimal,
    int id,
    String nombre,
    String descripcion,
    String raza,
    String num_arete,
    String url_img,
    int estado,
    int edad,
    String fecha_llegada,
    String token) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  String host = '192.168.0.10:3001';
  String loginAPI;
  if (tipoAnimal == "Vaca") {
    loginAPI = '/vaca/update/';
  } else {
    loginAPI = '/toro/update/';
  }

  try {
    final response = await http.post(
      Uri.http(host, loginAPI),
      headers: headers,
      body: json.encode(
        {
          'id': id,
          'id_usuario': id_usuario,
          'nombre': nombre,
          'descripcion': descripcion,
          'raza': raza,
          'num_arete': num_arete,
          'url_img': url_img,
          'estado': estado,
          'edad': edad,
          'fecha_llegada': fecha_llegada
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
      // return responseMap;
      //return data;
      return responseMap;
    } else {
      return {'status': 'Error'};
    }
  } catch (e) {
    return {'status': 'Error al conectarse con el servidor'};
  }
}
