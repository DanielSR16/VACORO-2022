import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vacoro_proyect/src/services/servicios_user.dart';
import 'package:vacoro_proyect/src/style/colors/colorview.dart';
import '../metodos/regularExpresion.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:vacoro_proyect/src/services/generate_image_url.dart';
import 'package:vacoro_proyect/src/services/upload_file.dart';

import '../services/usuario.dart';

class EditarContrasena extends StatefulWidget {
  const EditarContrasena({Key? key}) : super(key: key);

  @override
  State<EditarContrasena> createState() => _EditarContrasenaState();
}

class _EditarContrasenaState extends State<EditarContrasena> {
  TextEditingController contrasenia_ = TextEditingController();
  TextEditingController repetirContrasenia_ = TextEditingController();
  TextEditingController contraseniaVieja_ = TextEditingController();
  @override
  late bool _validateContrasenia = false;
  late bool _validateRepetirContra = false;
  late bool _validateContraseniaVieja = false;

  late String _errorContrasenia = '';
  late bool _passwordVisibleActual = false;
  late bool _passwordVisibleNueva = false;
  late bool _passwordVisibleNuevaRepetir = false;

  int id_usuario = 11;

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
            'EDITAR CONTRASEÑA',
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
            inputs_contrasenaActual(
              'Contraseña actual',
              'Ingrese su contraseña actual',
              contraseniaVieja_,
              _validateContraseniaVieja,
              TextInputType.name,
            ),
            inputs_contrasenaNueva(
              'Contraseña nueva',
              'Ingrese contraseña nueva',
              contrasenia_,
              _validateContrasenia,
              TextInputType.name,
              _errorContrasenia,
            ),
            input_repetirContrasena(
              'Repetir contraseña nueva',
              'Repila la contraseña nueva',
              repetirContrasenia_,
              _validateRepetirContra,
              TextInputType.name,
              _errorContrasenia,
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 450, bottom: 20),
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
                          serviceUserPassword(
                                  id_usuario, contraseniaVieja_.text)
                              .then((value) {
                            if (value['status'] == 'ok') {
                              serviceusuario(id_usuario).then((value) {
                                serviceeditarPassword(value, contrasenia_.text)
                                    .then((value) {
                                  if (value['status'] == 'ok') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        duration: Duration(milliseconds: 1000),
                                        content:
                                            Text('Se actualizo la contraseña'),
                                      ),
                                    );
                                  }
                                });
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  duration: Duration(milliseconds: 1000),
                                  content: Text(
                                      'No se puede actualiza compruebe su contraseña'),
                                ),
                              );
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

  Widget inputs_contrasenaActual(
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
              obscureText: !_passwordVisibleActual,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: tipeKeyboard,
              controller: controller_,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisibleActual
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: ColorSelect.color1,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisibleActual = !_passwordVisibleActual;
                    });
                  },
                ),
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

  Widget inputs_contrasenaNueva(
    String nameTopField,
    String nameInField,
    TextEditingController controller_,
    bool validate_,
    TextInputType tipeKeyboard,
    String _errorCorreo,
  ) {
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
              obscureText: !_passwordVisibleNueva,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: tipeKeyboard,
              controller: controller_,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisibleNueva
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: ColorSelect.color1,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisibleNueva = !_passwordVisibleNueva;
                    });
                  },
                ),
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

  Widget input_repetirContrasena(
    String nameTopField,
    String nameInField,
    TextEditingController controller_,
    bool validate_,
    TextInputType tipeKeyboard,
    String _errorCorreo,
  ) {
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
              obscureText: !_passwordVisibleNuevaRepetir,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: tipeKeyboard,
              controller: controller_,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisibleNuevaRepetir
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: ColorSelect.color1,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisibleNuevaRepetir =
                          !_passwordVisibleNuevaRepetir;
                    });
                  },
                ),
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

  bool valid() {
    bool lleno = true;

    if (contrasenia_.text.isEmpty) {
      _validateContrasenia = true;
      lleno = false;
      _errorContrasenia = 'El campo esta vacio';
    } else {
      _validateContrasenia = false;
      Iterable<RegExpMatch> matches2 =
          expressionRegularPassword.allMatches(contrasenia_.text);

      if (matches2.isEmpty == true) {
        _validateContrasenia = true;
        lleno = false;
        _errorContrasenia =
            'Incluir may., minúsc., núm., símb.(\$@!%*?&#¿¡), min. 8 caracteres';
      }
    }

    if (repetirContrasenia_.text.isEmpty) {
      _validateRepetirContra = true;
      _errorContrasenia = 'El campo esta vacio';
    } else {
      _validateRepetirContra = false;
    }

    if (contrasenia_.text != repetirContrasenia_.text) {
      _validateRepetirContra = true;
      _validateContrasenia = true;
      lleno = false;
      _errorContrasenia = 'Las contraseñas no coinciden';
    }

    if (contraseniaVieja_.text.isEmpty) {
      _validateContraseniaVieja = true;

      lleno = false;
    } else {
      _validateContraseniaVieja = false;
    }

    setState(() {});
    return lleno;
  }
}
