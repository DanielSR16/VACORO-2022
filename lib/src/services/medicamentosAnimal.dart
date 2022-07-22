import 'dart:convert';
import 'package:http/http.dart' as http;

String ip = '192.168.0.31';

Future medicamentos_all() async {
  try {
    final response = await http.get(
      Uri.http(ip + ':3004', '/medicamento/allMedicamentos'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );

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

Future medicamentos_name_byName(String name) async {
  try {
    final response = await http.post(
        Uri.http(ip + ':3004', '/medicamento/idNameMedicina'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode({"nombre": name}));

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

Future medicamentos_name_byID(int id, int id_usuario) async {
  try {
    final response = await http.post(
        Uri.http(ip + ':3004', '/medicamento/NameMedicina'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
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
      ruta = '/medicamentos_historial_vaca/new';
    } else if (tipoAnimal == 2) {
      ruta = '/medicamentos_historial_toro/new';
    } else if (tipoAnimal == 3) {
      ruta = '/medicamentos_historial_becerro/new';
    }
    final response = await http.post(
      Uri.http(ip + ':3004', ruta),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
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

Future<String> historial_animal_edit(int id, int tipoAnimal) async {
  try {
    late String ruta = '';
    if (tipoAnimal == 1) {
      ruta = '/medicamentos_historial_vaca/getAnimalHistorial';
    } else if (tipoAnimal == 2) {
      ruta = '/medicamentos_historial_toro/getAnimalHistorial';
    } else if (tipoAnimal == 3) {
      ruta = '/medicamentos_historial_becerro/getAnimalHistorial';
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

Future<String> register_historia_animal_editar(
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
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
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