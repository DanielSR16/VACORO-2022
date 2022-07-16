import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Container botonGuardar(texto,altura){
  return Container(
    margin: EdgeInsets.only(left: 30, right: 30, top: altura),
    height: 50,
    width: double.infinity,
    child: OutlinedButton(
      onPressed: (){},
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
        backgroundColor: MaterialStateProperty.all(Colors.green),
      ),
      child: Text(texto, style: const TextStyle(color: Colors.white)),
    )
  );
}