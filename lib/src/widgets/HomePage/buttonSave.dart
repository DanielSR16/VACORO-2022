import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/model/categorias.dart';
import 'package:vacoro_proyect/src/services/DAO/categorias.dart';

import '../../model/becerrosCategorias.dart';
import '../../model/torosCategorias.dart';
import '../../model/vacasCategorias.dart';

creacionCategoria(nombreCategoria,descripcionCategoria,vacas,toros,becerros,context) async {
  var body = jsonEncode({"id_usuario":2,"nombre": nombreCategoria.text, "descripcion":descripcionCategoria.text});
  print(body);
  var categoria = await addCategoria('http://192.168.100.6:3006/categoria/createCategoria',body);

  List<dynamic> TorosAgregar = [];
  List<dynamic> BecerrosAgregar = [];
  List<dynamic> VacasAgregar = [];

  if (becerros.length > 0){
    for (int i=0; i<becerros.length; i++){
      var cuerpo = jsonEncode({"id_becerro": becerros[i].id, "id_categoria":categoria['id'], "id_usuario":2}); //"id_vaca": null,"id_toro": null,"id_becerro": null,"id_categoria": 3
      BecerrosAgregar.add(cuerpo);
    }
    await createAnimalCategory("http://192.168.100.6:3006/categoria/createCategoryBecerro", BecerrosAgregar.toString());
  }
  if (toros.length > 0){
    for (int i=0; i<toros.length; i++){
      var cuerpo = jsonEncode({"id_toro": toros[i].id, "id_categoria":categoria['id'],"id_usuario":2}); //"id_vaca": null,"id_toro": null,"id_becerro": null,"id_categoria": 3
      TorosAgregar.add(cuerpo);
    }
    await createAnimalCategory("http://192.168.100.6:3006/categoria/createCategoryToro", TorosAgregar.toString());
  }
  if (vacas.length > 0){
    for (int i=0; i<vacas.length; i++){
      var cuerpo = jsonEncode({"id_vaca": vacas[i].id, "id_categoria":categoria['id'], "id_usuario":2}); //"id_vaca": null,"id_toro": null,"id_becerro": null,"id_categoria": 3
      VacasAgregar.add(cuerpo);
    }
    await createAnimalCategory("http://192.168.100.6:3006/categoria/createCategoryVaca", VacasAgregar.toString());
  }
  //Navigator.pushNamed(context, "login");
}

Container botonGuardar(texto,altura,becerros,vacas,toros,nombreCategoria,descripcionCategoria,context){
  return Container(
    margin: EdgeInsets.only(left: 30, right: 30, top: altura),
    height: 50,
    width: double.infinity,
    child: OutlinedButton(
      onPressed: (){
        creacionCategoria(nombreCategoria,descripcionCategoria,vacas,toros,becerros,context);
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
        backgroundColor: MaterialStateProperty.all(Colors.green),
      ),
      child: Text(texto, style: const TextStyle(color: Colors.white)),
    )
  );
}