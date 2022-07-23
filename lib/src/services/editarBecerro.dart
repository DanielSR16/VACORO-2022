import 'dart:convert';
import 'package:http/http.dart' as http;

String host = '192.168.0.10:3001';

Future<Map<String, dynamic>> serviceeditarbecerro(
  String token,
  int id_usuario,
  int id,
  String nombre,
  String descripcion,
  String raza,
  String num_arete,
  String url_img,
  int estado,
  int edad,
  int id_vaca,
  String fecha_llegada,
) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  String animalAPI = '/becerro/update/';

  try {
    final response = await http.post(
      Uri.http(host, animalAPI),
      headers: headers,
      body: json.encode(
        {
          'id': id,
          'id_usuario': id_usuario,
          'nombre': nombre,
          'descripcion': descripcion,
          'raza': raza,
          'num_arete': num_arete,
          'url_img': url_img,
          'estado': estado,
          'edad': edad,
          'id_vaca': id_vaca,
          'fecha_llegada': fecha_llegada
        },
      ),
    );
    print("error");
    print(response.statusCode);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      Map<String, dynamic> responseMap = {
        'status': data['status'],
      };
      print(responseMap);
      // return responseMap;
      //return data;
      return responseMap;
    } else {
      return {'status': 'Error'};
    }
  } catch (e) {
    return {'status': 'Error al conectarse con el servidor'};
  }
}

Future<Map<String, dynamic>> servicedeletebecerro(
  String token,
  int id,
) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  String animalAPI = '/becerro/delete/';

  try {
    print('borrar');
    print(id);
    final response = await http.post(
      Uri.http(host, animalAPI),
      headers: headers,
      body: json.encode({'id': id}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      Map<String, dynamic> responseMap = {
        'status': data['status'],
      };
      print(responseMap);

      return responseMap;
    } else {
      return {'status': 'Error'};
    }
  } catch (e) {
    return {'status': 'Error al conectarse con el servidor'};
  }
}

Future becerro_id(int id, token) async {
  try {
    String api = '/becerro/getBecerrobyId';

    final response = await http.post(Uri.http(host, api),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({"id": id}));

    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      BecerroModel studentFeesData = BecerroModel.fromJson(map);

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

class BecerroModel {
  BecerroModel({
    required this.general,
  });

  final List<dynamic> general;

  factory BecerroModel.fromJson(dynamic json) {
    return BecerroModel(
      general: GeneralModelBecerro.listOfGeneralModel(json['general']),
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

class GeneralModelBecerro {
  GeneralModelBecerro({
    required this.id,
    required this.id_usuario,
    required this.nombre,
    required this.descripcion,
    required this.raza,
    required this.num_arete,
    required this.url_img,
    required this.estado,
    required this.edad,
    required this.id_vaca,
    required this.fecha_llegada,
  });

  final int id, id_usuario, estado, edad, id_vaca;
  final String nombre, descripcion, raza, num_arete, url_img, fecha_llegada;

  factory GeneralModelBecerro.fromJson(dynamic json) {
    return GeneralModelBecerro(
      id: json["id"],
      id_usuario: json["id_usuario"],
      nombre: json["nombre"],
      descripcion: json["descripcion"],
      raza: json["raza"],
      num_arete: json["num_arete"],
      url_img: json["url_img"],
      estado: json["estado"],
      edad: json["edad"],
      id_vaca: json["id_vaca"],
      fecha_llegada: json["fecha_llegada"],
    );
  }

  static List<dynamic> listOfGeneralModel(dynamic list) {
    dynamic generalModelList = [];
    for (dynamic json in list) {
      generalModelList.add(GeneralModelBecerro.fromJson(json));
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
        "id_vaca": id_vaca,
        "fecha_llegada": fecha_llegada,
      };

  @override
  String toString() {
    return '${JsonEncoder.withIndent(' ').convert(this)}';
  }
}
