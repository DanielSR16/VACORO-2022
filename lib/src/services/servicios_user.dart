// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;

// String ip = '192.168.0.68';
// Future<String> register_user(
//     String name,
//     String apellidos,
//     String correo_electronico,
//     String contrasenia,
//     String estado,
//     String ciudad,
//     int edad,
//     String nombreRancho,
//     String urlImage
//     ) async {
//   try {
//     final response = await http.post(
//       Uri.http(ip + ':3000', '/usuario/usuarioNuevo'),
//       headers: {'Content-Type': 'application/json; charset=UTF-8'},
//       body: json.encode(
//         {
//           "nombre": name,
//           "apellido": apellidos,
//           "correo_electronico": correo_electronico,
//           "contrasenia": contrasenia,
//           "ciudad": ciudad,
//           "estado": estado,
//           "edad": edad,
//           "rancho": nombreRancho,
//           "url_image": urlImage
//         },
//       ),
//     );

//     if (response.statusCode == 200) {
//       // final data = json.decode(response.body);
//       var data = response.body;
//       if (data == 'Usuario Existente') {
//         return 'El usuario ya existe';
//       } else {
//         return data;
//       }
//     } else {
//       return 'No se ha podido conectar al servidor';
//     }
//   } catch (e) {
//     return 'Error';
//   }
// }
