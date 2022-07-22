import 'dart:convert';
import 'package:http/http.dart' as http;

String host = '192.168.89.48:3001';

Future<Map<String, dynamic>> serviceanadirbecerro(
  String token,
  int id_usuario,
  String nombre,
  String descripcion,
  String raza,
  String num_arete,
  String url_img,
  int estado,
  int edad,
  int id_vaca,
  String fecha_llegada,
) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  String animalAPI = '/becerro/new/';
  try {
    final response = await http.post(
      Uri.http(host, animalAPI),
      headers: headers,
      body: json.encode(
        {
          'id_usuario': id_usuario,
          'nombre': nombre,
          'descripcion': descripcion,
          'raza': raza,
          'num_arete': num_arete,
          'url_img': url_img,
          'estado': estado,
          'edad': edad,
          'id_vaca': id_vaca,
          'fecha_llegada': fecha_llegada
        },
      ),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      Map<String, dynamic> responseMap = {
        'status': data['status'],
      };
      return responseMap;
      //return 'ok';
    } else {
      return {'status': 'Error'};
    }
  } catch (e) {
    return {'status': 'Error al conectarse con el servidor'};
  }
}
