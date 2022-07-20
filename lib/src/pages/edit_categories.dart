import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/model/categorias.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:vacoro_proyect/src/pages/edit_categories_complete.dart';
import '../services/DAO/categorias.dart';
import '../widgets/HomePage/appBar.dart';
import 'package:page_transition/page_transition.dart';


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
    listaCat = listaCategorias("http://192.168.100.6:3000/categoria/allCategorias");
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
            selectionCategory(listaCat),
          ],
        ),
        )
      )
    );
  }

  Container selectionCategory(listaCategorias){
    var descripcion;
    List<String> dropdownCategoriaNombre = [];
    return Container(
      child: FutureBuilder(
        future: listaCategorias,
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

  // Container selectionCategory(variableGuardo){
  //   return Container(
  //     child: DropdownSearch<String>(
  //           //mode of dropdown
  //           mode: Mode.DIALOG,
  //           //to show search box
  //           showSearchBox: true,
  //           showSelectedItem: true,
  //           //list of dropdown items
  //           hint: "Seleccione Una Categoria",
  //           items: [
  //             "India",
  //             "USA",
  //             "Brazil",
  //             "Canada",
  //             "Australia",
  //             "Singapore"
  //           ],
  //           label: "Categoria",
  //           onChanged: ((value) => print(value))
  //           //show selected item
  //           //selectedItem: "India",
  //         ),
  //   );
  // }

  // Container menuDropDown(textoLabel,lista,altura,textoMostrar) {
  //   final _multiSelectKey = GlobalKey<FormFieldState>();
  //   final _items = animales.map((animal) => MultiSelectItem<Animal>(animal, animal.name)).toList();
  //   List<Animal> _selectedItems2 = [];
  //   List<Animal> _selectedItems3 = [];

  //   return Container(
  //       margin: EdgeInsets.only(left: 15, right: 15, top: altura),
  //       child: Column(
  //         children: <Widget>[
  //           MultiSelectBottomSheetField<Animal>(
  //             initialChildSize: 0.7,
  //             maxChildSize: 0.95,
  //             listType: MultiSelectListType.CHIP,
  //             checkColor: Colors.red,
  //             selectedItemsTextStyle: const TextStyle(fontSize: 25,color: Colors.white),
  //             unselectedColor: Colors.greenAccent[200],
  //             buttonIcon: const Icon(Icons.arrow_downward,color: Colors.white),
  //             searchable: true,
  //             buttonText: Text(
  //               textoLabel,
  //               style: const TextStyle(fontSize: 18,color: Colors.white),
  //               overflow: TextOverflow.ellipsis,
  //               maxLines: 5,
  //             ),
  //             title: Text(textoMostrar),
  //             selectedColor: Colors.green,
  //             decoration: const BoxDecoration(color: Colors.green),
  //             items: _items,
  //             onConfirm: (values) {
  //               setState(() {
  //                 _selectedItems2 = values;
  //               });
  //               print('selected : ${_selectedItems2}');

  //               _selectedItems2.forEach((item) => print("${item.id} ${item.name}"));
  //               /*senduserdata(
  //                   'partnerreligion', '${_selectedItems2.toString()}');*/
  //             },
  //             chipDisplay: MultiSelectChipDisplay(
  //               textStyle: const TextStyle(fontSize: 18,color: Colors.black,),
  //               onTap: (value) {
  //                 setState(() {
  //                   _selectedItems2.remove(value);
  //                 });
  //                 print('removed: ${_selectedItems2.toString()}');
  //               },
  //             ),
  //           ),
  //           _selectedItems2 == null || _selectedItems2.isEmpty
  //               ? MultiSelectChipDisplay(
  //                   onTap: (item) {
  //                     setState(() {
  //                       _selectedItems3.remove(item);
  //                       print('removed below: ${_selectedItems3.toString()}');
  //                     });
  //                     _multiSelectKey.currentState!.validate();
  //                   },
  //                 )
  //               : MultiSelectChipDisplay(),
  //         ],
  //       ),
  //     );
  // } 

}