import 'dart:convert';
import 'package:http/http.dart';
import 'package:vacoro_proyect/src/model/becerrosCategorias.dart';
import 'package:http/http.dart' as http;

import 'categoryBecerroDao.dart';

Future<List<Becerros>> listaBecerros(path,iduser) async {
  Map<String, String> headers = {'Content-Type': 'application/json'};
  var id = jsonEncode({"id_usuario":iduser});
  Response response = await post(Uri.parse(path), headers: headers, body:id);
  
  if (response.statusCode == 200) {
    final map = json.decode(response.body);
    List<Becerros> addBecerros = [];
    for (var item in map){
      var cuerpo = jsonEncode({"id_becerro":item['id_becerro']});
      print(cuerpo);
      var becerroObtenido = await infoAnimalById("http://192.168.100.6:3006/categoria/findByIdBecerro", cuerpo);
      Becerros becerro = Becerros(id: becerroObtenido['id'], id_usuario: becerroObtenido['id_usuario'], nombre: becerroObtenido['nombre'], 
      descripcion: becerroObtenido['descripcion'], raza: becerroObtenido['raza'], num_arete: becerroObtenido['num_arete'], 
      url_img: becerroObtenido['url_img'], estado: becerroObtenido['estado'], fecha_llegada: becerroObtenido['fecha_llegada'], 
      id_vaca: becerroObtenido['id_vaca'], edad: becerroObtenido['edad']);
      addBecerros.add(becerro);
    }
    return addBecerros;
  }
  return [];
}