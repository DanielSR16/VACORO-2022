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
