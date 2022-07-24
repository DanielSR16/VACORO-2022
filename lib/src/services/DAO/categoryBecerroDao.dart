import 'dart:convert';
import 'package:http/http.dart';
import 'package:vacoro_proyect/src/model/becerrosCategorias.dart';

Future<List<Becerros>> listBecerrosByIdCategoria(path, cuerpo) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json;charset=UTF-8',
  };
  Response response =
      await post(Uri.parse(path), headers: headers, body: cuerpo);
  if (response.statusCode == 200) {
    final map = json.decode(response.body);
    List<Becerros> addBecerros = [];
    for (var item in map) {
      var cuerpo = jsonEncode({"id_becerro": item['id_becerro']});
      var becerroObtenido = await infoAnimalById(
          "http://categorias-vacoro-1164392975.us-east-1.elb.amazonaws.com/categoria/findByIdBecerro",
          cuerpo);
      Becerros becerro = Becerros(
          id: becerroObtenido['id'],
          id_usuario: becerroObtenido['id_usuario'],
          nombre: becerroObtenido['nombre'],
          descripcion: becerroObtenido['descripcion'],
          raza: becerroObtenido['raza'],
          num_arete: becerroObtenido['num_arete'],
          estado: becerroObtenido['estado'],
          fecha_llegada: becerroObtenido['fecha_llegada'],
          id_vaca: becerroObtenido['id_vaca'],
          edad: becerroObtenido['edad']);
      addBecerros.add(becerro);
    }
    return addBecerros;
  } else {
    return [];
  }
}

Future<dynamic> infoAnimalById(path, cuerpo) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json;charset=UTF-8',
  };
  Response response =
      await post(Uri.parse(path), headers: headers, body: cuerpo);
  if (response.statusCode == 200) {
    final map = json.decode(response.body);
    return map;
  }
  return Null;
}

Future<dynamic> deleteAnimalCategoryById(path, cuerpo) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json;charset=UTF-8',
  };
  Response response =
      await post(Uri.parse(path), headers: headers, body: cuerpo);
  if (response.statusCode == 200) {
    return response.statusCode;
  }
  return Null;
}

Future<dynamic> findCategoryBecerroByIdBecerro(path, cuerpo) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json;charset=UTF-8',
  };
  Response response =
      await post(Uri.parse(path), headers: headers, body: cuerpo);
  if (response.statusCode == 200) {
    return jsonDecode(response.body); //response.body;
  }
  return Null;
}

Future<dynamic> updateBecerroByCategory(path, cuerpo) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json;charset=UTF-8',
  };
  Response response =
      await post(Uri.parse(path), headers: headers, body: cuerpo);
  if (response.statusCode == 200) {
    return jsonDecode(response.body); //response.body;
  }
  return Null;
}
