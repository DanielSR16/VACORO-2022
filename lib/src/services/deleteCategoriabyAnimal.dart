import 'dart:convert';
import 'package:http/http.dart' as http;

String host = '192.168.0.10:3006';

Future<Map<String, dynamic>> servicedeletevacatoro_categoria(
  String tipoAnimal,
  int id,
) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  String loginAPI;
  if (tipoAnimal == "Vaca") {
    loginAPI = '/categoria/deleteVacaByIdVaca/';
  } else {
    loginAPI = '/categoria/deleteToroByIdToro/';
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

Future<Map<String, dynamic>> servicedeletebecerro_categoria(
  int id,
) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  String loginAPI = '/categoria/deleteBecerroByIdBecerro/';

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
