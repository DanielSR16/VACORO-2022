import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/services/servicios_user.dart';
import 'package:vacoro_proyect/src/style/colors/colorview.dart';
import '../metodos/regularExpresion.dart';

class registroUser extends StatefulWidget {
  const registroUser({Key? key}) : super(key: key);

  @override
  State<registroUser> createState() => _registroUserState();
}

class _registroUserState extends State<registroUser> {
  final nombre_ = TextEditingController();
  final apellidos_ = TextEditingController();
  final correo_electronico_ = TextEditingController();
  final contrasenia_ = TextEditingController();
  final repetirContrasenia_ = TextEditingController();
  late String estado_ = '';
  late String ciudad_ = '';
  final edad_ = TextEditingController();
  final nombreRancho_ = TextEditingController();
  List<String> listaCiudades = [''];
  List<String> listaEstados = [''];

  @override
  late bool _validateNombre = false;
  late bool _validateApellido = false;
  late bool _validateCorreo = false;
  late bool _validateContrasenia = false;
  late bool _validateRepetirContra = false;
  late bool _validateEstado = false;
  late bool _validateciudad = false;
  late bool _validatedad = false;
  late bool _validateNombreRancho = false;
  late String _errorCorreo = '';
  late String _errorContrasenia = '';
  late List list_edo = [];
  late String _selectedField = "";
  late String _selectedFieldMunicipio = "";
  late List<FormField> _fieldList = [];
  late List<FormField> _fieldListMunicipio = [];
  late bool _llenadoDatos = false;

  late bool _passwordVisible = false;
  late bool _passwordVisibleRepetir = false;

  late int indexEstado;
  Usuario usuario = Usuario();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getFieldsData();
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
        backgroundColor: const Color(0xFF68C34E),
        actions: [
          Container(
            width: 50,
            child: Image.asset(
              'assets/images/vacoro-blanco.png',
            ),
          ),
        ],
        leading: SizedBox(
          child: IconButton(
            splashRadius: 15,
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(left: bordes, top: 20),
            child: const Text(
              'Registrate',
              style: TextStyle(
                  color: Color(0xFF3E752F),
                  fontSize: 40,
                  fontFamily: 'Cardo',
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: bordes, top: 10),
            child: const Text(
              'Integresa tus datos para crear una cuenta',
              style: TextStyle(
                color: Color(0xFF3E752F),
                fontSize: 17,
                fontFamily: 'Cardo',
              ),
            ),
          ),
          inputs('Nombre', 'Ingrese Nombre', nombre_, _validateNombre,
              TextInputType.name),
          inputs('Apellidos', 'Ingrese Apellidos', apellidos_,
              _validateApellido, TextInputType.name),
          inputs_correo(
              'Correo Electronico',
              'Ingrese Correo Electronico',
              correo_electronico_,
              _validateCorreo,
              TextInputType.emailAddress,
              _errorCorreo),
          inputs_contrasenia('Contraseña', 'Ingrese contraseña', contrasenia_,
              _validateContrasenia, TextInputType.name, _errorContrasenia),
          inputs_contraseniaRepetir(
              'Repetir contraseña',
              'Repila la contraseña',
              repetirContrasenia_,
              _validateRepetirContra,
              TextInputType.name,
              _errorContrasenia),
          drop_button_estado(50, "Estado"),
          drop_button_ciudad(50, "Ciudad"),
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
          Container(
            height: 70,
            padding: EdgeInsets.only(
                left: bordes, right: bordes, bottom: 10, top: 10),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFF68C24E)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
              onPressed: () {
                print('controlador: ' + correo_electronico_.text);
                //  print('controlador b: ' + nombre_.text);
                setState(() {
                  late bool res = valid();

                  if (res == true) {
                    print(estado_);
                    late dynamic a = {"nombre": nombre_};

                    usuario.nombre = nombre_;
                    usuario.apellidos = apellidos_;
                    usuario.correoElectronico = correo_electronico_;
                    usuario.contrasenia = contrasenia_;
                    usuario.estado = estado_;
                    usuario.ciudad = ciudad_;
                    usuario.edad = edad_;
                    usuario.nombreRancho = nombreRancho_;
                  }

                  if (res == true) {
                    Navigator.pushNamed(context, 'registroUser2',
                        arguments: usuario);
                  }
                });

                //
              },
              child: const Text(
                'Siguiente',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
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
              obscureText: !_passwordVisible,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: tipeKeyboard,
              controller: controller_,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: ColorSelect.color1,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
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

  Widget inputs_contraseniaRepetir(
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
              obscureText: !_passwordVisibleRepetir,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: tipeKeyboard,
              controller: controller_,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: ColorSelect.color1,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisibleRepetir = !_passwordVisibleRepetir;
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

    if (correo_electronico_.text.isEmpty) {
      _errorCorreo = 'El campo esta vacio';
      _validateCorreo = true;
      lleno = false;
    } else {
      _validateCorreo = false;
      Iterable<RegExpMatch> matches =
          expresionRegular.allMatches(correo_electronico_.text);

      if (matches.isEmpty == true) {
        _validateCorreo = true;
        lleno = false;
        _errorCorreo = 'Correo invalido';
      }
    }

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

    // setState(() {
    //   print(lleno);
    // });

    setState(() {
      // print(listaEstados);
      // print();
    });
    // listaCiudades.add('hola');
    // listaCiudades.length

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
