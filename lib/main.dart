import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/pages/login.dart';
import 'package:vacoro_proyect/src/pages/pre_login.dart';

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
      initialRoute: 'pre_login',
      routes: {
        'login': (BuildContext context) => const Login(),
        'pre_login': (BuildContext context) => const preLogin(),
      },
    );
  }
}
