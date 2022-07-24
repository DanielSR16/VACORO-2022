import 'dart:convert';
import 'package:http/http.dart';
import 'package:vacoro_proyect/src/model/becerrosCategorias.dart';
import 'package:vacoro_proyect/src/model/torosCategorias.dart';

import 'categoryBecerroDao.dart';

Future<List<Toros>> listTorosByIdCategoria(path, cuerpo) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json;charset=UTF-8',
  };
  Response response =
      await post(Uri.parse(path), headers: headers, body: cuerpo);
  if (response.statusCode == 200) {
    final map = json.decode(response.body);
    List<Toros> addToros = [];

    for (var item in map) {
      var cuerpo = jsonEncode({"id_toro": item['id_toro']});
      var toroObtenido = await infoAnimalById(
          "http://192.168.0.2:3006/categoria/findByIdToro", cuerpo);

      Toros toros = Toros(
          id: toroObtenido['id'],
          id_usuario: toroObtenido['id_usuario'],
          nombre: toroObtenido['nombre'],
          descripcion: toroObtenido['descripcion'],
          raza: toroObtenido['raza'],
          num_arete: toroObtenido['num_arete'],
          // url_img: toroObtenido['url_image'],
          estado: toroObtenido['estado'],
          fecha_llegada: toroObtenido['fecha_llegada'],
          edad: toroObtenido['edad']);
      addToros.add(toros);
      print('soy torosssssssssssssssssssssss');
      print(toros);
    }
    return addToros;
  } else {
    return [];
  }
}
