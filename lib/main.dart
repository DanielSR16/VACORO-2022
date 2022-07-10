import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:vacoro_proyect/src/pages/dashboard_bull.dart';
import 'package:vacoro_proyect/src/pages/dashboard_calf.dart';
import 'package:vacoro_proyect/src/pages/dashboard_cow.dart';

//import 'package:vacoro_proyect/src/pages/homepage.dart';

import 'package:vacoro_proyect/src/pages/anadir_animal.dart';
// import 'package:vacoro_proyect/src/pages/homepage.dart';
import 'package:vacoro_proyect/src/pages/login.dart';
import 'package:vacoro_proyect/src/pages/pre_login.dart';

import 'package:vacoro_proyect/src/pages/splash.dart';
import 'package:vacoro_proyect/src/pages/splash_canva.dart';
// import 'package:vacoro_proyect/src/pages/vista_principal.dart';
import 'firebase_options.dart';
// import 'src/pages/authentications.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      initialRoute: 'login',
      routes: {
        // 'autenticacion': (BuildContext context) => const autenticacion(),
        // 'homePage': (BuildContext context) => homePage(),
        // 'vistaPrincipal': (BuildContext context) => const vista_principal(),
        'splash': (BuildContext context) => Splash(),
        'splash_canva': (BuildContext context) => SplashCanva(),
        'login': (BuildContext context) => const Login(),
        'pre_login': (BuildContext context) => const preLogin(),
        'anadir_animal': (BuildContext context) => const AnadirAnimal(),
        'dash_cow': (BuildContext context) => DashBoardCow(),
        'dash_bull': (BuildContext context) => DashBoardBull(),
        'dash_calf': (BuildContext context) => DashBoardCalf()
      },
    );
  }
}
