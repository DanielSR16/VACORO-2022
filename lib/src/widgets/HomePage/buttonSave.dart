import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/model/categorias.dart';
import 'package:vacoro_proyect/src/services/DAO/categorias.dart';

import '../../model/becerrosCategorias.dart';
import '../../model/torosCategorias.dart';
import '../../model/vacasCategorias.dart';

creacionCategoria(nombreCategoria, descripcionCategoria, vacas, toros, becerros,
    context) async {
  var body = jsonEncode({
    "nombre": nombreCategoria.text,
    "descripcion": descripcionCategoria.text
  });
  print("666666666666666666666666666666666666666666");
  print(body);
  var categoria;
  try {
    categoria = await addCategoria(
        'http://categorias-vacoro-1164392975.us-east-1.elb.amazonaws.com/categoria/createCategoria',
        body);
  } catch (e) {
    categoria = "";
  }

  List<dynamic> TorosAgregar = [];
  List<dynamic> BecerrosAgregar = [];
  List<dynamic> VacasAgregar = [];

  if (becerros.length > 0 && categoria.length > 0) {
    for (int i = 0; i < becerros.length; i++) {
      var cuerpo = jsonEncode({
        "id_becerro": becerros[i].id,
        "id_categoria": categoria['id']
      }); //"id_vaca": null,"id_toro": null,"id_becerro": null,"id_categoria": 3
      BecerrosAgregar.add(cuerpo);
    }
    await createAnimalCategory(
        "http://categorias-vacoro-1164392975.us-east-1.elb.amazonaws.com/categoria/createCategoryBecerro",
        BecerrosAgregar.toString());
  }
  if (toros.length > 0 && categoria.length > 0) {
    for (int i = 0; i < toros.length; i++) {
      var cuerpo = jsonEncode({
        "id_toro": toros[i].id,
        "id_categoria": categoria['id']
      }); //"id_vaca": null,"id_toro": null,"id_becerro": null,"id_categoria": 3
      TorosAgregar.add(cuerpo);
    }
    await createAnimalCategory(
        "http://categorias-vacoro-1164392975.us-east-1.elb.amazonaws.com/categoria/createCategoryToro",
        TorosAgregar.toString());
  }
  if (vacas.length > 0 && categoria.length > 0) {
    for (int i = 0; i < vacas.length; i++) {
      var cuerpo = jsonEncode({
        "id_vaca": vacas[i].id,
        "id_categoria": categoria['id']
      }); //"id_vaca": null,"id_toro": null,"id_becerro": null,"id_categoria": 3
      VacasAgregar.add(cuerpo);
    }
    await createAnimalCategory(
        "http://categorias-vacoro-1164392975.us-east-1.elb.amazonaws.com/categoria/createCategoryVaca",
        VacasAgregar.toString());
  }

  //  Navigator.pushNamed(context, "dash_category");
}

Container botonGuardar(texto, altura, becerros, vacas, toros, nombreCategoria,
    descripcionCategoria, context) {
  return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: altura),
      height: 50,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          creacionCategoria(nombreCategoria, descripcionCategoria, vacas, toros,
              becerros, context);
          Future.delayed(const Duration(milliseconds: 200), () {
            Navigator.popAndPushNamed(context, 'dash_category');
          });
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0))),
          backgroundColor: MaterialStateProperty.all(Colors.green),
        ),
        child: Text(texto, style: const TextStyle(color: Colors.white)),
      ));
}
