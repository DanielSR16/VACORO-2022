import 'dart:convert';
import 'package:http/http.dart';
import '../../model/vacasCategorias.dart';
import 'categoryBecerroDao.dart';

Future<List<Vacas>> listaVacas(path,iduser) async {
  Map<String, String> headers = {'Content-Type': 'application/json'};

  var id = jsonEncode({"id_usuario":iduser});
  Response response = await post(Uri.parse(path), headers: headers, body:id);
  
  if (response.statusCode == 200) {
    final map = json.decode(response.body);
    List<Vacas> addBecerros = [];
    for (var item in map){
      var cuerpo = jsonEncode({"id_vaca":item['id_vaca']});
      var becerroObtenido = await infoAnimalById("http://192.168.100.6:3006/categoria/findByIdVaca", cuerpo);
      Vacas becerro = Vacas(id: becerroObtenido['id'], id_usuario: becerroObtenido['id_usuario'], nombre: becerroObtenido['nombre'], 
      descripcion: becerroObtenido['descripcion'], raza: becerroObtenido['raza'], num_arete: becerroObtenido['num_arete'], 
      url_img: becerroObtenido['url_img'], estado: becerroObtenido['estado'], fecha_llegada: becerroObtenido['fecha_llegada'], 
      edad: becerroObtenido['edad']);
      addBecerros.add(becerro);
    }
    return addBecerros;
  }
  return [];
}

Future<List<Vacas>> listaVacasTotal(path,iduser) async {
  Map<String, String> headers = {'Content-Type': 'application/json'};
  var id = jsonEncode({"id_usuario":iduser});
  Response response = await post(Uri.parse(path), headers: headers, body:id);
  if (response.statusCode == 200) {
    final map = json.decode(response.body);
    List<Vacas> addBecerros = [];
    for (var item in map){
      Vacas becerro = Vacas(id: item['id'], id_usuario: item['id_usuario'], nombre: item['nombre'], 
      descripcion: item['descripcion'], raza: item['raza'], num_arete: item['num_arete'], 
      url_img: item['url_img'], estado: item['estado'], fecha_llegada: item['fecha_llegada'], 
      edad: item['edad']);
      addBecerros.add(becerro);
    }
    return addBecerros;
  }
  return [];
}