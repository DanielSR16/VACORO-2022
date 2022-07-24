import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/model/categorias.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:vacoro_proyect/src/pages/edit_categories_complete.dart';
import 'package:vacoro_proyect/src/services/DAO/categoryBecerroDao.dart';
import '../services/DAO/categorias.dart';
import '../widgets/HomePage/appBar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fancy_containers/fancy_containers.dart';

class editCategories extends StatefulWidget {
  editCategories({Key? key}) : super(key: key);

  @override
  State<editCategories> createState() => _editCategories();
}

class _editCategories extends State<editCategories> {
  final controladorNombre = TextEditingController();
  final controladorDescripcion = TextEditingController();
  late Future<List<Categoria>> listaCat;

  @override
  void initState() {
    listaCat =
        listaCategorias("http://192.168.0.2:3006/categoria/allCategorias");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarCat("Seleccion de categoria",
            'assets/images/logo_blanco.png', context, "this"),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //Uso de mientras
                  selectionCategory(listaCat),
                  Container(margin: EdgeInsets.only(top: 25)),
                  insertarImagen('assets/images/categorias.png'),
                  eleccionCategorias(
                      "Paso 1", "Escoja La Categoria A Administrar"),
                  eleccionCategorias(
                      "Paso 2", "Administre A Los Diferentes Tipos De Ganado"),
                  eleccionCategorias("Paso 3", "Guarda La Informacion"),
                ],
              ),
            )));
  }

  ClipRRect insertarImagen(imagen) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20), // Image border
      child: SizedBox.fromSize(
          size: Size.fromRadius(48), // Image radius
          child: Image.asset(imagen)),
    );
  }

  Container eleccionCategorias(tituloMostrar, Descripcion) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: FancyContainer(
        onTap: () {
          print("Hello World");
        },
        color1: Colors.green,
        color2: Colors.green,
        title: tituloMostrar,
        textcolor: Colors.white,
        subtitle: Descripcion,
        subtitlecolor: Colors.white,
      ),
    );
  }

  Container selectionCategory(listaCategorias) {
    var descripcion;
    var cuerpo;
    var listaBecerrosCat = [];
    List<String> dropdownCategoriaNombre = [];
    return Container(
      margin: EdgeInsets.only(top: 25),
      child: FutureBuilder(
          future: listaCategorias,
          builder: (context, AsyncSnapshot<List<Categoria>> snapshot) {
            if (snapshot.data != null) {
              for (int i = 0; i < snapshot.data!.length; i++) {
                dropdownCategoriaNombre.add(snapshot.data![i].nombreCategoria);
              }
              return DropdownSearch<String>(
                mode: Mode.DIALOG,
                showSearchBox: true,
                showSelectedItem: true,
                hint: "Seleccione una categoria",
                items: dropdownCategoriaNombre,
                label: "Categoria",
                onChanged: ((value) => {
                      for (int i = 0; i < snapshot.data!.length; i++)
                        {
                          if (value!.compareTo(
                                  snapshot.data![i].nombreCategoria) ==
                              0)
                            {
                              descripcion =
                                  snapshot.data![i].descripcionCategoria,
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: editCategoriesComplete(
                                          categoriaSeleccionada:
                                              snapshot.data![i]))),
                            },
                        },
                    }),
              );
            }
            return Container();
          }),
    );
  }
}
