import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vacoro_proyect/src/services/authFacebook.dart';
import 'package:vacoro_proyect/src/services/authGoogle.dart';
import '../style/colors/colorview.dart';
import 'homepage.dart';

class preLogin extends StatelessWidget {
  const preLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'VACORO',
            style: TextStyle(fontSize: 25),
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
                      margin: const EdgeInsets.only(
                          left: 24, right: 24, top: 20, bottom: 80),
                      height: 250,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/logo.png')),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: size.width * 0.80,
                          margin: const EdgeInsets.only(top: 20),
                          child: const Text(
                            '¿Ya tienes una cuenta?',
                            style: TextStyle(
                                fontSize: 16, color: ColorSelect.color1),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: size.width * 0.80,
                      height: 50,
                      margin: const EdgeInsets.only(top: 5),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                ColorSelect.color5),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Text('Iniciar sesión',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: ColorSelect.color6, //
                                ),
                                textAlign: TextAlign.center),
                          ],
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, 'login');
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: size.width * 0.80,
                          margin: const EdgeInsets.only(top: 20),
                          child: const Text(
                            '¿Aún no tienes una cuenta?',
                            style: TextStyle(
                                fontSize: 16, color: ColorSelect.color1),
                          ),
                        ),
                      ],
                    ),
                    Container(
                        width: size.width * 0.80,
                        height: 50,
                        margin: const EdgeInsets.only(top: 5, bottom: 20),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  ColorSelect.color1),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Text('Registrate',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: ColorSelect.color6, //
                                  ),
                                  textAlign: TextAlign.center),
                            ],
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, 'registroUser');
                          },
                        ))
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
