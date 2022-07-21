// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:vacoro_proyect/src/services/anadirBecerro.dart';
// import 'package:vacoro_proyect/src/services/servicios_user.dart';
// import 'package:vacoro_proyect/src/style/colors/colorview.dart';
// import '../metodos/regularExpresion.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart' as path;
// import 'package:path_provider/path_provider.dart';
// import 'package:vacoro_proyect/src/services/generate_image_url.dart';
// import 'package:vacoro_proyect/src/services/upload_file.dart';

// import '../services/usuario.dart';

// class EditarPerfil extends StatefulWidget {
//   const EditarPerfil({Key? key}) : super(key: key);

//   @override
//   State<EditarPerfil> createState() => _EditarPerfilState();
// }

// class _EditarPerfilState extends State<EditarPerfil> {
//   TextEditingController nombre_ = TextEditingController();
//   TextEditingController apellidos_ = TextEditingController();
//   TextEditingController contrasenia_ = TextEditingController();
//   TextEditingController repetirContrasenia_ = TextEditingController();
//   late String estado_ = '';
//   late String ciudad_ = '';
//   TextEditingController edad_ = TextEditingController();
//   TextEditingController nombreRancho_ = TextEditingController();
//   List<String> listaCiudades = [''];
//   List<String> listaEstados = [''];

//   File? image;
//   late String url_img = imageAnimal;
//   late var imageAnimal =
//       'https://image-vacoro.s3.amazonaws.com/e6f3f44a-d935-45c4-819f-76b070c012cf.jpg';
//   @override
//   late bool _validateNombre = false;
//   late bool _validateApellido = false;

//   late bool _validateContrasenia = false;
//   late bool _validateRepetirContra = false;
//   late bool _validateEstado = false;
//   late bool _validateciudad = false;
//   late bool _validatedad = false;
//   late bool _validateNombreRancho = false;

//   late String _errorContrasenia = '';
//   late List list_edo = [];
//   late String _selectedField = "";
//   late String _selectedFieldMunicipio = "";
//   late List<FormField> _fieldList = [];
//   late List<FormField> _fieldListMunicipio = [];
//   late bool _llenadoDatos = false;

//   late int indexEstado;
//   Usuario usuario = Usuario();

//   late String correo = "";
//   late String contrasena = "";
//   int id_usuario = 3;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     setState(() {
//       _getFieldsData();
//     });

//     print("entro");
//     serviceusuario(id_usuario).then((value) {
//       setState(() {
//         nombre_.text = value['nombre'];
//         apellidos_.text = value['apellido'];
//         correo = value['correo_electronico'];
//         contrasena = value['contrasenia'];
//         estado_ = value['estado'];
//         ciudad_ = value['ciudad'];
//         edad_.text = value['edad'].toString();
//         nombreRancho_.text = value['nombre_rancho'];
//       });
//     });
//   }

//   var size, height_media, width_media;
//   late double bordes = 30;
//   @override
//   Widget build(BuildContext context) {
//     size = MediaQuery.of(context).size;
//     height_media = size.height;
//     width_media = size.width;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Center(
//           child: Text(
//             'EDITAR PERFIL',
//             style: TextStyle(fontSize: 18),
//           ),
//         ),
//         leading: SizedBox(
//           child: IconButton(
//             splashRadius: 15,
//             icon: const Icon(
//               Icons.arrow_back,
//               color: Colors.white,
//               size: 40,
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ),
//         actions: [
//           Container(
//             padding: const EdgeInsets.only(left: 30),
//             width: 85,
//             child: Image.asset('assets/images/logo_blanco.png'),
//           )
//         ],
//         backgroundColor: ColorSelect.color5,
//       ),
//       body: ListView(
//         children: [
//           inputs('Nombre', 'Ingrese Nombre', nombre_, _validateNombre,
//               TextInputType.name),
//           inputs('Apellidos', 'Ingrese Apellidos', apellidos_,
//               _validateApellido, TextInputType.name),
//           inputs_correo('Contraseña', 'Ingrese contraseña', contrasenia_,
//               _validateContrasenia, TextInputType.name, _errorContrasenia),
//           inputs_correo(
//               'Repetir contraseña',
//               'Repila la contraseña',
//               repetirContrasenia_,
//               _validateRepetirContra,
//               TextInputType.name,
//               _errorContrasenia),
//           drop_button_estado(50, "Su estado: " + estado_),
//           drop_button_ciudad(50, "Su ciudad: " + ciudad_),
//           Container(
//             padding: EdgeInsets.only(left: bordes, right: 250),
//             child: Column(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.only(top: 10, bottom: 5),
//                   width: width_media,
//                   child: const Text(
//                     'Edad (años)',
//                     textAlign: TextAlign.left,
//                     // ignore: unnecessary_const
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF3E762F),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: _validatedad ? 60 : 40,
//                   child: TextField(
//                     controller: edad_,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       labelStyle: TextStyle(color: Color(0xFF68C24E)),
//                       border: const OutlineInputBorder(
//                         borderSide:
//                             BorderSide(color: ColorSelect.color1, width: 2.0),
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(12),
//                         ),
//                       ),
//                       enabledBorder: const OutlineInputBorder(
//                         borderSide:
//                             BorderSide(color: ColorSelect.color1, width: 2.0),
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(12),
//                         ),
//                       ),
//                       focusedBorder: const OutlineInputBorder(
//                         borderSide:
//                             BorderSide(color: ColorSelect.color5, width: 2.0),
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(12),
//                         ),
//                       ),
//                       errorBorder: const OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.red, width: 2.0),
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(12),
//                         ),
//                       ),
//                       labelText: 'Ingrese edad',
//                       errorText: _validatedad ? 'El campo esta vacio' : null,
//                     ),
//                   ),
//                 ),
//                 const Divider(
//                   height: 5,
//                 ),
//               ],
//             ),
//           ),
//           inputs('Ingrese nombre del rancho', 'Nombre del rancho',
//               nombreRancho_, _validateNombreRancho, TextInputType.name),
//           selectImage(),
//           Container(
//             padding:
//                 const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 20),
//             child: SizedBox(
//               width: size.width - 50,
//               height: 50,
//               child: ElevatedButton(
//                   child: const Text(
//                     'Editar',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       late bool res = valid();
//                       if (res == true) {
//                         print("res");
//                         // serviceeditarusuario(
//                         //   id_usuario,
//                         //   nombre_.text,
//                         //   apellidos_.text,
//                         //   contrasenia_.text,
//                         //   estado_,
//                         //   ciudad_,
//                         //   int.parse(edad_.text),
//                         //   nombreRancho_.text,
//                         //   url_img,
//                         // ).then((value) {
//                         //   if (value['status'] == 'success') {
//                         //     ScaffoldMessenger.of(context).showSnackBar(
//                         //       const SnackBar(
//                         //         duration: Duration(milliseconds: 1000),
//                         //         content: Text('Se actualizo correctamente'),
//                         //       ),
//                         //     );
//                         //     Navigator.pop(context);
//                         //   }
//                         // });
//                       }
//                     });
//                   },
//                   style: ElevatedButton.styleFrom(
//                       primary: ColorSelect.color5,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30)))),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget inputs(
//       String nameTopField,
//       String nameInField,
//       TextEditingController controller_,
//       bool validate_,
//       TextInputType tipeKeyboard) {
//     return Container(
//       padding: EdgeInsets.only(left: bordes, right: bordes),
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.only(top: 10, bottom: 5),
//             width: width_media,
//             child: Text(
//               nameTopField,
//               textAlign: TextAlign.left,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF3E762F),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: validate_ ? 60 : 40,
//             child: TextField(
//               keyboardType: tipeKeyboard,
//               controller: controller_,
//               decoration: InputDecoration(
//                 labelStyle: const TextStyle(color: Color(0xFF68C24E)),
//                 border: const OutlineInputBorder(
//                   borderSide: BorderSide(color: ColorSelect.color1, width: 2.0),
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(12),
//                   ),
//                 ),
//                 enabledBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(color: ColorSelect.color1, width: 2.0),
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(12),
//                   ),
//                 ),
//                 focusedBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(color: ColorSelect.color5, width: 2.0),
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(12),
//                   ),
//                 ),
//                 errorBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.red, width: 2.0),
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(12),
//                   ),
//                 ),
//                 errorText: validate_ ? 'El campo esta vacio' : null,
//                 errorStyle: const TextStyle(color: Colors.red),
//                 labelText: nameInField,
//               ),
//             ),
//           ),
//           const Divider(
//             height: 5,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget inputs_correo(
//       String nameTopField,
//       String nameInField,
//       TextEditingController controller_,
//       bool validate_,
//       TextInputType tipeKeyboard,
//       String _errorCorreo) {
//     return Container(
//       padding: EdgeInsets.only(left: bordes, right: bordes),
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.only(top: 10, bottom: 5),
//             width: width_media,
//             child: Text(
//               nameTopField,
//               textAlign: TextAlign.left,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF3E762F),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: validate_ ? 60 : 40,
//             child: TextField(
//               keyboardType: tipeKeyboard,
//               controller: controller_,
//               decoration: InputDecoration(
//                 labelStyle: const TextStyle(color: Color(0xFF68C24E)),
//                 border: const OutlineInputBorder(
//                   borderSide: BorderSide(color: ColorSelect.color1, width: 2.0),
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(12),
//                   ),
//                 ),
//                 enabledBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(color: ColorSelect.color1, width: 2.0),
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(12),
//                   ),
//                 ),
//                 focusedBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(color: ColorSelect.color5, width: 2.0),
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(12),
//                   ),
//                 ),
//                 errorBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.red, width: 2.0),
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(12),
//                   ),
//                 ),
//                 errorText: validate_ ? _errorCorreo : null,
//                 errorStyle: const TextStyle(color: Colors.red),
//                 labelText: nameInField,
//               ),
//             ),
//           ),
//           const Divider(
//             height: 5,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget inputs_contrasenia(
//       String nameTopField,
//       String nameInField,
//       TextEditingController controller_,
//       bool validate_,
//       TextInputType tipeKeyboard,
//       String _errorContrasenia) {
//     return Container(
//       padding: EdgeInsets.only(left: bordes, right: bordes),
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.only(top: 10, bottom: 5),
//             width: width_media,
//             child: Text(
//               nameTopField,
//               textAlign: TextAlign.left,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF3E762F),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: validate_ ? 60 : 40,
//             child: TextField(
//               keyboardType: tipeKeyboard,
//               controller: controller_,
//               decoration: InputDecoration(
//                 labelStyle: const TextStyle(color: Color(0xFF68C24E)),
//                 border: const OutlineInputBorder(
//                   borderSide: BorderSide(color: ColorSelect.color1, width: 2.0),
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(12),
//                   ),
//                 ),
//                 enabledBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(color: ColorSelect.color1, width: 2.0),
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(12),
//                   ),
//                 ),
//                 focusedBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(color: ColorSelect.color5, width: 2.0),
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(12),
//                   ),
//                 ),
//                 errorBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.red, width: 2.0),
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(12),
//                   ),
//                 ),
//                 errorText: validate_ ? _errorContrasenia : null,
//                 errorStyle: const TextStyle(color: Colors.red),
//                 labelText: nameInField,
//               ),
//             ),
//           ),
//           const Divider(
//             height: 5,
//           ),
//         ],
//       ),
//     );
//   }

//   late String dropdownValue_estado = listaEstados[0];
//   Widget drop_button_estado(int tamWidth, String nameTopField) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Container(
//           padding: const EdgeInsets.only(top: 10, bottom: 5, left: 5),
//           width: width_media - tamWidth,
//           child: Text(
//             nameTopField,
//             textAlign: TextAlign.left,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF3E762F),
//             ),
//           ),
//         ),
//         Container(
//           width: width_media - tamWidth,
//           padding: const EdgeInsets.only(left: 5),
//           child: SizedBox(
//             height: 40,
//             child: DecoratedBox(
//               decoration: BoxDecoration(
//                 border: Border.all(color: const Color(0xFF3E762F), width: 2.0),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: DropdownButton<String>(
//                 alignment: AlignmentDirectional.topEnd,
//                 style: const TextStyle(color: Color(0xFF68C24E), fontSize: 16),
//                 value: _selectedField,
//                 items: _fieldList.map((value) {
//                   if (_llenadoDatos == false) {
//                     list_edo.add(value.description);
//                     if (list_edo.length == 32) {
//                       _llenadoDatos = true;
//                     }
//                   }

//                   return DropdownMenuItem(
//                       child: Text(
//                         value.description!,
//                       ),
//                       value: value.description);
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(
//                     () {
//                       _selectedField = value!;
//                       estado_ = _selectedField;
//                       indexEstado = list_edo.indexOf(_selectedField) + 1;
//                       _getFieldsData_municipios(indexEstado);
//                     },
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   late String dropdownValue_ciudad = listaCiudades[0];
//   Widget drop_button_ciudad(int tamWidth, String nameTopField) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Container(
//           padding: const EdgeInsets.only(top: 10, bottom: 5, left: 5),
//           width: width_media - tamWidth,
//           child: Text(
//             nameTopField,
//             textAlign: TextAlign.left,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF3E762F),
//             ),
//           ),
//         ),
//         Container(
//             width: width_media - tamWidth,
//             padding: const EdgeInsets.only(left: 5),
//             child: SizedBox(
//               height: 40,
//               child: DecoratedBox(
//                 decoration: BoxDecoration(
//                   border:
//                       Border.all(color: const Color(0xFF3E762F), width: 2.0),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: DropdownButton<String>(
//                   alignment: AlignmentDirectional.center,
//                   style:
//                       const TextStyle(color: Color(0xFF68C24E), fontSize: 16),
//                   value: _selectedFieldMunicipio,
//                   items: _fieldListMunicipio.map((value) {
//                     return DropdownMenuItem(
//                         child: Text(
//                           value.description!,
//                         ),
//                         value: value.description);
//                   }).toList(),
//                   onChanged: (String? newValue) {
//                     setState(
//                       () {
//                         _selectedFieldMunicipio = newValue!;
//                         ciudad_ = _selectedFieldMunicipio;
//                       },
//                     );
//                   },
//                   // onTap: () {
//                   //   print('aa');
//                   // },
//                 ),
//               ),
//             )),
//       ],
//     );
//   }

//   bool valid() {
//     bool lleno = true;

//     if (nombre_.text.isEmpty) {
//       _validateNombre = true;
//       lleno = false;
//     } else {
//       _validateNombre = false;
//     }

//     if (apellidos_.text.isEmpty) {
//       _validateApellido = true;
//       lleno = false;
//     } else {
//       _validateApellido = false;
//     }

//     if (contrasenia_.text.isEmpty) {
//       _validateContrasenia = true;
//       lleno = false;
//       _errorContrasenia = 'El campo esta vacio';
//     } else {
//       _validateContrasenia = false;
//       Iterable<RegExpMatch> matches2 =
//           expressionRegularPassword.allMatches(contrasenia_.text);

//       if (matches2.isEmpty == true) {
//         _validateContrasenia = true;
//         lleno = false;
//         _errorContrasenia =
//             'Incluir may., minúsc., núm., símb.(\$@!%*?&#¿¡), min. 8 caracteres';
//       }
//     }

//     if (repetirContrasenia_.text.isEmpty) {
//       _validateRepetirContra = true;
//       _errorContrasenia = 'El campo esta vacio';
//     } else {
//       _validateRepetirContra = false;
//     }

//     if (contrasenia_.text != repetirContrasenia_.text) {
//       _validateRepetirContra = true;
//       _validateContrasenia = true;
//       lleno = false;
//       _errorContrasenia = 'Las contraseñas no coinciden';
//     }

//     if (edad_.text.isEmpty) {
//       _validatedad = true;

//       lleno = false;
//     } else {
//       _validatedad = false;
//     }

//     if (nombreRancho_.text.isEmpty) {
//       _validateNombreRancho = true;

//       lleno = false;
//     } else {
//       _validateNombreRancho = false;
//     }

//     setState(() {});

//     return lleno;
//   }

//   void _getFieldsData() {
//     estados_all().then(
//       (data) {
//         final items = jsonDecode(data).cast<Map<String, dynamic>>();
//         var fieldListData = items.map<FormField>((json) {
//           return FormField.fromJson(json);
//         }).toList();

//         _selectedField = fieldListData[0].description;
//         // update widget
//         setState(
//           () {
//             _fieldList = fieldListData;
//           },
//         );
//       },
//     );
//   }

//   void _getFieldsData_municipios(id) {
//     municipios_id(id).then(
//       (data) {
//         final items = jsonDecode(data).cast<Map<String, dynamic>>();
//         var fieldListData = items.map<FormField>((json) {
//           return FormField.fromJson(json);
//         }).toList();
//         _selectedFieldMunicipio = fieldListData[0].description;
//         // update widget
//         setState(
//           () {
//             _fieldListMunicipio = fieldListData;
//           },
//         );
//       },
//     );
//   }

//   Widget selectImage() {
//     return Row(
//       children: <Widget>[
//         Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
//               child: const Text(
//                 'Imagen de su marca',
//                 style: TextStyle(
//                   color: ColorSelect.color1,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             Container(
//               margin: const EdgeInsets.only(left: 16),
//               child: image != null
//                   ? Image.file(
//                       image!,
//                       width: 160,
//                       height: 150,
//                       fit: BoxFit.cover,
//                     )
//                   : Image(
//                       width: 160,
//                       height: 150,
//                       image: NetworkImage(imageAnimal),
//                     ),
//             ),
//           ],
//         ),
//         Container(
//           padding: const EdgeInsets.only(
//             right: 1,
//           ),
//           child: SizedBox(
//             width: 160,
//             height: 150,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 buildButton(
//                   title: 'Elija una imagen',
//                   icon: Icons.image_outlined,
//                   onClicked: () => pickImage(),
//                 ),
//                 buildButton(
//                   title: 'Tomar fotografía',
//                   icon: Icons.image_outlined,
//                   onClicked: () => pickCamera(),
//                 ),
//                 buildButton(
//                   title: 'Cancelar selección',
//                   icon: Icons.image_outlined,
//                   onClicked: () {
//                     setState(() {
//                       image = null;
//                       imageAnimal =
//                           'https://image-vacoro.s3.amazonaws.com/e6f3f44a-d935-45c4-819f-76b070c012cf.jpg';
//                       url_img = imageAnimal;
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }

//   Widget buildButton({
//     required String title,
//     required IconData icon,
//     required VoidCallback onClicked,
//   }) =>
//       ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           minimumSize: const Size.fromHeight(35),
//           primary: ColorSelect.color1,
//           onPrimary: Colors.white,
//           textStyle: const TextStyle(fontSize: 14),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(18.0),
//           ),
//         ),
//         child: Row(children: [
//           const SizedBox(width: 2),
//           Text(title),
//         ]),
//         onPressed: onClicked,
//       );

//   Future pickCamera() async {
//     try {
//       final image = await ImagePicker().pickImage(source: ImageSource.camera);

//       if (image == null) return;

//       final imageTemporary = File(image.path);

//       String fileExtension = path.extension(image.path);
//       print(imageTemporary);
//       print(fileExtension);
//       GenerateImageUrl generateImageUrl = GenerateImageUrl();
//       print(generateImageUrl);
//       await generateImageUrl.call(fileExtension);

//       url_img = generateImageUrl.downloadUrl;
//       var uploadUrl;
//       if (generateImageUrl.isGenerated != null &&
//           generateImageUrl.isGenerated) {
//         uploadUrl = generateImageUrl.uploadUrl;
//       } else {
//         throw generateImageUrl.message;
//       }

//       bool isUploaded = await uploadFile(context, uploadUrl, imageTemporary);
//       print(isUploaded);

//       setState(
//         () => this.image = imageTemporary,
//       );
//     } on PlatformException catch (e) {
//       print('Failed to pick image: $e');
//     }
//   }

//   Future<File> saveImagePermanently(String imagePath) async {
//     final directory = await getApplicationDocumentsDirectory();
//     final name = path.basename(imagePath);
//     final image = File('${directory.path}/$name');

//     return File(imagePath).copy(image.path);
//   }

//   Future pickImage() async {
//     try {
//       final image = await ImagePicker().pickImage(source: ImageSource.gallery);
//       if (image == null) return;

//       //final imageTemporary = File(image.path);
//       final imageTemporary = await saveImagePermanently(image.path);
//       setState(() => this.image = imageTemporary);

//       String fileExtension = path.extension(image.path);

//       GenerateImageUrl generateImageUrl = GenerateImageUrl();
//       await generateImageUrl.call(fileExtension);

//       url_img = generateImageUrl.downloadUrl;
//       var uploadUrl;
//       if (generateImageUrl.isGenerated != null &&
//           generateImageUrl.isGenerated) {
//         uploadUrl = generateImageUrl.uploadUrl;
//       } else {
//         throw generateImageUrl.message;
//       }

//       bool isUploaded = await uploadFile(context, uploadUrl, imageTemporary);
//       print(isUploaded);
//     } on PlatformException catch (e) {
//       print('Failed to pick image: $e');
//     }
//   }

//   Future<bool> uploadFile(context, String url, File image) async {
//     try {
//       UploadFile uploadFile = UploadFile();
//       await uploadFile.call(url, image);

//       if (uploadFile.isUploaded != null && uploadFile.isUploaded) {
//         return true;
//       } else {
//         throw uploadFile.message;
//       }
//     } catch (e) {
//       throw e;
//     }
//   }
// }

// // Model Class
// class FormField {
//   String? description;

//   FormField({this.description});

//   FormField.fromJson(Map<String, dynamic> json) {
//     description = json['description'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['description'] = description;
//     return data;
//   }
// }

// class Usuario {
//   var nombre;
//   var apellidos;
//   var correoElectronico;
//   var contrasenia;
//   var estado;
//   var ciudad;
//   var edad;
//   var nombreRancho;
// }

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vacoro_proyect/src/services/anadirBecerro.dart';
import 'package:vacoro_proyect/src/services/servicios_user.dart';
import 'package:vacoro_proyect/src/style/colors/colorview.dart';
import '../metodos/regularExpresion.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:vacoro_proyect/src/services/generate_image_url.dart';
import 'package:vacoro_proyect/src/services/upload_file.dart';

import '../services/usuario.dart';

class EditarPerfil extends StatefulWidget {
  const EditarPerfil({Key? key}) : super(key: key);

  @override
  State<EditarPerfil> createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {
  TextEditingController nombre_ = TextEditingController();
  TextEditingController apellidos_ = TextEditingController();
  late String estado_ = '';
  late String ciudad_ = '';
  TextEditingController edad_ = TextEditingController();
  TextEditingController nombreRancho_ = TextEditingController();
  List<String> listaCiudades = [''];
  List<String> listaEstados = [''];

  File? image;
  late String url_img = imageAnimal;
  late var imageAnimal =
      'https://image-vacoro.s3.amazonaws.com/e6f3f44a-d935-45c4-819f-76b070c012cf.jpg';
  @override
  late bool _validateNombre = false;
  late bool _validateApellido = false;
  late bool _validateEstado = false;
  late bool _validateciudad = false;
  late bool _validatedad = false;
  late bool _validateNombreRancho = false;

  late List list_edo = [];
  late String _selectedField = "";
  late String _selectedFieldMunicipio = "";
  late List<FormField> _fieldList = [];
  late List<FormField> _fieldListMunicipio = [];
  late bool _llenadoDatos = false;

  late int indexEstado;
  Usuario usuario = Usuario();

  late String correo = "";
  late String contrasena = "";
  int id_usuario = 3;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _getFieldsData();
    });

    serviceusuario(id_usuario).then((value) {
      setState(() {
        nombre_.text = value['nombre'];
        apellidos_.text = value['apellido'];
        correo = value['correo_electronico'];
        contrasena = value['contrasenia'];
        estado_ = value['estado'];
        ciudad_ = value['ciudad'];
        edad_.text = value['edad'].toString();
        nombreRancho_.text = value['nombre_rancho'];
        imageAnimal = value['url_image'];
      });
    });
  }

  var size, height_media, width_media;
  late double bordes = 30;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height_media = size.height;
    width_media = size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'EDITAR PERFIL',
            style: TextStyle(fontSize: 18),
          ),
        ),
        leading: SizedBox(
          child: IconButton(
            splashRadius: 15,
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 40,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(left: 30),
            width: 85,
            child: Image.asset('assets/images/logo_blanco.png'),
          )
        ],
        backgroundColor: ColorSelect.color5,
      ),
      body: Container(
        height: height_media,
        width: width_media,
        child: ListView(
          children: [
            inputs('Nombre', 'Ingrese Nombre', nombre_, _validateNombre,
                TextInputType.name),
            inputs('Apellidos', 'Ingrese Apellidos', apellidos_,
                _validateApellido, TextInputType.name),
            drop_button_estado(50, "Su estado: " + estado_),
            drop_button_ciudad(50, "Su ciudad: " + ciudad_),
            Container(
              padding: EdgeInsets.only(left: bordes, right: 250),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 5),
                    width: width_media,
                    child: const Text(
                      'Edad (años)',
                      textAlign: TextAlign.left,
                      // ignore: unnecessary_const
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3E762F),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: _validatedad ? 60 : 40,
                    child: TextField(
                      controller: edad_,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Color(0xFF68C24E)),
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorSelect.color1, width: 2.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorSelect.color1, width: 2.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorSelect.color5, width: 2.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        labelText: 'Ingrese edad',
                        errorText: _validatedad ? 'El campo esta vacio' : null,
                      ),
                    ),
                  ),
                  const Divider(
                    height: 5,
                  ),
                ],
              ),
            ),
            inputs('Ingrese nombre del rancho', 'Nombre del rancho',
                nombreRancho_, _validateNombreRancho, TextInputType.name),
            selectImage(),
            Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 25, bottom: 20),
              child: SizedBox(
                width: size.width - 50,
                height: 50,
                child: ElevatedButton(
                    child: const Text(
                      'Editar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        late bool res = valid();

                        if (res == true) {
                          serviceeditarusuario(
                            id_usuario,
                            nombre_.text,
                            apellidos_.text,
                            correo,
                            contrasena,
                            ciudad_,
                            estado_,
                            int.parse(edad_.text),
                            nombreRancho_.text,
                            url_img,
                          ).then((value) {
                            if (value['status'] == 'ok') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  duration: Duration(milliseconds: 1000),
                                  content: Text('Se actualizo correctamente'),
                                ),
                              );
                              //Navigator.pop(context);
                            }
                          });
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        primary: ColorSelect.color5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget inputs(
      String nameTopField,
      String nameInField,
      TextEditingController controller_,
      bool validate_,
      TextInputType tipeKeyboard) {
    return Container(
      padding: EdgeInsets.only(left: bordes, right: bordes),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            width: width_media,
            child: Text(
              nameTopField,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3E762F),
              ),
            ),
          ),
          SizedBox(
            height: validate_ ? 60 : 40,
            child: TextField(
              keyboardType: tipeKeyboard,
              controller: controller_,
              decoration: InputDecoration(
                labelStyle: const TextStyle(color: Color(0xFF68C24E)),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorSelect.color1, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorSelect.color1, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorSelect.color5, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                errorText: validate_ ? 'El campo esta vacio' : null,
                errorStyle: const TextStyle(color: Colors.red),
                labelText: nameInField,
              ),
            ),
          ),
          const Divider(
            height: 5,
          ),
        ],
      ),
    );
  }

  Widget inputs_correo(
      String nameTopField,
      String nameInField,
      TextEditingController controller_,
      bool validate_,
      TextInputType tipeKeyboard,
      String _errorCorreo) {
    return Container(
      padding: EdgeInsets.only(left: bordes, right: bordes),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            width: width_media,
            child: Text(
              nameTopField,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3E762F),
              ),
            ),
          ),
          SizedBox(
            height: validate_ ? 60 : 40,
            child: TextField(
              keyboardType: tipeKeyboard,
              controller: controller_,
              decoration: InputDecoration(
                labelStyle: const TextStyle(color: Color(0xFF68C24E)),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorSelect.color1, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorSelect.color1, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorSelect.color5, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                errorText: validate_ ? _errorCorreo : null,
                errorStyle: const TextStyle(color: Colors.red),
                labelText: nameInField,
              ),
            ),
          ),
          const Divider(
            height: 5,
          ),
        ],
      ),
    );
  }

  Widget inputs_contrasenia(
      String nameTopField,
      String nameInField,
      TextEditingController controller_,
      bool validate_,
      TextInputType tipeKeyboard,
      String _errorContrasenia) {
    return Container(
      padding: EdgeInsets.only(left: bordes, right: bordes),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            width: width_media,
            child: Text(
              nameTopField,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3E762F),
              ),
            ),
          ),
          SizedBox(
            height: validate_ ? 60 : 40,
            child: TextField(
              keyboardType: tipeKeyboard,
              controller: controller_,
              decoration: InputDecoration(
                labelStyle: const TextStyle(color: Color(0xFF68C24E)),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorSelect.color1, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorSelect.color1, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorSelect.color5, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                errorText: validate_ ? _errorContrasenia : null,
                errorStyle: const TextStyle(color: Colors.red),
                labelText: nameInField,
              ),
            ),
          ),
          const Divider(
            height: 5,
          ),
        ],
      ),
    );
  }

  late String dropdownValue_estado = listaEstados[0];
  Widget drop_button_estado(int tamWidth, String nameTopField) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 10, bottom: 5, left: 5),
          width: width_media - tamWidth,
          child: Text(
            nameTopField,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3E762F),
            ),
          ),
        ),
        Container(
          width: width_media - tamWidth,
          padding: const EdgeInsets.only(left: 5),
          child: SizedBox(
            height: 40,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF3E762F), width: 2.0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButton<String>(
                alignment: AlignmentDirectional.topEnd,
                style: const TextStyle(color: Color(0xFF68C24E), fontSize: 16),
                value: _selectedField,
                items: _fieldList.map((value) {
                  if (_llenadoDatos == false) {
                    list_edo.add(value.description);
                    if (list_edo.length == 32) {
                      _llenadoDatos = true;
                    }
                  }

                  return DropdownMenuItem(
                      child: Text(
                        value.description!,
                      ),
                      value: value.description);
                }).toList(),
                onChanged: (value) {
                  setState(
                    () {
                      _selectedField = value!;
                      estado_ = _selectedField;
                      indexEstado = list_edo.indexOf(_selectedField) + 1;
                      _getFieldsData_municipios(indexEstado);
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  late String dropdownValue_ciudad = listaCiudades[0];
  Widget drop_button_ciudad(int tamWidth, String nameTopField) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 10, bottom: 5, left: 5),
          width: width_media - tamWidth,
          child: Text(
            nameTopField,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3E762F),
            ),
          ),
        ),
        Container(
            width: width_media - tamWidth,
            padding: const EdgeInsets.only(left: 5),
            child: SizedBox(
              height: 40,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color(0xFF3E762F), width: 2.0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButton<String>(
                  alignment: AlignmentDirectional.center,
                  style:
                      const TextStyle(color: Color(0xFF68C24E), fontSize: 16),
                  value: _selectedFieldMunicipio,
                  items: _fieldListMunicipio.map((value) {
                    return DropdownMenuItem(
                        child: Text(
                          value.description!,
                        ),
                        value: value.description);
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(
                      () {
                        _selectedFieldMunicipio = newValue!;
                        ciudad_ = _selectedFieldMunicipio;
                      },
                    );
                  },
                  // onTap: () {
                  //   print('aa');
                  // },
                ),
              ),
            )),
      ],
    );
  }

  bool valid() {
    bool lleno = true;

    if (nombre_.text.isEmpty) {
      _validateNombre = true;
      lleno = false;
    } else {
      _validateNombre = false;
    }

    if (apellidos_.text.isEmpty) {
      _validateApellido = true;
      lleno = false;
    } else {
      _validateApellido = false;
    }

    if (edad_.text.isEmpty) {
      _validatedad = true;

      lleno = false;
    } else {
      _validatedad = false;
    }

    if (nombreRancho_.text.isEmpty) {
      _validateNombreRancho = true;

      lleno = false;
    } else {
      _validateNombreRancho = false;
    }

    setState(() {});

    return lleno;
  }

  void _getFieldsData() {
    estados_all().then(
      (data) {
        final items = jsonDecode(data).cast<Map<String, dynamic>>();
        var fieldListData = items.map<FormField>((json) {
          return FormField.fromJson(json);
        }).toList();

        _selectedField = fieldListData[0].description;
        // update widget
        setState(
          () {
            _fieldList = fieldListData;
          },
        );
      },
    );
  }

  void _getFieldsData_municipios(id) {
    municipios_id(id).then(
      (data) {
        final items = jsonDecode(data).cast<Map<String, dynamic>>();
        var fieldListData = items.map<FormField>((json) {
          return FormField.fromJson(json);
        }).toList();
        _selectedFieldMunicipio = fieldListData[0].description;
        // update widget
        setState(
          () {
            _fieldListMunicipio = fieldListData;
          },
        );
      },
    );
  }

  Widget selectImage() {
    return Row(
      children: <Widget>[
        Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
              child: const Text(
                'Imagen de su marca',
                style: TextStyle(
                  color: ColorSelect.color1,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16),
              child: image != null
                  ? Image.file(
                      image!,
                      width: 160,
                      height: 150,
                      fit: BoxFit.cover,
                    )
                  : Image(
                      width: 160,
                      height: 150,
                      image: NetworkImage(imageAnimal),
                    ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.only(
            right: 1,
          ),
          child: SizedBox(
            width: 160,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildButton(
                  title: 'Elija una imagen',
                  icon: Icons.image_outlined,
                  onClicked: () => pickImage(),
                ),
                buildButton(
                  title: 'Tomar fotografía',
                  icon: Icons.image_outlined,
                  onClicked: () => pickCamera(),
                ),
                buildButton(
                  title: 'Cancelar selección',
                  icon: Icons.image_outlined,
                  onClicked: () {
                    setState(() {
                      image = null;
                      imageAnimal =
                          'https://image-vacoro.s3.amazonaws.com/e6f3f44a-d935-45c4-819f-76b070c012cf.jpg';
                      url_img = imageAnimal;
                    });
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildButton({
    required String title,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(35),
          primary: ColorSelect.color1,
          onPrimary: Colors.white,
          textStyle: const TextStyle(fontSize: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        child: Row(children: [
          const SizedBox(width: 2),
          Text(title),
        ]),
        onPressed: onClicked,
      );

  Future pickCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemporary = File(image.path);

      String fileExtension = path.extension(image.path);
      print(imageTemporary);
      print(fileExtension);
      GenerateImageUrl generateImageUrl = GenerateImageUrl();
      print(generateImageUrl);
      await generateImageUrl.call(fileExtension);

      url_img = generateImageUrl.downloadUrl;
      var uploadUrl;
      if (generateImageUrl.isGenerated != null &&
          generateImageUrl.isGenerated) {
        uploadUrl = generateImageUrl.uploadUrl;
      } else {
        throw generateImageUrl.message;
      }

      bool isUploaded = await uploadFile(context, uploadUrl, imageTemporary);
      print(isUploaded);

      setState(
        () => this.image = imageTemporary,
      );
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = path.basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      //final imageTemporary = File(image.path);
      final imageTemporary = await saveImagePermanently(image.path);
      setState(() => this.image = imageTemporary);

      String fileExtension = path.extension(image.path);

      GenerateImageUrl generateImageUrl = GenerateImageUrl();
      await generateImageUrl.call(fileExtension);

      url_img = generateImageUrl.downloadUrl;
      var uploadUrl;
      if (generateImageUrl.isGenerated != null &&
          generateImageUrl.isGenerated) {
        uploadUrl = generateImageUrl.uploadUrl;
      } else {
        throw generateImageUrl.message;
      }

      bool isUploaded = await uploadFile(context, uploadUrl, imageTemporary);
      print(isUploaded);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<bool> uploadFile(context, String url, File image) async {
    try {
      UploadFile uploadFile = UploadFile();
      await uploadFile.call(url, image);

      if (uploadFile.isUploaded != null && uploadFile.isUploaded) {
        return true;
      } else {
        throw uploadFile.message;
      }
    } catch (e) {
      throw e;
    }
  }
}

// Model Class
class FormField {
  String? description;

  FormField({this.description});

  FormField.fromJson(Map<String, dynamic> json) {
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    return data;
  }
}

class Usuario {
  var nombre;
  var apellidos;
  var correoElectronico;
  var contrasenia;
  var estado;
  var ciudad;
  var edad;
  var nombreRancho;
}
