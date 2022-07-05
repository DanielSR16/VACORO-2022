import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/widgets/HomePage/appBar.dart';
import 'package:vacoro_proyect/src/widgets/HomePage/textoBienvenida.dart';
import '../widgets/HomePage/dashboard.dart';
import '../widgets/HomePage/card_image_text_center.dart';
//import '../services/authFacebook.dart';
//import '../services/authGoogle.dart';


class homePage extends StatefulWidget {
  String nombre;
  homePage({Key? key, required this.nombre}) : super(key: key);

  @override
  State<homePage> createState() => _homePage();
}

class _homePage extends State<homePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbargeneral(widget.nombre, 'assets/images/logo_blanco.png'),
      body: Column(
        children: [
          textoBienvenida(context,0.06,"Seleccione el tipo de ganado que desea visualizar"),
          botones(context,0.12,"assets/images/vaca.png","Vacas"),
          botones(context,0.12,"assets/images/toro.png","Toros"),
          botones(context,0.12,"assets/images/becerro.png","Becerros"),
          listaCards(context,0.25)
        ],
      )
    );
  }

}