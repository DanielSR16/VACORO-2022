import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vacoro_proyect/src/model/categorias.dart';
import 'package:vacoro_proyect/src/model/vacas.dart';
import 'package:vacoro_proyect/src/model/torosCategorias.dart';
import 'package:vacoro_proyect/src/model/becerrosCategorias.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:multiple_search_selection/multiple_search_selection.dart';
import '../services/DAO/becerros.dart';
import '../services/DAO/categorias.dart';
import '../services/DAO/categoryBecerroDao.dart';
import '../services/DAO/toros.dart';
import '../services/DAO/vacas.dart';
import '../widgets/HomePage/appBar.dart';
import '../widgets/HomePage/textfield.dart';


class editCategoriesComplete extends StatefulWidget {
  Categoria categoriaSeleccionada;
  editCategoriesComplete({Key? key, required this.categoriaSeleccionada}) : super(key: key);

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
  List<Becerros> vacaEleccion = [];
  List<Becerros> toroEleccion = [];


  @override
  void initState() {
    Cat = listaCategorias("http://192.168.100.6:3000/categoria/allCategorias");
    listaB = listaBecerros("http://192.168.100.6:3000/categoria/allCategorias/allBecerros");
    listaV = listaVacas("http://192.168.100.6:3000/categoria/allCategorias/allVacas");
    listaT = listaToros("http://192.168.100.6:3000/categoria/allCategorias/allToros");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCat("Editar Categoria", 'assets/images/logo_blanco.png'),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
          children: [
            selectionCategory(Cat,widget.categoriaSeleccionada.nombreCategoria),
            textfieldCategoria("Descripcion De La Categoria","Modifique el nombre de la categoria",10.0,controladorNombre,context,"Descripcion Actual: "+widget.categoriaSeleccionada.descripcionCategoria),
            menuDropDown(listaB, 20.0,"becerros"),
            Text(becerroEleccion.toString()),
            ElevatedButton(onPressed: (){
              print(becerroEleccion);
            }, 
            child: Text("presione"))
            //botonGuardar("Guardar", 100.0,becerroEleccion,vacaEleccion,toroEleccion,controladorNombre,controladorDescripcion)
            //Text(nuevo.toString()),
            //menuDropDown("Toro", listaT, 20.0,"Seleccione Toros a agregar","toros", toroEleccion),
            //menuDropDown("Becerro", listaB, 20.0,"Seleccione Becerros a agregar","becerros", becerroEleccion),
          ],
        ),
        )
      )
    );
  }

  Container menuDropDown(lista, altura, tipo) {
    return Container(
      child: FutureBuilder(
          future: lista,
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.data != null) {
              if (tipo == "becerros"){
                return lista_becerro(altura, tipo);
              }if (tipo == "vacas"){
                //return lista_vaca(altura, tipo);
              }if (tipo == "toros"){
                //return lista_toro(altura, tipo);
              }
            }
            return Container();
          }),
    );
  }

  Future <List<dynamic>> generarListaBecerro() async{
    List<Becerros> listaB = await listaBecerros("http://192.168.100.6:3000/categoria/allCategorias/allBecerros");
    List<Becerros> becerros = List<Becerros>.generate(
      listaB.length,
      (index) => Becerros(
        id: listaB[index].id,
        id_usuario: listaB[index].estado,
        nombre: listaB[index].nombre,
        descripcion: listaB[index].descripcion,
        raza: listaB[index].raza,
        num_arete: listaB[index].num_arete,
        url_img: listaB[index].url_img,
        estado: listaB[index].estado,
        fecha_llegada: listaB[index].fecha_llegada,
        id_vaca: listaB[index].id_vaca,
        edad: listaB[index].edad,
      ),
    );
  return becerros;
  }

  // Future<Map<String, Object>> torosCategoria(listaToros) async {
  //   var listatoroscompleto = await listaT;
  //   var lista_toros_id = await listaToros;

  //   List<dynamic> torosByCategory = [];
  //   List<Toros> torosTotales = [];

  //   for (int i=0; i<lista_toros_id.length; i++){
  //     var torosActuales = await listaTorosByIdCategoria("http://192.168.100.13:3000/categoria/findByIdToro", lista_toros_id[i]['id_toro']);
  //     torosByCategory.add(torosActuales);
  //   }

  //   for (int i=0; i< listatoroscompleto.length; i++){
  //     torosTotales.add(listatoroscompleto[i]);
  //   }

  //   var x = {"toroEleccion":torosByCategory,"torosTotales":listatoroscompleto};
  //   print(x);
  //   return x;
  // }

  Container lista_becerro(altura, tipo) {
    var idCategoria = jsonEncode({"id_categoria":widget.categoriaSeleccionada.idCategoria});
    var idBecerro;
    return Container(
      child: FutureBuilder(
          future: listBecerrosByIdCategoria("http://192.168.100.6:3000/categoria/findListBecerrosByIdCategory", idCategoria),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.data != null) {
              List listaID = [];
              for (int i=0; i<snapshot.data!.length; i++){
                idBecerro = jsonEncode({"id_becerro":snapshot.data![i]['id_becerro']});
                listaID.add(idBecerro);
              }
              return rapido(listaID);
              //vista(listaID);
              // var id = jsonEncode({"id_categoria":widget.categoriaSeleccionada.idCategoria});
              // var listaToros = await listaTorosByIdCategoria("http://192.168.100.6:3000/categoria/findListBecerrosByIdCategory", id);
              // print(listaToros);
              // List listaBe = [];
              // for (int i = 0; i < snapshot.data!.length; i++) {
              //   listaBe.add(snapshot.data![i]);
              // }
              // print(listaBe);
              // return Text("becerro");
              // //return listaConstruccion(listaBe, altura, becerroEleccion, tipo);
            }
            return Container();
          }),
    );
  }

  Future <List<dynamic>> vista(id) async {
    List<Becerros> infoBecerros = [];
    for (int i=0; i<id.length; i++){
      var x = await infoAnimalById("http://192.168.100.6:3000/categoria/findByIdBecerro", id[i]);
      print(x);
      Becerros becerros = Becerros(id: x['id'], id_usuario: x['id_usuario'], nombre: x['nombre'], descripcion: x['descripcion'],
      raza: x['raza'], num_arete: x['num_arete'], url_img: x['url_img'], estado: x['estado'], fecha_llegada: x['fecha_llegada'], 
      id_vaca: x['id_vaca'], edad: x['edad']);
      infoBecerros.add(becerros);
    }
    return infoBecerros;
  }

  Container rapido(listaID){
    print("entro");
    return Container(
      child: FutureBuilder(
        future: vista(listaID),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
          if (snapshot.data != null){
            return menuDropp(snapshot.data);
          }
          return Container();
        }
      )
    );
  }

  List<Becerros> generarLB(lista) {
    List<Becerros> becerros = List<Becerros>.generate(
      lista.length,
      (index) => Becerros(
        id: lista[index].id,
        id_usuario: lista[index].estado,
        nombre: lista[index].nombre,
        descripcion: lista[index].descripcion,
        raza: lista[index].raza,
        num_arete: lista[index].num_arete,
        url_img: lista[index].url_img,
        estado: lista[index].estado,
        fecha_llegada: lista[index].fecha_llegada,
        id_vaca: lista[index].id_vaca,
        edad: lista[index].edad,
      ),
    );
  return becerros;
  }

  Container menuDropp(eleccion){
    return Container(
      child: FutureBuilder(
        future: listaB,
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
          if (snapshot.data != null){
            List<Becerros>becerrosTotales = generarLB(snapshot.data);
            becerroEleccion = generarLB(eleccion);
            return listaConstruccion(becerrosTotales, 20.0, becerroEleccion, "becerros");
            // for(int i=0; i<snapshot.data!.length; i++){
            //   print("entro al completo");
            //   print(snapshot.data![i].nombre);
            // }
            // for(int i=0; i<eleccion.length; i++){
            //   print("entro eleccion");
            //   print(eleccion[i].nombre);
            // }

          }
          return Container();
        }
      )
    );
  }



  Container selectionCategory(listaCategorias,inicialValue){
    var descripcion;
    List<String> dropdownCategoriaNombre = [];
    return Container(
      child: FutureBuilder(
        future: Cat!,
        builder: (context, AsyncSnapshot<List<Categoria>> snapshot) {
          if (snapshot.data != null){
            for (int i=0; i<snapshot.data!.length; i++){
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
                for (int i=0; i<snapshot.data!.length; i++){
                  if (value!.compareTo(snapshot.data![i].nombreCategoria) == 0){
                    descripcion = snapshot.data![i].descripcionCategoria,
                    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: editCategoriesComplete(categoriaSeleccionada: snapshot.data![i]))),
                  },
                },   
              }),
            );
          }
          return Container();
        }
      ),
    );
  }

  Container listaConstruccion(items, altura, listaGuardo, tipo) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: altura),
      child: Column(
        children: <Widget>[
          MultipleSearchSelection<dynamic>(
            initialPickedItems: listaGuardo,
            items: items,
            fieldToCheck: (c) {
              return c.nombre;
            },
            itemBuilder: (country) {
              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 12,
                    ),
                    child: Text(country.nombre), //esto es lo que muestra
                  ),
                ),
              );
            },
            pickedItemBuilder: (country) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[400]!),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(country.nombre),
                ),
              );
            },
            sortShowedItems: true,
            fuzzySearch: FuzzySearch.jaro,
            padding: const EdgeInsets.all(20),
            itemsVisibility: ShowedItemsVisibility.alwaysOn,
            title: Text(
              tipo,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            showSelectAllButton: true,
            titlePadding: const EdgeInsets.symmetric(vertical: 10),
            searchItemTextContentPadding:
                const EdgeInsets.symmetric(horizontal: 10),
            maximumShowItemsHeight: 200,
            onTapShowedItem: () {},
            onPickedChange: (items) {},
            onItemAdded: (item) {
              listaGuardo.add(item);
            },
            onItemRemoved: (item) {
              listaGuardo.remove(item);
            },
          ), // This t
        ],
      ),
    );
  }

}