import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/pages/registro_user.dart';
import 'package:vacoro_proyect/src/pages/registro_user2.dart';
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
      title: 'Flutter Demo',
      initialRoute: 'registroUser',
      routes: {
        'registroUser': (BuildContext context) => registroUser(),
        'registroUser2': (BuildContext context) => registroUser2()
      },
    );
  }
}
