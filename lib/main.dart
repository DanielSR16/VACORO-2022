import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/pages/dashboard_bull.dart';
import 'package:vacoro_proyect/src/pages/dashboard_calf.dart';
import 'package:vacoro_proyect/src/pages/dashboard_cow.dart';
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
      title: 'Flutter Demo',
      // initialRoute: 'vistaPrincipal',
      initialRoute: 'dash_calf',
      routes: {
        // 'vistaPrincipal': (BuildContext context) => vista_principal(),
        'splash': (BuildContext context) => Splash(),
        'splash_canva':(BuildContext context) => SplashCanva(),
        'dash_cow':(BuildContext context) => DashBoardCow(),
        'dash_bull':(BuildContext context) => DashBoardBull(),
        'dash_calf':(BuildContext context) => DashBoardCalf()
      },
    );
  }
}
