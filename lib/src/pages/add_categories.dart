import 'package:flutter/material.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:vacoro_proyect/src/model/animals.dart';
import 'package:vacoro_proyect/src/widgets/HomePage/buttonSave.dart';
import 'package:vacoro_proyect/src/widgets/HomePage/deleteCategorias.dart';
import 'package:vacoro_proyect/src/widgets/HomePage/textfield.dart';

import '../widgets/HomePage/appBar.dart';


class addCategories extends StatefulWidget {
  addCategories({Key? key}) : super(key: key);

  @override
  State<addCategories> createState() => _addCategories();
}

class _addCategories extends State<addCategories> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: appbarCat("Nueva Categoria", 'assets/images/logo_blanco.png'),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
          children: [
            textfieldCategoria("Nombre de la categorias","Ingrese el nombre de la categoria",10.0,context),
            textfieldCategoria("Descripción de la categoria","Ingrese la descripción de la categoria",30.0,context),
            seleccionLabel("Selecciona los animales de esa categoria",30.0),
            menuDropDown("Vaca", "", 20.0,"Seleccione Vacas a agregar"),
            menuDropDown("Toro", "", 20.0,"Seleccione Toros a agregar"),
            menuDropDown("Becerro", "", 20.0,"Seleccione Becerros a agregar"),
            //deleteCat("Borrar Categoria",50.0),
            botonGuardar("Guardar", 100.0)
          ],
        ),
        )
      )
    );
  }

  Container menuDropDown(textoLabel,lista,altura,textoMostrar) {
    final _multiSelectKey = GlobalKey<FormFieldState>();
    final _items = animales.map((animal) => MultiSelectItem<Animal>(animal, animal.name)).toList();
    List<Animal> _selectedItems2 = [];
    List<Animal> _selectedItems3 = [];

    return Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: altura),
        child: Column(
          children: <Widget>[
            MultiSelectBottomSheetField<Animal>(
              initialChildSize: 0.7,
              maxChildSize: 0.95,
              listType: MultiSelectListType.CHIP,
              checkColor: Colors.red,
              selectedItemsTextStyle: const TextStyle(fontSize: 25,color: Colors.white),
              unselectedColor: Colors.greenAccent[200],
              buttonIcon: const Icon(Icons.arrow_downward,color: Colors.white),
              searchable: true,
              buttonText: Text(
                textoLabel,
                style: const TextStyle(fontSize: 18,color: Colors.white),
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
              ),
              title: Text(textoMostrar),
              selectedColor: Colors.green,
              decoration: const BoxDecoration(color: Colors.green),
              items: _items,
              onConfirm: (values) {
                setState(() {
                  _selectedItems2 = values;
                });
                print('selected : ${_selectedItems2}');

                _selectedItems2.forEach((item) => print("${item.id} ${item.name}"));
                /*senduserdata(
                    'partnerreligion', '${_selectedItems2.toString()}');*/
              },
              chipDisplay: MultiSelectChipDisplay(
                textStyle: const TextStyle(fontSize: 18,color: Colors.black,),
                onTap: (value) {
                  setState(() {
                    _selectedItems2.remove(value);
                  });
                  print('removed: ${_selectedItems2.toString()}');
                },
              ),
            ),
            _selectedItems2 == null || _selectedItems2.isEmpty
                ? MultiSelectChipDisplay(
                    onTap: (item) {
                      setState(() {
                        _selectedItems3.remove(item);
                        print('removed below: ${_selectedItems3.toString()}');
                      });
                      _multiSelectKey.currentState!.validate();
                    },
                  )
                : MultiSelectChipDisplay(),
          ],
        ),
      );
  } 

}