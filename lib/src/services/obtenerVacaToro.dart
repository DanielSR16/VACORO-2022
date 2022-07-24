import 'dart:convert';
import 'package:http/http.dart' as http;

String ip = '192.168.0.2:3001';

Future vacatoro_id(int id, String tipoAnimal, token) async {
  try {
    String api;
    if (tipoAnimal == "Vaca") {
      api = '/vaca/getVacabyId';
    } else {
      api = '/toro/getTorobyId';
    }

    final response = await http.post(Uri.http(ip, api),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({"id": id}));

    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      AnimalModel studentFeesData = AnimalModel.fromJson(map);

      List generalNames =
          studentFeesData.general.map((generalModel) => generalModel).toList();

      return generalNames[0];
    } else {
      return 'No se ha podido conectar al servidor';
    }
  } catch (e) {
    print(e);
    return 'Error';
  }
}

class AnimalModel {
  AnimalModel({
    required this.general,
  });

  final List<dynamic> general;

  factory AnimalModel.fromJson(dynamic json) {
    return AnimalModel(
      general: GeneralModel.listOfGeneralModel(json['general']),
    );
  }

  dynamic toJson() => {
        "general": general,
      };

  @override
  String toString() {
    return '${JsonEncoder.withIndent(' ').convert(this)}';
  }
}

class GeneralModel {
  GeneralModel({
    required this.id,
    required this.id_usuario,
    required this.nombre,
    required this.descripcion,
    required this.raza,
    required this.num_arete,
    required this.url_img,
    required this.estado,
    required this.edad,
    required this.fecha_llegada,
  });

  final int id, id_usuario, estado, edad;
  final String nombre, descripcion, raza, num_arete, url_img, fecha_llegada;

  factory GeneralModel.fromJson(dynamic json) {
    return GeneralModel(
      id: json["id"],
      id_usuario: json["id_usuario"],
      nombre: json["nombre"],
      descripcion: json["descripcion"],
      raza: json["raza"],
      num_arete: json["num_arete"],
      url_img: json["url_img"],
      estado: json["estado"],
      edad: json["edad"],
      fecha_llegada: json["fecha_llegada"],
    );
  }

  static List<dynamic> listOfGeneralModel(dynamic list) {
    dynamic generalModelList = [];
    for (dynamic json in list) {
      generalModelList.add(GeneralModel.fromJson(json));
    }

    return generalModelList;
  }

  dynamic toJson() => {
        "id": id,
        "id_usuario": id_usuario,
        "nombre": nombre,
        "descripcion": descripcion,
        "raza": raza,
        "num_arete": num_arete,
        "url_img": url_img,
        "estado": estado,
        "edad": edad,
        "fecha_llegada": fecha_llegada,
      };

  @override
  String toString() {
    return '${JsonEncoder.withIndent(' ').convert(this)}';
  }
}

Future<List> getVacasbyIdUser(int id_usuario, token) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  String path = '/vaca/getVacasbyIdUser';

  final response = await http.post(
    Uri.http(ip, path),
    headers: headers,
    body: json.encode(
      {'id_usuario': id_usuario},
    ),
  );

  if (response.statusCode == 200) {
    List map = json.decode(response.body);

    Map<int, String> listavacas = Map();

    for (var i = 0; i < map.length; i++) {
      listavacas[map[i]['id']] = map[i]['nombre'] + " " + map[i]['num_arete'];
    }

    return [
      [listavacas],
      map
    ];
  } else {
    return [];
  }
}
