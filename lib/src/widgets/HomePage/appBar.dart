import 'package:flutter/material.dart';

AppBar appbargeneral(nombre, imagen) {
  return AppBar(
    centerTitle: true,
    title: Text("Bienvenido: " + nombre),
    actions: [
      Container(
        padding: const EdgeInsets.only(left: 30),
        width: 85,
        child: Image.asset(imagen),
      )
    ],
    backgroundColor: Colors.green,
  );
}

AppBar appbarCat(nombre, imagen, context, ruta) {
  return AppBar(
    centerTitle: true,
    title: Text(nombre),
    leading: SizedBox(
      child: IconButton(
        splashRadius: 15,
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 40,
        ),
        onPressed: () {
          if (ruta == "this"){
            Navigator.pop(context);
          }else{
            Navigator.pushNamed(context, ruta);
          }
        },
      ),
    ),
    actions: [
      Container(
        padding: const EdgeInsets.only(left: 30),
        width: 85,
        child: Image.asset(imagen),
      )
    ],
    backgroundColor: Colors.green,
  );
}
