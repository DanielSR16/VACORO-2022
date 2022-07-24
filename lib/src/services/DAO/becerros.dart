import 'dart:convert';
import 'package:http/http.dart';
import 'package:vacoro_proyect/src/model/becerrosCategorias.dart';
import 'package:http/http.dart' as http;

Future<List<Becerros>> listaBecerros(path) async {
  Map<String, String> headers = {'Content-Type': 'application/json'};

  Response response = await get(Uri.parse(path), headers: headers);
  
  if (response.statusCode == 200) {
    final map = json.decode(response.body);
    List<Becerros> listProducts = [];
    for (Map items in map){
      Becerros becerro = Becerros(id: items['id'], id_usuario: items['id_usuario'], nombre: items['nombre'], 
      descripcion: items['descripcion'], raza: items['raza'], num_arete: items['num_arete'], 
      estado: items['estado'], fecha_llegada: items['fecha_llegada'], id_vaca: items['id_vaca'], edad: items['edad']);
      listProducts.add(becerro);
    }
    return listProducts;
  }
  return [];
}