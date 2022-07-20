import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vacoro_proyect/src/style/colors/colorview.dart';
import 'package:vacoro_proyect/src/services/medicamentosAnimal.dart';
import 'package:intl/intl.dart';

class AnadirMedicamentoAnimal extends StatefulWidget {
  const AnadirMedicamentoAnimal({Key? key}) : super(key: key);

  @override
  State<AnadirMedicamentoAnimal> createState() =>
      _AnadirMedicamentoAnimalState();
}

class _AnadirMedicamentoAnimalState extends State<AnadirMedicamentoAnimal> {
  File? image;
  bool isSwitched = false;

  TextEditingController descripcion = TextEditingController();
  TextEditingController dosis = TextEditingController();
  TextEditingController dateinputFechaAplicacion = TextEditingController();
  late String name_medicamento;
  late int id_medicina;
  late String _selectedFieldMedicamento = "";
  late List<FormField> _fieldListMedicamentos = [];

  late bool _validateMedicamento = false;
  late bool _validateDescripcion = false;
  late bool _validateDosis = false;
  late bool _validateFecha = false;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _getFieldsData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var typeNumber = TextInputType.number;
    var typeNormal = TextInputType.text;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Center(
          child: Text(
            'AGREGAR MEDICAMENTO AL ANIMAL',
            style: TextStyle(fontSize: 12.0),
          ),
        ),
        leading: SizedBox(
          child: IconButton(
            splashRadius: 15,
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 40,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(left: 30),
            width: 85,
            child: Image.asset('assets/images/logo_blanco.png'),
          )
        ],
        backgroundColor: ColorSelect.color5,
      ),
      body: SizedBox(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  selectMedicamento("Medicamento", size),
                  inputs("Descripción", "Ingrese una descripción", size,
                      descripcion, _validateDescripcion, typeNormal),
                  inputs("Dosis", "Ingrese la dosis", size, dosis,
                      _validateDosis, typeNumber),
                  date(context, size, _validateFecha),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 150),
                    child: SizedBox(
                      width: size.width - 50,
                      height: 50,
                      child: ElevatedButton(
                        child: const Text(
                          'Agregar',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          // medicamentos_all().then((value) {
                          //   print(value);
                          // });
                          // medicamentos_name_byID('Medicinaxd');

                          setState(() {
                            late bool respuestaValidate = validate();
                            if (respuestaValidate == true) {
                              if (_validateMedicamento == false) {
                                name_medicamento = _selectedFieldMedicamento;
                              }
                              medicamentos_name_byName(name_medicamento)
                                  .then((id_medicamento) {
                                int dosis_parse = int.parse(dosis.text);
                                register_historia_animal(
                                    1,
                                    1,
                                    id_medicamento,
                                    dosis_parse,
                                    descripcion.text,
                                    dateinputFechaAplicacion.text,
                                    1);
                              });
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary: ColorSelect.color5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget inputs(
      String nameTopField,
      String nameInField,
      Size size,
      TextEditingController controllerInput,
      bool error_input,
      TextInputType type) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            width: size.width,
            child: Text(
              nameTopField,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3E762F),
              ),
            ),
          ),
          SizedBox(
            height: error_input ? 60 : 40,
            child: TextField(
              keyboardType: type,
              controller: controllerInput,
              decoration: InputDecoration(
                  labelStyle: const TextStyle(color: ColorSelect.color5),
                  enabledBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorSelect.color1, width: 2.0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorSelect.color5, width: 2.0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  labelText: error_input ? "" : nameInField,
                  errorText: error_input ? "Campo incompleto" : null),
            ),
          ),
          const Divider(
            height: 5,
          )
        ],
      ),
    );
  }

  Widget selectMedicamento(String nameTopField, Size size) {
    var dropdownValue = _selectedFieldMedicamento;
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 15),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            width: size.width,
            child: Text(
              nameTopField,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ColorSelect.color1,
              ),
            ),
          ),
          SizedBox(
            height: 45,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: ColorSelect.color1, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                    enabledBorder: InputBorder.none, fillColor: Colors.white),
                value: dropdownValue,
                iconSize: 25,
                iconEnabledColor: ColorSelect.color1,
                icon: Container(
                    margin: const EdgeInsets.only(right: 30),
                    child: const Icon(Icons.arrow_drop_down)),
                style: const TextStyle(fontSize: 16, color: Colors.black),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                    name_medicamento = dropdownValue;
                    _validateMedicamento = true;
                  });
                },
                items: _fieldListMedicamentos.map((value) {
                  return DropdownMenuItem<String>(
                    value: value.nombre,
                    child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: Text(value.nombre!)),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget date(BuildContext context, Size size, bool error_input) {
    //Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            width: size.width,
            child: const Text(
              "Fecha de aplicación",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3E762F),
              ),
            ),
          ),
          SizedBox(
            height: error_input ? 60 : 40,
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.calendar_today,
                  color: ColorSelect.color1,
                ),
                iconColor: ColorSelect.color1,
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorSelect.color1, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorSelect.color1, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                labelText: error_input ? "" : "Seleccionar la fecha",
                errorText: error_input ? "Campo incompleto" : null,
                labelStyle: const TextStyle(color: ColorSelect.color5),
              ),
              controller: dateinputFechaAplicacion,
              readOnly:
                  true, //Para que el usuario no pueda editar en el textField
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(
                      2001, //Fecha limite para seleccionar
                    ),
                    lastDate: DateTime(2101),
                    //Fecha limite para seleccionar
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: ColorSelect.color5,
                            onPrimary: Colors.white,
                            onSecondary: ColorSelect.color1,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              primary: ColorSelect.color1, // button text color
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    });
                if (pickedDate != null) {
                  String formattedDate = DateFormat('yyyy-MM-dd')
                      .format(pickedDate); //La fecha se mostrar en este formato
                  setState(
                    () {
                      dateinputFechaAplicacion.text =
                          formattedDate; //Fecha de salida en el textField
                      // print(formattedDate);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _getFieldsData() {
    medicamentos_all().then(
      (data) {
        final items = jsonDecode(data).cast<Map<String, dynamic>>();
        var fieldListData = items.map<FormField>((json) {
          return FormField.fromJson(json);
        }).toList();

        // update widget
        setState(
          () {
            _selectedFieldMedicamento = fieldListData[0].nombre;
            _fieldListMedicamentos = fieldListData;
          },
        );
      },
    );
  }

  bool validate() {
    late bool validate = true;

    if (descripcion.text.isEmpty) {
      _validateDescripcion = true;
      validate = false;
    } else {
      _validateDescripcion = false;
    }

    if (dosis.text.isEmpty) {
      _validateDosis = true;
      validate = false;
    } else {
      _validateDosis = false;
    }
    print(dateinputFechaAplicacion.text);
    if (dateinputFechaAplicacion.text.isEmpty) {
      _validateFecha = true;
      validate = false;
    } else {
      _validateFecha = false;
    }

    // if (_validateMedicamento == false) {
    //   validate = false;
    // }

    return validate;
  }
}

// Model Class
class FormField {
  String? nombre;

  FormField({this.nombre});

  FormField.fromJson(Map<String, dynamic> json) {
    nombre = json['nombre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = nombre;
    return data;
  }
}
