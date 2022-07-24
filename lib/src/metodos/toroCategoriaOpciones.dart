import 'dart:async';
import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vacoro_proyect/src/services/DAO/becerros.dart';
import 'package:vacoro_proyect/src/services/DAO/categorias.dart';
import 'package:flutter/material.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:ndialog/ndialog.dart';
import 'package:vacoro_proyect/src/services/DAO/categoryBecerroDao.dart';
import 'package:vacoro_proyect/src/services/DAO/categoryToroDao.dart';
import 'package:vacoro_proyect/src/services/DAO/toros.dart';
import '../model/becerrosCategorias.dart';
import '../model/categorias.dart';
import '../model/torosCategorias.dart';
import '../pages/edit_categories_complete.dart';

import '../style/colors/colorview.dart';
import '../widgets/HomePage/appBar.dart';

class toroEditar extends StatefulWidget {
  List<Toros> lista_de_toros;
  Categoria categoriaSeleccionada;
  toroEditar(
      {Key? key,
      required this.lista_de_toros,
      required this.categoriaSeleccionada})
      : super(key: key);
  @override
  State<toroEditar> createState() => _toroEditar();
}

class _toroEditar extends State<toroEditar> {
  List<Toros> torosMostrar = [];
  List<Toros> torosTotales = [];
  String aceptacion = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarCat("Toros", 'assets/images/toro.png', context, "this"),
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SearchableList<Toros>(
                    onRefresh: () async {
                      setState(() {
                        widget.lista_de_toros = widget.lista_de_toros;
                      });
                    },
                    initialList: widget.lista_de_toros,
                    builder: (Toros toros) => ToroItem(toro: toros),
                    filter: _filterToroList,
                    emptyWidget: EmptyView(
                        categoriaSeleccionada: widget.categoriaSeleccionada),
                    onItemSelected: (Toros item) async {
                      // set up the buttons
                      Widget cancelButton = ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: ColorSelect.color5),
                        child: const Text("Cancelar",
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      );
                      Widget continueButton = ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: ColorSelect.color5),
                        child: const Text("Eliminar",
                            style: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          var eliminarAnimal = jsonEncode({
                            "id_toro": item.id,
                            "id_categoria":
                                widget.categoriaSeleccionada.idCategoria
                          }); //update con todo y categoria
                          var buscarAnimal = await updateBecerroByCategory(
                              "http://192.168.0.2:3006/categoria/findCategoryToroByIdToro",
                              eliminarAnimal);
                          var cuerpoEliminar =
                              jsonEncode({"id": buscarAnimal['id']});
                          var x = await deleteAnimalCategoryById(
                              "http://192.168.0.2:3006/categoria/deleteToroByCategory",
                              cuerpoEliminar);
                          Navigator.of(context).pop(true);
                          widget.lista_de_toros.remove(item);
                          setState(() {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        toroEditar(
                                            lista_de_toros:
                                                widget.lista_de_toros,
                                            categoriaSeleccionada:
                                                widget.categoriaSeleccionada)));
                          });
                        },
                      );
                      // set up the AlertDialog
                      AlertDialog alert = AlertDialog(
                        title: const Text("Eliminar toro",
                            style: TextStyle(color: ColorSelect.color5)),
                        content: Text(
                            "Te gustaria eliminar el toro " +
                                item.nombre +
                                " con numero de arete " +
                                item.num_arete,
                            style: const TextStyle(color: ColorSelect.color1)),
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
                    inputDecoration: InputDecoration(
                      labelText: "Buscar toro",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: ColorSelect.color5,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.only(bottom: 15, right: 15),
                  child: FloatingActionButton(
                    onPressed: () async {
                      torosTotales = await listaToros(
                          "http://192.168.0.2:3006/categoria/allCategorias/allToros");
                      var animalesFaltantes = buscarAnimalesFaltantes(
                          widget.lista_de_toros, torosTotales);
                      dialogAgregar(animalesFaltantes);
                    },
                    backgroundColor: Colors.green,
                    child: const Icon(Icons.add),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  buscarAnimalesFaltantes(listaToros, torosTotales) {
    List<int> listaids = [];
    List<String> animalesFaltantes = [];
    for (int i = 0; i < listaToros.length; i++) {
      listaids.add(listaToros[i].id);
    }
    print(listaids);
    for (int i = 0; i < torosTotales.length; i++) {
      if (!listaids.contains(torosTotales[i].id)) {
        animalesFaltantes.add("Id del toro: " +
            torosTotales[i].id.toString() +
            "\nnumero de arete: " +
            torosTotales[i].num_arete +
            "\nnombre del toro: " +
            torosTotales[i].nombre);
      }
    }
    print("termino todo");
    print(animalesFaltantes);
    return animalesFaltantes;
  }

  dialogAgregar(List<String> animalesFaltantes) async {
    print(animalesFaltantes);
    await DialogBackground(
      dialog: AlertDialog(
        title: Text("Confirmacion"),
        content: Text("Seleccione el animal a agregar"),
        actions: <Widget>[
          SeleccionAnimalesFaltantes(animalesFaltantes),
          SizedBox(
            height: 50,
          ),
          FloatingActionButton(
            onPressed: () async {
              if (aceptacion.length > 0) {
                List<String> result = aceptacion.split('\n');
                int idOpcion =
                    int.parse(result[0].replaceAll(new RegExp(r'[^0-9]'), ''));
                var cuerpoAgregar = jsonEncode({
                  "id_toro": idOpcion,
                  "id_categoria": widget.categoriaSeleccionada.idCategoria
                });
                var agrego = await updateBecerroByCategory(
                    "http://192.168.0.2:3006/categoria/updateToroByCategory",
                    cuerpoAgregar);
                var id = jsonEncode({"id_toro": idOpcion});
                var infoAnimal = await infoAnimalById(
                    "http://192.168.0.2:3006/categoria/findByIdToro", id); //aca
                print(infoAnimal);
                Toros addtoro = Toros(
                    id: infoAnimal['id'],
                    id_usuario: infoAnimal['id_usuario'],
                    nombre: infoAnimal['nombre'],
                    descripcion: infoAnimal['descripcion'],
                    raza: infoAnimal['raza'],
                    num_arete: infoAnimal['num_arete'],
                    // url_img: infoAnimal['url_img'],
                    estado: infoAnimal['estado'],
                    fecha_llegada: infoAnimal['fecha_llegada'],
                    edad: infoAnimal['edad']);
                Navigator.of(context).pop(true);
                widget.lista_de_toros.add(addtoro);
                setState(() {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => toroEditar(
                              lista_de_toros: widget.lista_de_toros,
                              categoriaSeleccionada:
                                  widget.categoriaSeleccionada)));
                });
              }
            },
            backgroundColor: Colors.green,
            child: const Icon(Icons.check),
          )
        ],
      ),
    ).show(context);
  }

  DropdownSearch SeleccionAnimalesFaltantes(items) {
    return DropdownSearch<String>(
      mode: Mode.DIALOG,
      showSearchBox: true,
      showSelectedItem: true,
      hint: "Seleccione a continuacion",
      items: items,
      label: "Seleccione el animal",
      onChanged: ((value) => {
            aceptacion = value!,
          }),
    );
  }

  List<Toros> _filterToroList(String searchTerm) {
    return widget.lista_de_toros
        .where((element) => element.nombre.toLowerCase().contains(searchTerm))
        .toList();
  }
}

class ToroItem extends StatelessWidget {
  final Toros toro;

  const ToroItem({
    Key? key,
    required this.toro,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            const Image(
              image: AssetImage('assets/images/toro.png'),
              width: 25,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Núm. de arete: ${toro.num_arete}',
                  style: const TextStyle(
                    color: ColorSelect.color1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Nombre: ${toro.nombre}',
                  style: const TextStyle(
                    color: ColorSelect.color1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyView extends StatelessWidget {
  Categoria categoriaSeleccionada;
  EmptyView({Key? key, required this.categoriaSeleccionada}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          color: Colors.red,
        ),
        Text('No se encontro ningun Toro agregado a la categoria ' +
            categoriaSeleccionada.nombreCategoria),
      ],
    );
  }
}
