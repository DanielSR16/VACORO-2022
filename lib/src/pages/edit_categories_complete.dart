//var idCategoria = jsonEncode({"id_categoria":widget.categoriaSeleccionada.idCategoria});
//List<Becerros> categoriasBecerro = await listBecerrosByIdCategoria("http://categorias-vacoro-1164392975.us-east-1.elb.amazonaws.com/categoria/findListBecerrosByIdCategory", idCategoria);
import 'dart:async';
import 'dart:convert';
import 'package:fancy_containers/fancy_containers.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vacoro_proyect/src/metodos/becerroCategoriaOpciones.dart';
import 'package:vacoro_proyect/src/metodos/toroCategoriaOpciones.dart';
import 'package:vacoro_proyect/src/model/categorias.dart';
import 'package:vacoro_proyect/src/model/vacasCategorias.dart';
import 'package:vacoro_proyect/src/model/torosCategorias.dart';
import 'package:vacoro_proyect/src/model/becerrosCategorias.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:multiple_search_selection/multiple_search_selection.dart';
import 'package:vacoro_proyect/src/pages/edit_categories.dart';
import 'package:vacoro_proyect/src/services/DAO/categoryToroDao.dart';
import 'package:vacoro_proyect/src/services/DAO/categoryVacaDao.dart';
import 'package:vacoro_proyect/src/widgets/HomePage/dashboard.dart';
import '../metodos/vacaCategoriaOpciones.dart';
import '../services/DAO/becerros.dart';
import '../services/DAO/categorias.dart';
import '../services/DAO/categoryBecerroDao.dart';
import '../services/DAO/toros.dart';
import '../services/DAO/vacas.dart';
import '../widgets/HomePage/appBar.dart';
import '../widgets/HomePage/textfield.dart';

class editCategoriesComplete extends StatefulWidget {
  Categoria categoriaSeleccionada;
  editCategoriesComplete({Key? key, required this.categoriaSeleccionada})
      : super(key: key);

  @override
  State<editCategoriesComplete> createState() => _editCategoriesComplete();
}

class _editCategoriesComplete extends State<editCategoriesComplete> {
  final controladorNombre = TextEditingController();
  final controladorDescripcion = TextEditingController();

  late Future<List<Categoria>> Cat;
  late Future<List<Becerros>> listaB;
  late Future<List<Vacas>> listaV;
  late Future<List<Toros>> listaT;

  List<Becerros> becerroEleccion = [];
  List<Becerros> comparacionBecerros = [];

  List<Becerros> vacaEleccion = [];
  List<Becerros> toroEleccion = [];

  @override
  void initState() {
    Cat = listaCategorias(
        "http://categorias-vacoro-1164392975.us-east-1.elb.amazonaws.com/categoria/allCategorias");
    listaB = listaBecerros(
        "http://categorias-vacoro-1164392975.us-east-1.elb.amazonaws.com/categoria/allCategorias/allBecerros");
    listaV = listaVacas(
        "http://categorias-vacoro-1164392975.us-east-1.elb.amazonaws.com/categoria/allCategorias/allVacas");
    listaT = listaToros(
        "http://categorias-vacoro-1164392975.us-east-1.elb.amazonaws.com/categoria/allCategorias/allToros");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarCat("Ver y Editar Categoria",
            'assets/images/logo_blanco.png', context, "editar_categoria"),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  selectionCategory(
                      Cat, widget.categoriaSeleccionada.nombreCategoria),
                  textfieldCategoria(
                      "Nombrar Nueva Categoria (Opcional)",
                      "Ingrese nombre de la categoria",
                      25.0,
                      controladorNombre,
                      context,
                      "Nombre Actual: " +
                          widget.categoriaSeleccionada.nombreCategoria),
                  textfieldCategoria(
                      "Descripcion De La Categoria (Opcional)",
                      "Ingrese nombre de la descripcion",
                      0.0,
                      controladorDescripcion,
                      context,
                      "Descripcion Actual: " +
                          widget.categoriaSeleccionada.descripcionCategoria),
                  botones(context, "assets/images/vaca.png", "Vacas", "vaca"),
                  botones(context, "assets/images/toro.png", "Toros", "toro"),
                  botones(context, "assets/images/becerro.png", "Becerros",
                      "becerro"),
                  deleteCat("Eliminar Categoria", 30.0,
                      widget.categoriaSeleccionada.idCategoria),
                  guardarCategoria(
                      20.0,
                      widget.categoriaSeleccionada.idCategoria,
                      controladorNombre.text,
                      controladorDescripcion.text,
                      "Editar"),
                ],
              ),
            )));
  }

  Container selectionCategory(listaCategorias, inicialValue) {
    var descripcion;
    List<String> dropdownCategoriaNombre = [];
    return Container(
      margin: EdgeInsets.only(top: 25),
      child: FutureBuilder(
          future: Cat,
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
                selectedItem: inicialValue,
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

  Container botones(context, imagen, texto, tipo) {
    var idCategoriaB;
    var idCategoriaT;
    var idCategoriaV;
    List<Becerros> listaBecerrosPorCategoria;
    List<Toros> listaTorosPorCategoria;
    List<Vacas> listaVacasPorCategoria;
    return Container(
      margin: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: HexColor("#68C34E")),
        onPressed: () async => {
          if (tipo == "becerro")
            {
              idCategoriaB = jsonEncode(
                  {"id_categoria": widget.categoriaSeleccionada.idCategoria}),
              listaBecerrosPorCategoria = await listBecerrosByIdCategoria(
                  "http://categorias-vacoro-1164392975.us-east-1.elb.amazonaws.com/categoria/findListBecerrosByIdCategory",
                  idCategoriaB),
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      child: becerroEditar(
                          lista_de_becerros: listaBecerrosPorCategoria,
                          categoriaSeleccionada:
                              widget.categoriaSeleccionada))),
            },
          if (tipo == "vaca")
            {
              idCategoriaV = jsonEncode(
                  {"id_categoria": widget.categoriaSeleccionada.idCategoria}),
              listaVacasPorCategoria = await listVacasByIdCategoria(
                  "http://categorias-vacoro-1164392975.us-east-1.elb.amazonaws.com/categoria/findListVacasByIdCategory",
                  idCategoriaV),
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      child: vacaEditar(
                          lista_de_vacas: listaVacasPorCategoria,
                          categoriaSeleccionada:
                              widget.categoriaSeleccionada))),
            },
          if (tipo == "toro")
            {
              idCategoriaT = jsonEncode(
                  {"id_categoria": widget.categoriaSeleccionada.idCategoria}),
              listaTorosPorCategoria = await listTorosByIdCategoria(
                  "http://categorias-vacoro-1164392975.us-east-1.elb.amazonaws.com/categoria/findListTorosByIdCategory",
                  idCategoriaT),
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      child: toroEditar(
                          lista_de_toros: listaTorosPorCategoria,
                          categoriaSeleccionada:
                              widget.categoriaSeleccionada))),
            }
        },
        child: Container(
          padding: const EdgeInsets.only(top: 20.0, bottom: 20),
          child: Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Image(
                  image: AssetImage(imagen),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 30.0),
                  child: Text(
                    texto,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20.0),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Container guardarCategoria(altura, id, nombre, descripcion, nombreTexto) {
    return Container(
      margin: EdgeInsets.only(top: altura),
      child: ElevatedButton(
        onPressed: () {
          if (nombre.isEmpty) {
            nombre = widget.categoriaSeleccionada.nombreCategoria;
          }
          if (descripcion.isEmpty) {
            descripcion = widget.categoriaSeleccionada.descripcionCategoria;
          }
          Widget cancelButton = ElevatedButton(
            child: Text("Cancelar"),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          );
          Widget continueButton = ElevatedButton(
            child: Text("Actualizar Categoria"),
            onPressed: () async {
              var actualizoCategoria = jsonEncode(
                  {"id": id, "nombre": nombre, "descripcion": descripcion});
              await AccionarCategoria_edito_elimino(
                  'http://categorias-vacoro-1164392975.us-east-1.elb.amazonaws.com/categoria/updatecategoria',
                  actualizoCategoria);
              Navigator.pop(context);
              setState(() {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => editCategories()));
              });
            },
          );
          // set up the AlertDialog
          AlertDialog alert = AlertDialog(
            title: Text("Actualizar Categoria"),
            content: Text("Te gustaria Actualizar La categoria " +
                widget.categoriaSeleccionada.nombreCategoria),
            actions: [
              cancelButton,
              continueButton,
            ],
          );
          // show the dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
        },
        child: Text(nombreTexto),
      ),
    );
  }

  Container deleteCat(texto, altura, idCategoria) {
    return Container(
      margin: EdgeInsets.only(right: 15, top: altura),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            child: TextButton(
              child: Text(texto + "     "),
              onPressed: () async {
                Widget cancelButton = ElevatedButton(
                  child: Text("Cancelar"),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                );
                Widget continueButton = ElevatedButton(
                  child: Text("Eliminar"),
                  onPressed: () async {
                    var idBorrar = jsonEncode({"id": idCategoria});
                    await AccionarCategoria_edito_elimino(
                        'http://categorias-vacoro-1164392975.us-east-1.elb.amazonaws.com/categoria/deleteCategoria',
                        idBorrar);
                    Navigator.pop(context);
                    setState(() {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  editCategories()));
                    });
                  },
                );
                // set up the AlertDialog
                AlertDialog alert = AlertDialog(
                  title: Text("Eliminar Categoria"),
                  content: Text("Te gustaria Eliminar La categoria " +
                      widget.categoriaSeleccionada.nombreCategoria),
                  actions: [
                    cancelButton,
                    continueButton,
                  ],
                );
                // show the dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
              },
            ),
          ),
          GestureDetector(
            child: Icon(Icons.delete, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
