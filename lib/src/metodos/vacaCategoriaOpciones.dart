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
import '../model/becerrosCategorias.dart';
import '../model/categorias.dart';
import '../model/torosCategorias.dart';
import '../model/vacasCategorias.dart';
import '../pages/edit_categories_complete.dart';
import '../widgets/HomePage/appBar.dart';

class vacaEditar extends StatefulWidget {
  List<Vacas> lista_de_vacas;
  Categoria categoriaSeleccionada;
  vacaEditar({Key? key,required this.lista_de_vacas,required this.categoriaSeleccionada}): super(key: key);
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
                    emptyWidget: EmptyView(categoriaSeleccionada: widget.categoriaSeleccionada),
                    onItemSelected: (Vacas item) async {
                      // set up the buttons
                      Widget cancelButton = ElevatedButton(
                        child: Text("Cancelar"),
                        onPressed:  () {Navigator.of(context).pop(true);},
                      );
                      Widget continueButton = ElevatedButton(
                        child: Text("Eliminar"),
                        onPressed:  () async {
                          var cuerpoEliminar = jsonEncode({"id_categoria":widget.categoriaSeleccionada.idCategoria,"id_vaca":item.id,"id_usuario":2});
                          var x = await deleteAnimalCategoryById("http://192.168.100.6:3006/categoria/deleteVacaByCategory", cuerpoEliminar);
                          Navigator.of(context).pop(true);
                          widget.lista_de_vacas.remove(item);
                          setState(() {
                            Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) => vacaEditar(lista_de_vacas: widget.lista_de_vacas, categoriaSeleccionada: widget.categoriaSeleccionada)));
                          });
                        },
                      );
                      // set up the AlertDialog
                      AlertDialog alert = AlertDialog(
                        title: Text("Eliminar Vaca"),
                        content: Text("Te gustaria Eliminar La Vaca "+item.nombre+" Con Numero De Arete "+item.num_arete),
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
                      labelText: "Buscar Vaca",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue, width: 2.0,),
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
                    vacasTotales = await listaVacasTotal("http://192.168.100.6:3006/categoria/allCategorias/allVacas",2);
                    var animalesFaltantes = buscarAnimalesFaltantes(widget.lista_de_vacas, vacasTotales);
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

  buscarAnimalesFaltantes(listaVacas,vacasTotales) {
    List<int> listaids = [];
    List<String> animalesFaltantes = [];
    for (int i = 0; i < listaVacas.length; i++) {
      listaids.add(listaVacas[i].id);
    }
    print(listaids);
    for (int i = 0; i < vacasTotales.length; i++) {
      if (!listaids.contains(vacasTotales[i].id)) {
        animalesFaltantes.add("Id De La Vaca: " +
            vacasTotales[i].id.toString() +
            "\nNumero De Arete: " +
            vacasTotales[i].num_arete +
            "\nNombre De La Vaca: " +
            vacasTotales[i].nombre);
      }
    }
    print("termino todo");
    print(animalesFaltantes);
    return animalesFaltantes;
  }

  dialogAgregar(List<String>animalesFaltantes) async {
    print(animalesFaltantes);
    await DialogBackground(
      dialog: AlertDialog(
        title: Text("Confirmacion"),
        content: Text("Seleccione el animal a agregar"),
        actions: <Widget>[
          SeleccionAnimalesFaltantes(animalesFaltantes),
          SizedBox(height: 50,),
          FloatingActionButton(
            onPressed: () async {
              if (aceptacion.length > 0) {
                List<String> result = aceptacion.split('\n');
                int idOpcion = int.parse(result[0].replaceAll(new RegExp(r'[^0-9]'), ''));
                var cuerpoAgregar = jsonEncode({
                  "id_usuario": 2,
                  "id_vaca": idOpcion,
                  "id_categoria": widget.categoriaSeleccionada.idCategoria
                });
                var agrego = await updateBecerroByCategory("http://192.168.100.6:3006/categoria/updateVacaByCategory",cuerpoAgregar);
                var id = jsonEncode({"id_vaca":idOpcion});
                var infoAnimal = await infoAnimalById("http://192.168.100.6:3006/categoria/findByIdVaca", id); //aca
                print(infoAnimal);
                Vacas addvaca = Vacas(id: infoAnimal['id'], id_usuario: infoAnimal['id_usuario'], nombre: infoAnimal['nombre'], 
                descripcion: infoAnimal['descripcion'], raza: infoAnimal['raza'], num_arete: infoAnimal['num_arete'], 
                url_img: infoAnimal['url_img'], estado: infoAnimal['estado'], fecha_llegada:infoAnimal['fecha_llegada'], 
                edad: infoAnimal['edad']);
                Navigator.of(context).pop(true);
                widget.lista_de_vacas.add(addvaca);
                setState(() {
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) => vacaEditar(lista_de_vacas: widget.lista_de_vacas, categoriaSeleccionada: widget.categoriaSeleccionada)));
                });
              }
            },
            backgroundColor: Colors.green,
            child: const Icon(Icons.pets_outlined),
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
            Icon(
              Icons.pets,
              color: Colors.yellow[700],
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Id: ${vaca.id}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Nombre: ${vaca.nombre}',
                  style: const TextStyle(
                    color: Colors.black,
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
        Text('No se encontro ninguna Vaca agregada a la categoria ' +
            categoriaSeleccionada.nombreCategoria),
      ],
    );
  }
}
