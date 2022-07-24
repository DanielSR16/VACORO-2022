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
import 'package:vacoro_proyect/src/services/DAO/vacas.dart';
import 'package:vacoro_proyect/src/style/colors/colorview.dart';
import '../model/becerrosCategorias.dart';
import '../model/categorias.dart';
import '../model/torosCategorias.dart';
import '../model/vacasCategorias.dart';
import '../pages/edit_categories_complete.dart';

import '../widgets/HomePage/appBar.dart';

class vacaEditar extends StatefulWidget {
  List<Vacas> lista_de_vacas;
  Categoria categoriaSeleccionada;
  vacaEditar(
      {Key? key,
      required this.lista_de_vacas,
      required this.categoriaSeleccionada})
      : super(key: key);
  @override
  State<vacaEditar> createState() => _vacaEditar();
}

class _vacaEditar extends State<vacaEditar> {
  List<Vacas> vacasMostrar = [];
  List<Vacas> vacasTotales = [];
  String aceptacion = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarCat("Vacas", 'assets/images/vaca.png', context, "this"),
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SearchableList<Vacas>(
                    onRefresh: () async {
                      setState(() {
                        widget.lista_de_vacas = widget.lista_de_vacas;
                      });
                    },
                    initialList: widget.lista_de_vacas,
                    builder: (Vacas vacas) => VacaItem(vaca: vacas),
                    filter: _filterVacaList,
                    emptyWidget: EmptyView(
                        categoriaSeleccionada: widget.categoriaSeleccionada),
                    onItemSelected: (Vacas item) async {
                      // set up the buttons
                      Widget cancelButton = ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: ColorSelect.color5),
                        child: const Text(
                          "Cancelar",
                          style: TextStyle(color: Colors.white),
                        ),
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
                            "id_vaca": item.id,
                            "id_categoria":
                                widget.categoriaSeleccionada.idCategoria
                          }); //update con todo y categoria
                          var buscarAnimal = await updateBecerroByCategory(
                              "http:/categorias-vacoro-1164392975.us-east-1.elb.amazonaws.com/categoria/findCategoryVacaByIdVaca",
                              eliminarAnimal);
                          var cuerpoEliminar =
                              jsonEncode({"id": buscarAnimal['id']});
                          var x = await deleteAnimalCategoryById(
                              "http:/categorias-vacoro-1164392975.us-east-1.elb.amazonaws.com/categoria/deleteVacaByCategory",
                              cuerpoEliminar);
                          Navigator.of(context).pop(true);
                          widget.lista_de_vacas.remove(item);
                          setState(() {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        vacaEditar(
                                            lista_de_vacas:
                                                widget.lista_de_vacas,
                                            categoriaSeleccionada:
                                                widget.categoriaSeleccionada)));
                          });
                        },
                      );
                      // set up the AlertDialog
                      AlertDialog alert = AlertDialog(
                        title: const Text("Eliminar vaca",
                            style: TextStyle(color: ColorSelect.color5)),
                        content: Text(
                            "Te gustaria eliminar la vaca " +
                                item.nombre +
                                " Con numero de arete " +
                                item.num_arete,
                            style: TextStyle(color: ColorSelect.color1)),
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
                      labelText: "Buscar vaca",
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
                      vacasTotales = await listaVacas(
                          "http:/categorias-vacoro-1164392975.us-east-1.elb.amazonaws.com/categoria/allCategorias/allVacas");
                      var animalesFaltantes = buscarAnimalesFaltantes(
                          widget.lista_de_vacas, vacasTotales);
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

  buscarAnimalesFaltantes(listaVacas, vacasTotales) {
    List<int> listaids = [];
    List<String> animalesFaltantes = [];
    for (int i = 0; i < listaVacas.length; i++) {
      listaids.add(listaVacas[i].id);
    }
    print(listaids);
    for (int i = 0; i < vacasTotales.length; i++) {
      if (!listaids.contains(vacasTotales[i].id)) {
        animalesFaltantes.add("Id de la vaca: " +
            vacasTotales[i].id.toString() +
            "\nnumero de arete: " +
            vacasTotales[i].num_arete +
            "\nnombre de la vaca: " +
            vacasTotales[i].nombre);
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
        title: const Text(
          "Confirmación",
          style: TextStyle(color: ColorSelect.color5),
        ),
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
                  "id_vaca": idOpcion,
                  "id_categoria": widget.categoriaSeleccionada.idCategoria
                });
                var agrego = await updateBecerroByCategory(
                    "http:/categorias-vacoro-1164392975.us-east-1.elb.amazonaws.com/categoria/updateVacaByCategory",
                    cuerpoAgregar);
                var id = jsonEncode({"id_vaca": idOpcion});
                var infoAnimal = await infoAnimalById(
                    "http:/categorias-vacoro-1164392975.us-east-1.elb.amazonaws.com/categoria/findByIdVaca",
                    id); //aca
                print(infoAnimal);
                Vacas addvaca = Vacas(
                    id: infoAnimal['id'],
                    id_usuario: infoAnimal['id_usuario'],
                    nombre: infoAnimal['nombre'],
                    descripcion: infoAnimal['descripcion'],
                    raza: infoAnimal['raza'],
                    num_arete: infoAnimal['num_arete'],
                    estado: infoAnimal['estado'],
                    fecha_llegada: infoAnimal['fecha_llegada'],
                    edad: infoAnimal['edad']);
                Navigator.of(context).pop(true);
                widget.lista_de_vacas.add(addvaca);
                setState(() {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => vacaEditar(
                              lista_de_vacas: widget.lista_de_vacas,
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

  List<Vacas> _filterVacaList(String searchTerm) {
    return widget.lista_de_vacas
        .where((element) => element.nombre.toLowerCase().contains(searchTerm))
        .toList();
  }
}

class VacaItem extends StatelessWidget {
  final Vacas vaca;

  const VacaItem({
    Key? key,
    required this.vaca,
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
              image: AssetImage('assets/images/vaca.png'),
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
                  'Núm. de arete: ${vaca.num_arete}',
                  style: const TextStyle(
                    color: ColorSelect.color1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Nombre: ${vaca.nombre}',
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
        const Icon(
          Icons.error,
          color: Colors.red,
        ),
        Text('No se encontro ninguna vaca agregada a la categoria ' +
            categoriaSeleccionada.nombreCategoria),
      ],
    );
  }
}
