import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/model/becerrosCategorias.dart';
import 'package:vacoro_proyect/src/model/torosCategorias.dart';
import 'package:vacoro_proyect/src/services/DAO/becerros.dart';
import 'package:vacoro_proyect/src/services/DAO/toros.dart';
import 'package:vacoro_proyect/src/services/DAO/vacas.dart';
import 'package:vacoro_proyect/src/widgets/HomePage/buttonSave.dart';
import 'package:vacoro_proyect/src/widgets/HomePage/textfield.dart';
import 'package:multiple_search_selection/multiple_search_selection.dart';
import '../model/vacasCategorias.dart';
import '../widgets/HomePage/appBar.dart';

class addCategories extends StatefulWidget {
  addCategories({Key? key}) : super(key: key);

  @override
  State<addCategories> createState() => _addCategories();
}

class _addCategories extends State<addCategories> {

  late Future<List<Becerros>> listaB;
  late Future<List<Vacas>> listaV;
  late Future<List<Toros>> listaT;

  @override
  void initState() {
    listaB = listaBecerros("http://192.168.100.11:3006/categoria/allCategorias/allBecerros");
    listaV = listaVacas("http://192.168.100.11:3006/categoria/allCategorias/allVacas");
    listaT = listaToros("http://192.168.100.11:3006/categoria/allCategorias/allToros");
    super.initState();
  }

  List<Becerros> becerroEleccion = [];
  List<Vacas> vacaEleccion = [];
  List<Toros> toroEleccion = [];

  final controladorNombre = TextEditingController();
  final controladorDescripcion = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: appbarCat("Nueva Categoria", 'assets/images/logo_blanco.png', context, "editar_categoria"),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
          children: [
            textfieldCategoria("Nombre de la categorias","Ingrese el nombre de la categoria",10.0,controladorNombre,context,""),
            textfieldCategoria("Descripción de la categoria","Ingrese la descripción de la categoria",30.0,controladorDescripcion,context,""),
            seleccionLabel("Selecciona los animales de esa categoria",15.0),
            menuDropDown(listaB, 20.0,"becerros"),
            menuDropDown(listaV, 20.0,"vacas"),
            menuDropDown(listaT, 20.0,"toros"),
            botonGuardar("Guardar", 100.0,becerroEleccion,vacaEleccion,toroEleccion,controladorNombre,controladorDescripcion,context),
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
                return lista_vaca(altura, tipo);
              }if (tipo == "toros"){
                return lista_toro(altura, tipo);
              }
            }
            return Container();
          }),
    );
  }

  Future <List<dynamic>> generarListaVaca()async {
    List<Vacas> listaVaca = await listaV;
    List<Vacas> vacas = List<Vacas>.generate(
      listaVaca.length,
      (index) => Vacas(
        id: listaVaca[index].id,
        id_usuario: listaVaca[index].estado,
        nombre: listaVaca[index].nombre,
        descripcion: listaVaca[index].descripcion,
        raza: listaVaca[index].raza,
        num_arete: listaVaca[index].num_arete,
        url_img: listaVaca[index].url_img,
        estado: listaVaca[index].estado,
        fecha_llegada: listaVaca[index].fecha_llegada,
        edad: listaVaca[index].edad,
      ),
    );
  return vacas;
  }

  Future <List<dynamic>> generarListaToro()async {
    List<Toros> listaToro = await listaT;
    List<Toros> toros = List<Toros>.generate(
      listaToro.length,
      (index) => Toros(
        id: listaToro[index].id,
        id_usuario: listaToro[index].estado,
        nombre: listaToro[index].nombre,
        descripcion: listaToro[index].descripcion,
        raza: listaToro[index].raza,
        num_arete: listaToro[index].num_arete,
        url_img: listaToro[index].url_img,
        estado: listaToro[index].estado,
        fecha_llegada: listaToro[index].fecha_llegada,
        edad: listaToro[index].edad,
      ),
    );
  return toros;
  }

  Future <List<dynamic>> generarListaBecerro() async{
    List<Becerros> listaBecerro = await listaB;
    List<Becerros> becerros = List<Becerros>.generate(
      listaBecerro.length,
      (index) => Becerros(
        id: listaBecerro[index].id,
        id_usuario: listaBecerro[index].estado,
        nombre: listaBecerro[index].nombre,
        descripcion: listaBecerro[index].descripcion,
        raza: listaBecerro[index].raza,
        num_arete: listaBecerro[index].num_arete,
        url_img: listaBecerro[index].url_img,
        estado: listaBecerro[index].estado,
        fecha_llegada: listaBecerro[index].fecha_llegada,
        id_vaca: listaBecerro[index].id_vaca,
        edad: listaBecerro[index].edad,
      ),
    );
  return becerros;
  }

  Container lista_vaca(altura, tipo) {
    return Container(
      child: FutureBuilder(
          future: generarListaVaca(),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.data != null) {
              List listaVa = [];
              for (int i = 0; i < snapshot.data!.length; i++) {
                listaVa.add(snapshot.data![i]);
              }
              return listaConstruccion(listaVa, altura, vacaEleccion, tipo);
            }
            return Container();
          }),
    );
  }

  Container lista_toro(altura, tipo) {
    return Container(
      child: FutureBuilder(
          future: generarListaToro(),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.data != null) {
              List listaTo = [];
              for (int i = 0; i < snapshot.data!.length; i++) {
                listaTo.add(snapshot.data![i]);
              }
              return listaConstruccion(listaTo, altura, toroEleccion, tipo);
            }
            return Container();
          }),
    );
  }

  Container lista_becerro(altura, tipo) {
    return Container(
      child: FutureBuilder(
          future: generarListaBecerro(),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.data != null) {
              List listaBe = [];
              for (int i = 0; i < snapshot.data!.length; i++) {
                listaBe.add(snapshot.data![i]);
              }
              return listaConstruccion(listaBe, altura, becerroEleccion, tipo);
            }
            return Container();
          }),
    );
  }

  Container listaConstruccion(items, altura, listaGuardo, tipo) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: altura),
      child: Column(
        children: <Widget>[
          MultipleSearchSelection<dynamic>(
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
            showSelectAllButton: false,
            showClearAllButton: false,
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