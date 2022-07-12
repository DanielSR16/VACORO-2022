import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/services/servicios_user.dart';
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
  final estado_ = TextEditingController();
  late String ciudad_;
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
//https://api.flutter.dev/flutter/widgets/Element/reassemble.html
//https://api.flutter.dev/flutter/widgets/BuildOwner/reassemble.html
  void initState() {
    setState(
      () {
        estados_all().then(
          (value) {
            for (var i = 0; i < value.length; i++) {
              listaEstados.add(value[i]['description']);
            }
          },
        );
      },
    );

    super.initState();
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
          inputs_correo('Contraseña', 'Ingrese contraseña', contrasenia_,
              _validateContrasenia, TextInputType.name, _errorContrasenia),
          inputs_correo(
              'Repetir contraseña',
              'Repila la contraseña',
              repetirContrasenia_,
              _validateRepetirContra,
              TextInputType.name,
              _errorContrasenia),
          Row(
            children: [
              drop_button_estado(220, "Estado"),
              drop_button_ciudad(220, "Ciudad")
            ],
          ),
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
                  height: 40,
                  child: TextField(
                    controller: edad_,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Color(0xFF68C24E)),
                      enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF3E762F), width: 2.0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF3E762F), width: 2.0),
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
                  valid();
                });

                // Navigator.pushNamed(context, 'registroUser2');
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
    // print(validate_);
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
            height: 40,
            child: TextField(
              keyboardType: tipeKeyboard,
              controller: controller_,
              decoration: InputDecoration(
                labelStyle: const TextStyle(color: Color(0xFF68C24E)),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF3E762F), width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF3E762F), width: 2.0),
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
    // print(validate_);
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
            height: 40,
            child: TextField(
              keyboardType: tipeKeyboard,
              controller: controller_,
              decoration: InputDecoration(
                labelStyle: const TextStyle(color: Color(0xFF68C24E)),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF3E762F), width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF3E762F), width: 2.0),
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
    // print(validate_);
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
            height: 40,
            child: TextField(
              keyboardType: tipeKeyboard,
              controller: controller_,
              decoration: InputDecoration(
                labelStyle: const TextStyle(color: Color(0xFF68C24E)),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF3E762F), width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF3E762F), width: 2.0),
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
          padding: const EdgeInsets.only(top: 10, bottom: 5, left: 30),
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
          padding: EdgeInsets.only(left: bordes),
          child: SizedBox(
            height: 40,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF3E762F), width: 2.0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButton<String>(
                alignment: AlignmentDirectional.topEnd,
                style: const TextStyle(
                  color: Color(0xFF68C24E),
                ),
                value: dropdownValue_estado,
                items: listaEstados.map<DropdownMenuItem<String>>(
                  (String value) {
                    // print('val drop: ' + dropdownValue_estado);
                    // print('soy el valor: ' + value);
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 9),
                      ),
                    );
                  },
                ).toList(),
                onChanged: (String? newValue) {
                  setState(
                    () {
                      dropdownValue_estado = newValue!;

                      print('************** ' + dropdownValue_estado);
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
          padding: const EdgeInsets.only(top: 10, bottom: 5, left: 30),
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
            padding: EdgeInsets.only(left: bordes),
            child: SizedBox(
              height: 40,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color(0xFF3E762F), width: 2.0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButton<String>(
                  alignment: AlignmentDirectional.topEnd,
                  style: const TextStyle(
                    color: Color(0xFF68C24E),
                  ),
                  value: dropdownValue_ciudad,
                  items: listaCiudades.map<DropdownMenuItem<String>>(
                    (String value) {
                      // print('val drop: ' + dropdownValue_ciudad);
                      // print('soy el valor: ' + value);
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 9),
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (String? newValue) {
                    setState(
                      () {
                        dropdownValue_ciudad = newValue!;
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
      _errorContrasenia = 'Las contraseñas no coinciden';
    }

    // if (estado_.text.isEmpty) {
    //   _validateEstado = true;

    // } else {
    //   _validateEstado = false;
    // }

    // if (ciudad_.text.isEmpty) {
    //   _validateciudad = true;
    // } else {
    //   _validateciudad = false;
    // }

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
}
