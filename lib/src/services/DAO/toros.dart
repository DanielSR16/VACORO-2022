import 'dart:convert';
import 'package:http/http.dart';
import 'package:vacoro_proyect/src/model/torosCategorias.dart';

import 'categoryBecerroDao.dart';

Future<List<Toros>> listaToros(path,iduser) async {
  Map<String, String> headers = {'Content-Type': 'application/json'};

  var id = jsonEncode({"id_usuario":iduser});
  Response response = await post(Uri.parse(path), headers: headers, body:id);
  
  if (response.statusCode == 200) {
    final map = json.decode(response.body);
    List<Toros> addBecerros = [];
    for (var item in map){
      var cuerpo = jsonEncode({"id_toro":item['id_toro']});
      var becerroObtenido = await infoAnimalById("http://192.168.100.6:3006/categoria/findByIdToro", cuerpo);
      Toros becerro = Toros(id: becerroObtenido['id'], id_usuario: becerroObtenido['id_usuario'], nombre: becerroObtenido['nombre'], 
      descripcion: becerroObtenido['descripcion'], raza: becerroObtenido['raza'], num_arete: becerroObtenido['num_arete'], 
      url_img: becerroObtenido['url_img'], estado: becerroObtenido['estado'], fecha_llegada: becerroObtenido['fecha_llegada'], 
      edad: becerroObtenido['edad']);
      addBecerros.add(becerro);
    }
    return addBecerros;
  }
  return [];
}

Future<List<Toros>> listaTorosTotal(path,iduser) async {
  Map<String, String> headers = {'Content-Type': 'application/json'};
  var id = jsonEncode({"id_usuario":iduser});
  Response response = await post(Uri.parse(path), headers: headers, body:id);
  if (response.statusCode == 200) {
    final map = json.decode(response.body);
    List<Toros> addBecerros = [];
    for (var item in map){
      Toros becerro = Toros(id: item['id'], id_usuario: item['id_usuario'], nombre: item['nombre'], 
      descripcion: item['descripcion'], raza: item['raza'], num_arete: item['num_arete'], 
      url_img: item['url_img'], estado: item['estado'], fecha_llegada: item['fecha_llegada'], 
      edad: item['edad']);
      addBecerros.add(becerro);
    }
    return addBecerros;
  }
  return [];
}

