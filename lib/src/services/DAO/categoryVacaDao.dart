import 'dart:convert';
import 'package:http/http.dart';
import 'package:vacoro_proyect/src/model/becerrosCategorias.dart';
import 'package:vacoro_proyect/src/model/torosCategorias.dart';
import 'package:vacoro_proyect/src/model/vacasCategorias.dart';

import 'categoryBecerroDao.dart';

Future<List<Vacas>> listVacasByIdCategoria(path, cuerpo) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json;charset=UTF-8',
  };
  Response response =
      await post(Uri.parse(path), headers: headers, body: cuerpo);
  if (response.statusCode == 200) {
    final map = json.decode(response.body);
    List<Vacas> addVacas = [];
    for (var item in map) {
      var cuerpo = jsonEncode({"id_vaca": item['id_vaca']});
      var vacaObtenida = await infoAnimalById(
          "http://192.168.0.2:3006/categoria/findByIdVaca", cuerpo);
      Vacas vacas = Vacas(
          id: vacaObtenida['id'],
          id_usuario: vacaObtenida['id_usuario'],
          nombre: vacaObtenida['nombre'],
          descripcion: vacaObtenida['descripcion'],
          raza: vacaObtenida['raza'],
          num_arete: vacaObtenida['num_arete'],
          // url_img: vacaObtenida['url_image'],
          estado: vacaObtenida['estado'],
          fecha_llegada: vacaObtenida['fecha_llegada'],
          edad: vacaObtenida['edad']);
      addVacas.add(vacas);
    }
    return addVacas;
  } else {
    return [];
  }
}
