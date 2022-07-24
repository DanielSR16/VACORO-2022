import 'dart:convert';

import 'package:http/http.dart' as http;

String ip = "192.168.100.15";
//poner otken
Future<List<Map<String, dynamic>>> getBecerrobyIdvaca(
    int id_vaca, String token) async {
  try {
    final response = await http.post(
        Uri.http("animales-vacoro-729421269.us-east-1.elb.amazonaws.com",
            "/becerro/getBecerrosbyIdvaca"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({'id_vaca': id_vaca}));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      List<Map<String, dynamic>> listBecerros = [];

      if (data != null) {
        for (Map calf in data) {
          Map<String, dynamic> mapListCalf = {
            'id': calf['id'],
            'nombre': calf['nombre'],
            'num_arete': calf['num_arete'],
          };
          listBecerros.add(mapListCalf);
        }
      }
      return listBecerros;
    } else {
      print(response.statusCode);
      return [
        {"status": "${response.statusCode}"},
        {"message": "No se puede conectar al servidor :("}
      ];
    }
  } catch (e) {
    // print(e);
    return [
      {"error": "Error: $e"}
    ];
  }
}
