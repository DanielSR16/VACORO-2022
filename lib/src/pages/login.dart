import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/pages/homepage.dart';
import 'package:vacoro_proyect/src/services/login.dart';

import '../style/colors/colorview.dart';

//Login para ingresar correo y contraseña

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    decoration: const InputDecoration(
                      fillColor: Colors.amber,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      hintText: 'Ingrese su correo electrónico',
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
                    controller: password,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 15, color: ColorSelect.color1),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      hintText: 'Ingrese su contraseña',
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
                          servicelogin(email, password).then((value) {
                            if (value['id'] == 'errorEmail') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  duration: Duration(milliseconds: 1000),
                                  content: Text('Email incorrecto'),
                                ),
                              );
                            } else if (value['id'] == 'errorPassword') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  duration: Duration(milliseconds: 1000),
                                  content: Text('Password incorrecto'),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  duration: Duration(milliseconds: 1000),
                                  content: Text('Inicio de sesión correcto'),
                                ),
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        homePage(nombre: value['nombre'])),
                              );
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
                        onPressed: () {},
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
}
