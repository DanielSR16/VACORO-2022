import 'package:flutter/material.dart';

import 'package:vacoro_proyect/src/pages/login.dart';
import 'package:vacoro_proyect/src/pages/pre_login.dart';
import 'package:vacoro_proyect/src/pages/splash.dart';
import 'package:vacoro_proyect/src/pages/splash_canva.dart';
import 'package:vacoro_proyect/src/pages/vista_principal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'VACORO',
      initialRoute: 'splash',

      routes: {
        'vistaPrincipal': (BuildContext context) => vista_principal(),
        'splash': (BuildContext context) => Splash(),
        'splash_canva': (BuildContext context) => SplashCanva(),
        'login': (BuildContext context) => const Login(),
        'pre_login': (BuildContext context) => const preLogin(),
      },
    );
  }
}
