import 'dart:ui';

import 'package:flutter/material.dart';
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
          body: SizedBox(
            width: size.width,
            height: size.height,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 24, right: 24, top: 20, bottom: 50),
                      height: size.width - 150,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/logo.png')),
                      )
                    ),
                    Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        width: size.width - 75,
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  ColorSelect.color3),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Text('Continuar con Google',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: ColorSelect.color6,
                                      fontSize: 18),
                                  textAlign: TextAlign.center),
                              Image(
                                  width: 32,
                                  image: AssetImage(
                                      'assets/images/icon_google.png'))
                            ],
                          ),
                          onPressed: () {
                            try {
                              signInWithGoogle().then((value) =>{
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => homePage(nombre: value.user!.displayName!)))
                              }
                                // ignore: avoid_print
                              );
                            } catch (e) {
                              // ignore: avoid_print
                              print(e);
                            }
                          },
                        )),
                    Container(
                      margin: const EdgeInsets.only(right: 150, top: 20),
                      child: const Text(
                        '¿Ya tienes una cuenta?',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )),
                  Container(
                    margin: const EdgeInsets.only(right: 150, top: 20),
                    child: const Text(
                      '¿Ya tienes una cuenta?',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                    Container(
                        width: size.width - 75,
                        height: 50,
                        margin: const EdgeInsets.only(top: 20),
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Text('Continuar con Facebook',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: ColorSelect.color6),
                                  textAlign: TextAlign.center),
                              Image(
                                  width: 32,
                                  image: AssetImage(
                                      'assets/images/icon_facebook.png'))
                            ],
                          ),
                          onPressed: () {
                           try {
                            signInWithFacebook().then((value) =>{
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => homePage(nombre: value.user!.displayName!)))
                                }
                                // ignore: avoid_print
                                );
                              } catch (e) {
                              // ignore: avoid_print
                              print(e);
                              }
                            },
                          )),
                    Container(
                      margin: const EdgeInsets.only(right: 150, top: 20),
                      child: const Text(
                        '¿Ya tienes una cuenta?',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      width: size.width - 75,
                      height: 50,
                      margin: const EdgeInsets.only(top: 5),
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
                    Container(
                      margin: const EdgeInsets.only(right: 115, top: 20),
                      child: const Text(
                        '¿Aún no tienes una cuenta?',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                        width: size.width - 75,
                        height: 50,
                        margin: const EdgeInsets.only(top: 5),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  ColorSelect.color4),
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
                          onPressed: () {},
                        ))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
