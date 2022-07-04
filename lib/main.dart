import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/pages/homepage.dart';
import 'package:vacoro_proyect/src/pages/vista_principal.dart';
import 'firebase_options.dart';
import 'src/pages/authentications.dart';

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
      title: 'Flutter Demo',
      initialRoute: 'homePage',
      routes: {
        'autenticacion': (BuildContext context) => autenticacion(),
        'homePage': (BuildContext context) => homePage(),
        'vistaPrincipal': (BuildContext context) => vista_principal(),
      },
    );
  }
}
