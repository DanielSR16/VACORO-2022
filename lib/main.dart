import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/pages/anadir_becerro.dart';
import 'package:vacoro_proyect/src/pages/anadir_medicamento_animal.dart';
import 'package:vacoro_proyect/src/pages/editarPerfilContrasena.dart';
import 'package:vacoro_proyect/src/pages/editar_animal.dart';
import 'package:vacoro_proyect/src/pages/editar_becerro.dart';
import 'package:vacoro_proyect/src/pages/editar_perfil.dart';
import 'package:vacoro_proyect/src/pages/editar_medicamento_animal.dart';

import 'package:vacoro_proyect/src/pages/medication.dart';

import 'package:vacoro_proyect/src/pages/dashboard_category.dart';
import 'package:vacoro_proyect/src/pages/registro_user.dart';
import 'package:vacoro_proyect/src/pages/registro_user2.dart';
import 'package:vacoro_proyect/src/pages/vista_principal.dart';

import 'package:vacoro_proyect/src/pages/medication_history.dart';

import 'package:vacoro_proyect/src/pages/registro_user.dart';
import 'package:vacoro_proyect/src/pages/registro_user2.dart';
import 'package:vacoro_proyect/src/pages/vista_principal.dart';

import 'package:vacoro_proyect/src/pages/anadir_animal.dart';
import 'package:vacoro_proyect/src/pages/dashboard_bull.dart';
import 'package:vacoro_proyect/src/pages/dashboard_calf.dart';
import 'package:vacoro_proyect/src/pages/dashboard_cow.dart';
import 'package:vacoro_proyect/src/pages/edit_categories.dart';
// import 'package:vacoro_proyect/src/pages/homepage.dart';
import 'package:vacoro_proyect/src/pages/login.dart';
import 'package:vacoro_proyect/src/pages/metrics.dart';
import 'package:vacoro_proyect/src/pages/pre_login.dart';
import 'package:vacoro_proyect/src/pages/registro_user.dart';
import 'package:vacoro_proyect/src/pages/registro_user2.dart';

import 'package:vacoro_proyect/src/pages/splash.dart';
import 'package:vacoro_proyect/src/pages/splash_canva.dart';
import 'package:vacoro_proyect/src/widgets/window_modal/modal_add_medication.dart';
import 'package:vacoro_proyect/src/widgets/window_modal/modal_bull_details.dart';
import 'package:vacoro_proyect/src/widgets/window_modal/modal_category_details.dart';
import 'package:vacoro_proyect/src/widgets/window_modal/modal_cow_calf_details.dart';
// import 'package:vacoro_proyect/src/pages/vista_principal.dart';
import 'firebase_options.dart';
import 'src/pages/homepage.dart';
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
    var correo;
    var nombre;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'VACORO',
        initialRoute: 'login',
        routes: {
          // 'autenticacion': (BuildContext context) => const autenticacion(),

          // 'vistaPrincipal': (BuildContext context) => const vista_principal(),
          // 'homepage': (BuildContext context) =>
          //     homePage(correo: correo, nombre: nombre),
          'splash': (BuildContext context) => Splash(),
          'splash_canva': (BuildContext context) => SplashCanva(),
          'login': (BuildContext context) => const Login(),
          'pre_login': (BuildContext context) => const preLogin(),
          // 'anadir_animal': (BuildContext context) =>
          //     AnadirAnimal(tipoAnimal: "Vaca"),
          'dash_cow': (BuildContext context) => DashBoardCow(),
          'dash_bull': (BuildContext context) => DashBoardBull(),
          'dash_calf': (BuildContext context) => DashBoardCalf(),
          'dash_category': (BuildContext context) => DashboardCategory(),
          'registroUser': (BuildContext context) => registroUser(),
          'registroUser2': (BuildContext context) => registroUser2(),

          'dash_medication': (BuildContext context) => Medication(),

          'medication_history': (BuildContext context) => MedicationHistory(),
          // 'EditarBecerro': (BuildContext context) => EditarBecerro(id: 11),
          // 'AnadirBecerro': (BuildContext context) => AnadirBecerro(),
          // 'EditarPerfil': (BuildContext context) => EditarPerfil(),
          'AnadirMedicamentoAnimal': (BuildContext context) =>
              AnadirMedicamentoAnimal(),
          'EditarMedicamentoAnimal': (BuildContext context) =>
              EditarMedicamentoAnimal(),
          // 'EditarPerfil': (BuildContext context) => EditarPerfil(),
          'ContainerdDialogCowCalfDetails': (BuildContext context) =>
              ContainerdDialogCowCalfDetails(),
          // 'EditarContrasena': (BuildContext context) => EditarContrasena(),
          // 'ContainerDialogModalBullDetail': (BuildContext context) =>
          //     ContainerDialogModalBullDetail(tipoAnimal: "Toro", id: 2),
          // 'ContainerDialogModalCowDetail': (BuildContext context) =>
          //     ContainerDialogModalCowDetail(tipoAnimal: "Vaca", id: 2),
          // 'ContainerDialogModalCalfDetail': (BuildContext context) =>
          //     ContainerDialogModalCalfDetail(id: 1),
          // 'EditarAnimal': (BuildContext context) => EditarAnimal(
          //       tipoAnimal: "Vaca",
          //       id: 2,
          //     ),
        });
  }
}
