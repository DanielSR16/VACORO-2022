import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/pages/medication_history_bull.dart';
import 'package:vacoro_proyect/src/pages/medication_history_calf.dart';
import 'package:vacoro_proyect/src/pages/medication_history_cow.dart';
import 'package:vacoro_proyect/src/services/medicamentosAnimal.dart';
import 'package:vacoro_proyect/src/style/colors/colorview.dart';
import 'package:intl/intl.dart';
import 'package:vacoro_proyect/src/utils/user_secure_storage.dart';

class EditarMedicamentoAnimal extends StatefulWidget {
  List data_ = [];
  EditarMedicamentoAnimal({Key? key, required this.data_}) : super(key: key);

  @override
  State<EditarMedicamentoAnimal> createState() =>
      _EditarMedicamentoAnimalState();
}

class _EditarMedicamentoAnimalState extends State<EditarMedicamentoAnimal> {
  File? image;
  bool isSwitched = false;
  TextEditingController descripcion = TextEditingController();
  TextEditingController dosis = TextEditingController();
  TextEditingController dateinputFechaAplicacion = TextEditingController();
  late String name_medicamento;
  late int id_medicamento;
  late String _selectedFieldMedicamento = "";
  late List<FormField> _fieldListMedicamento = [];

  late bool _validateMedicamento = false;
  late bool _validateDescripcion = false;
  late bool _validateDosis = false;
  late bool _validateFecha = false;

  late int id_usuario = 0;
  late int id_historial = 16;
  late int id_tipoAnimal = 1;

  late String token_ = "";
  List data_ = [];
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    print(widget.data_);
    UserSecureStorage.getToken().then((value) {
      UserSecureStorage.getId().then((id_usuario_) {
        setState(() {
          token_ = value!;
          _getFieldsData(id_usuario_);
        });
      });
    });

    //aqui iria id del historial y numero de valor si es vaca = 1, toro = 2 y becerro = 3
    print('//////////////////////////////////');
    print(widget.data_);
    historial_animal_edit(widget.data_[3], widget.data_[0], token_)
        .then((value) {
      print(value);

      var jsonValue = jsonDecode(value);
      print(jsonValue["descripcion"]);
      setState(() {
        descripcion.text = jsonValue["descripcion"];

        dosis.text = jsonValue["dosis"].toString();
        dateinputFechaAplicacion.text = jsonValue["fecha_aplicacion"];

        id_medicamento = jsonValue["id_medicamento"];
        // var id_medicamento_parse = int.parse(id_medicamento);
        medicamentos_name_byID(id_medicamento, widget.data_[1], token_)
            .then((value) {
          print("object");
          print(value);
          setState(() {
            _selectedFieldMedicamento = value;
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final data = ModalRoute.of(context)?.settings.arguments;
    // setState(() {
    //   data_ = data as List;
    // });
    print(data_);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Center(
          child: Text(
            'EDITAR MEDICAMENTO AL ANIMAL',
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
                      descripcion, _validateDescripcion),
                  inputs(
                      "Dosis", "Ingrese la dosis", size, dosis, _validateDosis),
                  date(context, size),
                  // Container(
                  //   width: 270,
                  //   margin: const EdgeInsets.only(left: 40),
                  //   padding:
                  //       const EdgeInsets.only(left: 20, bottom: 25, top: 100),
                  //   child: Material(
                  //     color: Colors.transparent, // button color
                  //     child: InkWell(
                  //       splashColor: Colors.green, // splash color
                  //       onTap: () {
                  //         historia_animal_eliminar(id_historial, id_tipoAnimal)
                  //             .then((value) {
                  //           Navigator.pop(context, "splash");
                  //         });
                  //       }, // button pressed
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: const <Widget>[
                  //           Text("Borrar medicamento del animal",
                  //               style: TextStyle(
                  //                   fontSize: 16, color: ColorSelect.color5)),
                  //           Icon(
                  //             Icons.delete,
                  //             color: ColorSelect.color1,
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    padding:
                        const EdgeInsets.only(top: 40, left: 20, right: 20),
                    child: SizedBox(
                      width: size.width - 50,
                      height: 50,
                      child: ElevatedButton(
                          child: const Text(
                            'Editar',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              late bool respuestaValidate = validate();
                              if (respuestaValidate == true) {
                                if (_validateMedicamento == false) {
                                  name_medicamento = _selectedFieldMedicamento;
                                }
                                medicamentos_name_byName(name_medicamento,
                                        widget.data_[1], token_)
                                    .then((id_medicamento) {
                                  int dosis_parse = int.parse(dosis.text);
                                  register_historia_animal_editar(
                                          token_,
                                          widget.data_[3],
                                          widget.data_[0],
                                          widget.data_[1],
                                          id_medicamento,
                                          dosis_parse,
                                          descripcion.text,
                                          dateinputFechaAplicacion.text,
                                          widget.data_[2])
                                      .then((value) {
                                    Future.delayed(
                                        const Duration(milliseconds: 200), () {
                                      if (widget.data_[0] == 1) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                MedicationHistoryCow(
                                              idAnimal: widget.data_[2],
                                              nombre: '',
                                              idUsuario: widget.data_[1],
                                            ),
                                          ),
                                        );
                                      } else if (widget.data_[0] == 2) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                MedicationHistoryBull(
                                              idAnimal: widget.data_[2],
                                              nombre: '',
                                              idUsuario: widget.data_[1],
                                            ),
                                          ),
                                        );
                                      } else {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                MedicationHitoryCalf(
                                              idAnimal: widget.data_[2],
                                              nombre: '',
                                              idUsuario: widget.data_[1],
                                            ),
                                          ),
                                        );
                                      }
                                    });

                                    print(value);
                                  });
                                });
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              primary: ColorSelect.color5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)))),
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

  Widget inputs(String nameTopField, String nameInField, Size size,
      TextEditingController controllerInput, bool validar) {
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
            height: validar ? 60 : 40,
            child: TextField(
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
                  //este codigo replicarlo en añadir
                  focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
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
                  labelText: nameInField,
                  errorText: validar ? "Faltan campos" : null),
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
                items: _fieldListMedicamento.map((value) {
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

  Widget date(BuildContext context, Size size) {
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
            height: 40,
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.calendar_today,
                  color: ColorSelect.color1,
                ),
                iconColor: ColorSelect.color1,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorSelect.color1, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorSelect.color1, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                labelText: "Seleccionar la fecha",
                labelStyle: TextStyle(color: ColorSelect.color5),
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

  void _getFieldsData(id_usuario) {
    medicamentos_all(token_, id_usuario).then(
      (data) {
        final items = jsonDecode(data).cast<Map<String, dynamic>>();
        var fieldListData = items.map<FormField>((json) {
          return FormField.fromJson(json);
        }).toList();

        // update widget
        setState(
          () {
            _selectedFieldMedicamento = fieldListData[0].nombre;
            _fieldListMedicamento = fieldListData;
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
