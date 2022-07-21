import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/pages/menu.dart';
import 'package:vacoro_proyect/src/widgets/HomePage/appBar.dart';
import 'package:vacoro_proyect/src/widgets/HomePage/textoBienvenida.dart';
import '../services/usuario.dart';
import '../utils/user_secure_storage.dart';
import '../widgets/HomePage/dashboard.dart';
import '../widgets/HomePage/card_image_text_center.dart';
//import '../services/authFacebook.dart';
//import '../services/authGoogle.dart';

class homePage extends StatefulWidget {
  String nombre;
  String correo;
  homePage({Key? key, required this.nombre, required this.correo})
      : super(key: key);

  @override
  State<homePage> createState() => _homePage();
}

class _homePage extends State<homePage> {
  late int id_usuario = 0;
  late var imageUsuario =
      'https://image-vacoro.s3.amazonaws.com/e6f3f44a-d935-45c4-819f-76b070c012cf.jpg';
  @override
  void initState() {
    super.initState();
    UserSecureStorage.getId().then((value) {
      setState(() {
        int id_cast = int.parse(value!);

        id_usuario = id_cast;
        serviceusuario(id_usuario).then((value) {
          imageUsuario = value['url_image'];
        });
      });
    });

    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbargeneral(widget.nombre, 'assets/images/logo_blanco.png'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              child: Column(
                children: [
                  textoBienvenida(context,
                      "Seleccione el tipo de ganado que desea visualizar"),
                  botones(
                      context, "assets/images/vaca.png", "Vacas", "dash_cow"),
                  botones(
                      context, "assets/images/toro.png", "Toros", "dash_bull"),
                  botones(context, "assets/images/becerro.png", "Becerros",
                      "dash_calf"),
                  listaCards(context)
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: drawer(widget.nombre, widget.correo, imageUsuario),
    );
  }
}
