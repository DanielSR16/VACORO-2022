import 'dart:convert';
import 'package:http/http.dart' as http;

String ip = '192.168.0.2';

Future medicamentos_all(token, idUsuario) async {
  try {
    final response = await http.post(
        Uri.http(ip + ':3004', '/medicamento/allMedicamentosbyUser'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "authorization": 'Bearer $token'
        },
        body: json.encode({"id_usuario": idUsuario}));

    if (response.statusCode == 200) {
      var data = response.body;
      print(jsonDecode(data));
      return data;
    } else {
      return 'No se ha podido conectar al servidor';
    }
  } catch (e) {
    print(e);
    return 'Error';
  }
}

Future medicamentos_name_byName(
  String name,
  int id_usuario,
  token,
) async {
  try {
    final response =
        await http.post(Uri.http(ip + ':3004', '/medicamento/idNameMedicina'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              "authorization": 'Bearer $token'
            },
            body: json.encode({"nombre": name, "id_usuario": id_usuario}));

    if (response.statusCode == 200) {
      var data_aux = response.body;
      var data_aux_2 = jsonDecode(data_aux);
      var data = data_aux_2[0]["id"];

      return data;
    } else {
      return 'No se ha podido conectar al servidor';
    }
  } catch (e) {
    print(e);
    return 'Error';
  }
}

Future medicamentos_name_byID(int id, int id_usuario, token) async {
  try {
    final response =
        await http.post(Uri.http(ip + ':3004', '/medicamento/NameMedicina'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              "authorization": 'Bearer $token'
            },
            body: json.encode({"id": id, "id_usuario": id_usuario}));

    if (response.statusCode == 200) {
      var data_aux = response.body;
      var data_aux_2 = jsonDecode(data_aux);
      var data = data_aux_2[0]["nombre"];

      return data;
    } else {
      return 'No se ha podido conectar al servidor';
    }
  } catch (e) {
    print(e);
    return 'Error';
  }
}

Future<String> register_historia_animal(
  String token,
  int tipoAnimal,
  int id_usuario,
  int id_medicamento,
  int dosis,
  String descripcion,
  String fecha_aplicacion,
  int id_animal,
) async {
  try {
    late String ruta = '';
    if (tipoAnimal == 1) {
      ruta = '/medicamentos_historial_vaca/new';
    } else if (tipoAnimal == 2) {
      ruta = '/medicamentos_historial_toro/new';
    } else if (tipoAnimal == 3) {
      ruta = '/medicamentos_historial_becerro/new';
    }
    final response = await http.post(
      Uri.http(ip + ':3004', ruta),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        "authorization": 'Bearer $token'
      },
      body: json.encode(
        {
          "id_usuario": id_usuario,
          "id_medicamento": id_medicamento,
          "dosis": dosis,
          "descripcion": descripcion,
          "fecha_aplicacion": fecha_aplicacion,
          "id_animal": id_animal
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

Future<String> historial_animal_edit(int id, int tipoAnimal, token) async {
  try {
    late String ruta = '';
    if (tipoAnimal == 1) {
      ruta = '/medicamentos_historial_vaca/getAnimalHistorialOne';
    } else if (tipoAnimal == 2) {
      ruta = '/medicamentos_historial_toro/getAnimalHistorialOne';
    } else if (tipoAnimal == 3) {
      ruta = '/medicamentos_historial_becerro/getAnimalHistorialOne';
    }
    final response = await http.post(
      Uri.http(ip + ':3004', ruta),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        "authorization": 'Bearer $token'
      },
      body: json.encode(
        {
          "id": id,
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

Future<String> register_historia_animal_editar(
    String token,
    int id,
    int tipoAnimal,
    int id_usuario,
    int id_medicamento,
    int dosis,
    String descripcion,
    String fecha_aplicacion,
    int id_animal) async {
  try {
    late String ruta = '';
    if (tipoAnimal == 1) {
      ruta = '/medicamentos_historial_vaca/update';
    } else if (tipoAnimal == 2) {
      ruta = '/medicamentos_historial_toro/update';
    } else if (tipoAnimal == 3) {
      ruta = '/medicamentos_historial_becerro/update';
    }
    final response = await http.post(
      Uri.http(ip + ':3004', ruta),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        "authorization": 'Bearer $token'
      },
      body: json.encode(
        {
          "id": id,
          "id_usuario": id_usuario,
          "id_medicamento": id_medicamento,
          "dosis": dosis,
          "descripcion": descripcion,
          "fecha_aplicacion": fecha_aplicacion,
          "id_animal": id_animal
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

Future<String> historia_animal_eliminar(
  int id,
  int tipoAnimal,
) async {
  try {
    late String ruta = '';
    if (tipoAnimal == 1) {
      ruta = '/medicamentos_historial_vaca/delete';
    } else if (tipoAnimal == 2) {
      ruta = '/medicamentos_historial_toro/delete';
    } else if (tipoAnimal == 3) {
      ruta = '/medicamentos_historial_becerro/delete';
    }
    final response = await http.post(
      Uri.http(ip + ':3004', ruta),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: json.encode(
        {
          "id": id,
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






//localhost:3004/medicamento/idNameMedicina