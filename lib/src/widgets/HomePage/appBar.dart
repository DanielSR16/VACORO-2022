import 'package:flutter/material.dart';

AppBar appbargeneral(nombre,imagen){
  return  AppBar(
        centerTitle: true,
        title: Text("Bienvenido: "+nombre),
        leading: SizedBox(
          child: IconButton(
            splashRadius: 15,
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 40,
            ),
            onPressed: () {
              print("object");
              //Navigator.pop(context);
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