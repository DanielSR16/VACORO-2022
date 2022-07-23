import 'dart:convert';
import 'package:http/http.dart' as http;

String ip = '192.168.89.48';
Future<dynamic> registerMedicina(
  token,
  int idUsuario,
  String nombre,
  String descripcion,
  int cantidad,
  String fecha,
) async {
  try {
    final response = await http.post(
      Uri.http(ip + ':3004', '/medicamento/newMedicamento'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        "authorization": 'Bearer $token'
      },
      body: json.encode(
        {
          "id_usuario": idUsuario,
          "nombre": nombre,
          "descripcion": descripcion,
          "cantidad": cantidad,
          "fecha_caducidad": fecha
        },
      ),
    );
    print(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // var data = response.body;
      print(data);

      return data;
    } else {
      return 'No se ha podido conectar al servidor';
    }
  } catch (e) {
    return 'Error';
  }
}
