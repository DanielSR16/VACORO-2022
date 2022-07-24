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
import 'package:vacoro_proyect/src/style/colors/colorview.dart';
import 'package:vacoro_proyect/src/widgets/HomePage/appBar.dart';
import '../model/becerrosCategorias.dart';
import '../model/categorias.dart';
import '../pages/edit_categories_complete.dart';

class becerroEditar extends StatefulWidget {
  List<Becerros> lista_de_becerros;
  Categoria categoriaSeleccionada;
  becerroEditar(
      {Key? key,
      required this.lista_de_becerros,
      required this.categoriaSeleccionada})
      : super(key: key);
  @override
  State<becerroEditar> createState() => _becerroEditar();
}

class _becerroEditar extends State<becerroEditar> {
  List<Becerros> BecerrosMostrar = [];
  List<Becerros> BecerrosTotales = [];
  String aceptacion = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            appbarCat("Becerros", 'assets/images/becerro.png', context, "this"),
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SearchableList<Becerros>(
                    onRefresh: () async {
                      setState(() {
                        widget.lista_de_becerros = widget.lista_de_becerros;
                      });
                    },
                    initialList: widget.lista_de_becerros,
                    builder: (Becerros becerros) =>
                        BecerroItem(becerro: becerros),
                    filter: _filterBecerroList,
                    emptyWidget: EmptyView(
                        categoriaSeleccionada: widget.categoriaSeleccionada),
                    onItemSelected: (Becerros item) async {
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
                            "id_becerro": item.id,
                            "id_categoria":
                                widget.categoriaSeleccionada.idCategoria
                          }); //update con todo y categoria
                          var buscarAnimal = await updateBecerroByCategory(
                              "http://categorias-vacoro-1164392975.us-east-1.elb.amazonaws.com/categoria/findCategoryBecerroByIdBecerro",
                              eliminarAnimal);
                          var cuerpoEliminar =
                              jsonEncode({"id": buscarAnimal['id']});
                          var x = await deleteAnimalCategoryById(
                              "http://categorias-vacoro-1164392975.us-east-1.elb.amazonaws.com/categoria/deleteBecerroByCategory",
                              cuerpoEliminar);
                          Navigator.of(context).pop(true);
                          widget.lista_de_becerros.remove(item);
                          setState(() {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        becerroEditar(
                                            lista_de_becerros:
                                                widget.lista_de_becerros,
                                            categoriaSeleccionada:
                                                widget.categoriaSeleccionada)));
                          });
                        },
                      );
                      // set up the AlertDialog
                      AlertDialog alert = AlertDialog(
                        title: const Text("Eliminar becerro",
                            style: TextStyle(color: ColorSelect.color5)),
                        content: Text(
                            "Te gustaria eliminar el becerro " +
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
                      labelText: "Buscar becerro",
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
                      BecerrosTotales = await listaBecerros(
                          "http://categorias-vacoro-1164392975.us-east-1.elb.amazonaws.com/categoria/allCategorias/allBecerros");
                      var animalesFaltantes = buscarAnimalesFaltantes(
                          widget.lista_de_becerros, BecerrosTotales);
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

  buscarAnimalesFaltantes(listaBecerros, BecerrosTotales) {
    List<int> listaids = [];
    List<String> animalesFaltantes = [];

    for (int i = 0; i < listaBecerros.length; i++) {
      listaids.add(listaBecerros[i].id);
    }
    print(listaids);
    for (int i = 0; i < BecerrosTotales.length; i++) {
      if (!listaids.contains(BecerrosTotales[i].id)) {
        animalesFaltantes.add("Id del becerro: " +
            BecerrosTotales[i].id.toString() +
            "\nnumero de arete: " +
            BecerrosTotales[i].num_arete +
            "\nnombre del becerro: " +
            BecerrosTotales[i].nombre);
      }
    }
    print("termino todo: ");
    print(animalesFaltantes);
    return animalesFaltantes;
  }

  dialogAgregar(List<String> animalesFaltantes) async {
    await DialogBackground(
      dialog: AlertDialog(
        title: const Text("Confirmación",
            style: TextStyle(color: ColorSelect.color5)),
        content: const Text("Seleccione el animal a agregar",
            style: TextStyle(color: ColorSelect.color1)),
        actions: <Widget>[
          SeleccionAnimalesFaltantes(animalesFaltantes),
          const SizedBox(
            height: 50,
          ),
          FloatingActionButton(
            onPressed: () async {
              if (aceptacion.length > 0) {
                List<String> result = aceptacion.split('\n');
                int idOpcion =
                    int.parse(result[0].replaceAll(new RegExp(r'[^0-9]'), ''));
                var cuerpoAgregar = jsonEncode({
                  "id_becerro": idOpcion,
                  "id_categoria": widget.categoriaSeleccionada.idCategoria
                });
                var agrego = await updateBecerroByCategory(
                    "http://categorias-vacoro-1164392975.us-east-1.elb.amazonaws.com/categoria/updateBecerroByCategory",
                    cuerpoAgregar);
                var id = jsonEncode({"id_becerro": idOpcion});
                var infoAnimal = await infoAnimalById(
                    "http://categorias-vacoro-1164392975.us-east-1.elb.amazonaws.com/categoria/findByIdBecerro",
                    id);
                Becerros addbecerro = Becerros(
                    id: infoAnimal['id'],
                    id_usuario: infoAnimal['id_usuario'],
                    nombre: infoAnimal['nombre'],
                    descripcion: infoAnimal['descripcion'],
                    raza: infoAnimal['raza'],
                    num_arete: infoAnimal['num_arete'],
                    // url_img: infoAnimal['url_img'],
                    estado: infoAnimal['estado'],
                    fecha_llegada: infoAnimal['fecha_llegada'],
                    id_vaca: infoAnimal['id_vaca'],
                    edad: infoAnimal['edad']);
                Navigator.of(context).pop(true);
                widget.lista_de_becerros.add(addbecerro);
                setState(() {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => becerroEditar(
                              lista_de_becerros: widget.lista_de_becerros,
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

  List<Becerros> _filterBecerroList(String searchTerm) {
    return widget.lista_de_becerros
        .where((element) => element.nombre.toLowerCase().contains(searchTerm))
        .toList();
  }
}

class BecerroItem extends StatelessWidget {
  final Becerros becerro;

  const BecerroItem({
    Key? key,
    required this.becerro,
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
              image: AssetImage('assets/images/becerro.png'),
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
                  'Núm. de arete: ${becerro.num_arete}',
                  style: const TextStyle(
                    color: ColorSelect.color1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Nombre: ${becerro.nombre}',
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
        Text('No se encontro ningun becerro agregado a la categoria ' +
            categoriaSeleccionada.nombreCategoria),
      ],
    );
  }
}
