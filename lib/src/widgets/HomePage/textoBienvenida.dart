import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Container textoBienvenida(context,texto){
  return Container(
    margin: EdgeInsets.only(top: 15, left: 30, right: 30, bottom: 15),
    width: double.infinity,
    child: Text(
      texto,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: HexColor("#3E762F"),
          fontSize: 20,
          fontWeight: FontWeight.bold
      ),
    )
  );
}