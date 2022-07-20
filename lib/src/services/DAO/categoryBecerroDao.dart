import 'dart:convert';
import 'package:http/http.dart';

Future <List<dynamic>> listBecerrosByIdCategoria(path,cuerpo) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json;charset=UTF-8',
  };
  Response response = await post(Uri.parse(path), headers: headers, body: cuerpo);
  if (response.statusCode == 200) {
    final map = json.decode(response.body);
    return map;
  }
  return [];
}

Future <dynamic> infoAnimalById(path,cuerpo) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json;charset=UTF-8',
  };
  Response response = await post(Uri.parse(path), headers: headers, body: cuerpo);
  if (response.statusCode == 200) {
    final map = json.decode(response.body);
    return map;
  }
  return Null;
}