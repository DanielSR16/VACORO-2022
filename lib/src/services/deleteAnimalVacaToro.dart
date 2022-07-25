import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> servicedeletevacatoro(
  String token,
  String tipoAnimal,
  int id,
) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  String host = '192.168.100.15:3001';
  String loginAPI;
  if (tipoAnimal == "Vaca") {
    loginAPI = '/vaca/delete/';
  } else {
    loginAPI = '/toro/delete/';
  }

  try {
    final response = await http.post(
      Uri.http(host, loginAPI),
      headers: headers,
      body: json.encode({'id': id}),
    );

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
