import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/metodos/regularExpresion.dart';
import 'package:vacoro_proyect/src/pages/homepage.dart';
import 'package:vacoro_proyect/src/services/login.dart';

import '../style/colors/colorview.dart';
import '../utils/user_secure_storage.dart';

//Login para ingresar correo y contraseña

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  late bool _validateEmail = false;
  late bool _validatePassword = false;
  late String _errorCorreo = '';
  late String _errorContrasenia = '';

  late bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    email.text = 'd@gmail.com';
    password.text = 'Dulce1234%';
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
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
        backgroundColor: ColorSelect.color5,
      ),
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 250,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/logo.png')),
                  ),
                ),
                Container(
                  width: size.width * 0.90,
                  margin: const EdgeInsets.only(top: 20, bottom: 10),
                  child: const Text(
                    'Correo electrónico',
                    style: TextStyle(
                        color: ColorSelect.color1,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.90,
                  child: TextField(
                    controller: email,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 15, color: ColorSelect.color1),
                    decoration: InputDecoration(
                      fillColor: Colors.amber,
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
                      hintText: 'Ingrese su correo electrónico',
                      errorText: _validateEmail ? _errorCorreo : null,
                    ),
                    onChanged: (text) {},
                  ),
                ),
                Container(
                  width: size.width * 0.90,
                  margin: const EdgeInsets.only(top: 20, bottom: 10),
                  child: const Text(
                    'Contraseña',
                    style: TextStyle(
                        color: ColorSelect.color1,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
                Container(
                  width: size.width * 0.90,
                  margin: const EdgeInsets.only(right: 12, left: 11),
                  child: TextField(
                    obscureText: !_passwordVisible,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: password,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 15, color: ColorSelect.color1),
                    decoration: InputDecoration(
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
                      hintText: 'Ingrese su contraseña',
                      errorText: _validatePassword ? _errorContrasenia : null,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: ColorSelect.color1,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                    onChanged: (text) {},
                  ),
                ),
                Container(
                  width: size.width * 0.90,
                  margin: const EdgeInsets.only(right: 8),
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: const Text(
                      '¿Haz olvidado tu contraseña?',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorSelect.color5,
                          fontSize: 16),
                    ),
                    onPressed: () {},
                  ),
                ),
                Container(
                  width: size.width * 0.90,
                  padding: const EdgeInsets.only(top: 35),
                  child: SizedBox(
                    width: size.width - 50,
                    height: 50,
                    child: ElevatedButton(
                        child: const Text(
                          'Ingresar',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            late bool res = valid();
                            if (res == true) {
                              servicelogin(email, password).then((value) async {
                                if (value['id'] == 'errorEmailPassword' ||
                                    value['status'] ==
                                        'Error al conectarse con el servidor') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      duration: Duration(milliseconds: 1000),
                                      content: Text(
                                          'Correo o contraseña incorrecta'),
                                    ),
                                  );
                                } else {
                                  await UserSecureStorage.setId(value['id']
                                      .toString()); //Se guarda el id en el local storage
                                  await UserSecureStorage.setToken(
                                      value['token'].toString());

                                      
                                  await UserSecureStorage.setName(
                                      value['nombre'].toString());

                                  await UserSecureStorage.setCorreo(
                                      value['correo_electronico'].toString());

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      duration: Duration(milliseconds: 1000),
                                      content:
                                          Text('Inicio de sesión correcto'),
                                    ),
                                  );
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => homePage(
                                              nombre: value['nombre'],
                                              correo:
                                                  value['correo_electronico'],
                                            )),
                                  );
                                }
                              });
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            primary: ColorSelect.color5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)))),
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("¿Todavía no tienes una cuenta?",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.left),
                      TextButton(
                        child: const Text(
                          'Regístrate',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorSelect.color5,
                              fontSize: 16),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, 'registroUser');
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool valid() {
    bool lleno = true;

    if (email.text.isEmpty) {
      _errorCorreo = 'El campo esta vacio';
      _validateEmail = true;
      lleno = false;
    } else {
      _validateEmail = false;
      Iterable<RegExpMatch> matches = expresionRegular.allMatches(email.text);

      if (matches.isEmpty == true) {
        _validateEmail = true;
        lleno = false;
        _errorCorreo = 'Correo invalido';
      }
    }

    if (password.text.isEmpty) {
      _validatePassword = true;
      lleno = false;
      _errorContrasenia = 'El campo esta vacio';
    } else {
      _validatePassword = false;
    }

    return lleno;
  }
}
