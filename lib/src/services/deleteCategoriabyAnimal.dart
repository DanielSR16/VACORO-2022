import 'dart:convert';
import 'package:http/http.dart' as http;

String host = '192.168.100.15:3006';

Future<Map<String, dynamic>> servicedeletecategoriavacatoro(
  String token,
  String tipoAnimal,
  int id,
) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  String loginAPI;
  if (tipoAnimal == "Vaca") {
    loginAPI = '/categoria/deleteVacaByCategory/';
  } else {
    loginAPI = '/categoria/deleteToroByCategory/';
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

Future<Map<String, dynamic>> servicedeletecategoriabecerro(
  int id,
  String token,
) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  String loginAPI = '/categoria/deleteBecerroByCategory/';

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
