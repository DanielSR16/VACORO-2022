import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Container textfieldCategoria(label,textfield,altura,controlador,context,textoMostrar){
  return Container(
    height: MediaQuery.of(context).size.height * 0.18,
    margin: EdgeInsets.only(left: 15, right: 15, top: altura),
    child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.04,
            child: Align(
            alignment: Alignment.topLeft,
            child: Text(label, style: TextStyle(color: HexColor("#3E762F"), fontWeight: FontWeight.bold),),
            ),
          ),
          Container(
          height: MediaQuery.of(context).size.height * 0.10,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 15),
          child: TextField(
            controller: controlador,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: textfield,
              helperText: textoMostrar
            ),
          ),
          )
        ],
      ),
  );
}

Container seleccionLabel(texto,altura){
  return Container(
    margin: EdgeInsets.only(left: 15, right: 15, top: altura),
    child: Text(texto, style: TextStyle(color: HexColor("#3E762F"), fontWeight: FontWeight.bold)),
  );
}

