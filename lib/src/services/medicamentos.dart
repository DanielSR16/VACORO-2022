import 'dart:convert';
import 'package:http/http.dart' as http;

String ip = '192.168.100.15';
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
      Uri.http('medicamentos-vacoro-1752549805.us-east-1.elb.amazonaws.com', '/medicamento/newMedicamento'),
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
