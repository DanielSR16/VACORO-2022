import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vacoro_proyect/src/services/medicamentos.dart';
import 'package:vacoro_proyect/src/style/colors/colorview.dart';

class DialogContainer extends StatefulWidget {
  DialogContainer({Key? key, required this.text}) : super(key: key);
  String text;

  @override
  State<DialogContainer> createState() => _DialogContainerState();
}

class _DialogContainerState extends State<DialogContainer> {
  TextEditingController nombre_medicamento = TextEditingController();
  TextEditingController descripcion_medicamento = TextEditingController();
  TextEditingController cantidad_medicamento = TextEditingController();
  TextEditingController fecha_medicamento = TextEditingController();

  late bool _validateNombre = false;
  late bool _validateDescripcion = false;
  late bool _validateCantidad = false;
  late bool _validateFecha = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController dateinput = TextEditingController();
    late bool _validateDate = false;
    return Dialog(
      child: SingleChildScrollView(
        child: SizedBox(
          width: size.width * 0.8,
          height: size.height * 0.75,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CloseButton(
                      color: const Color(0xff2F6622),
                      onPressed: () {
                        print("Salir");
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 40),
                    child: const Text(
                      "Agregar Medicamento",
                      style: TextStyle(
                        color: Color(0xff2F6622),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, bottom: 10),
                  child: const Text(
                    "Nombre",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xff2F6622),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: size.width * 0.75,
                    height: _validateNombre ? 70 : 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      controller: nombre_medicamento,
                      onChanged: (text) {},
                      decoration: InputDecoration(
                          hintStyle: const TextStyle(
                            color: ColorSelect.color5,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              style: BorderStyle.solid,
                              color: Color(0xff2F6622),
                              width: 3,
                            ),
                          ),
                          hintText: "Ingrese nombre del medicamento",
                          errorText:
                              _validateNombre ? "El campo esta vacio" : null),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20, bottom: 10, top: 20),
                          child: const Text(
                            "Descripción",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xff2F6622),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        width: size.width * 0.75,
                        height: _validateDescripcion ? 100 : 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: SingleChildScrollView(
                          child: TextField(
                            controller: descripcion_medicamento,
                            maxLines: 2,
                            onChanged: (text) {},
                            decoration: InputDecoration(
                                hintStyle: const TextStyle(
                                  color: ColorSelect.color5,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    style: BorderStyle.solid,
                                    color: Color(0xff2F6622),
                                    width: 3,
                                  ),
                                ),
                                hintText:
                                    "Ingrese una descripción del medicamento",
                                errorText: _validateDescripcion
                                    ? "El campo esta vacio"
                                    : null),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, bottom: 10),
                  child: const Text(
                    "Cantidad",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xff2F6622),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: size.width * 0.75,
                    height: _validateCantidad ? 70 : 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: _input("Ingrese la cantidad del medicamento",
                        cantidad_medicamento),
                  ),
                ),
                Container(
                  child: fecha(context, "fecha de caducidad", fecha_medicamento,
                      _validateFecha),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 15, bottom: 50),
                    width: size.width * 0.75,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: ColorSelect.color5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        print("AGREGAR MEDICAMENTOS");
                        setState(() {
                          if (validateIntputs() == true) {
                            int par_cantidad =
                                int.parse(cantidad_medicamento.text);
                            registerMedicina(
                                    nombre_medicamento.text,
                                    descripcion_medicamento.text,
                                    par_cantidad,
                                    fecha_medicamento.text)
                                .then((value) {
                              print(value);
                              Navigator.pop(
                                context,
                              );
                            });
                          }
                        });
                      },
                      child: const Text(
                        "Agregar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
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
    );
  }

  Widget _input(String hintText, controller) {
    return TextField(
      keyboardType: TextInputType.number,
      controller: controller,
      onChanged: (text) {},
      decoration: InputDecoration(
          hintStyle: const TextStyle(
            color: ColorSelect.color5,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              style: BorderStyle.solid,
              color: Color(0xff2F6622),
              width: 3,
            ),
          ),
          hintText: hintText,
          errorText: _validateCantidad ? 'El campo esta vacio' : null),
    );
  }

  Widget fecha(
    BuildContext context,
    String nameTopField,
    TextEditingController dateinput,
    bool validate_,
  ) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20, bottom: 5),
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
            height: validate_ ? 70 : 50,
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.calendar_today,
                  color: ColorSelect.color1,
                ),
                iconColor: ColorSelect.color1,
                labelText: "Seleccionar la fecha de llegada",
                labelStyle: const TextStyle(color: ColorSelect.color5),
                errorText: validate_ ? 'El campo esta vacio' : null,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorSelect.color1, width: 2.0),
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
                  borderSide: BorderSide(color: ColorSelect.color5, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
              ),
              controller: dateinput,

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
                      dateinput.text =
                          formattedDate; //Fecha de salida en el textField
                    },
                  );

                  print(dateinput.text);
                } else {
                  validate_ = true;
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  bool validateIntputs() {
    bool lleno = true;

    if (nombre_medicamento.text.isEmpty) {
      _validateNombre = true;
      lleno = false;
    } else {
      _validateNombre = false;
    }

    if (descripcion_medicamento.text.isEmpty) {
      _validateDescripcion = true;
      lleno = false;
    } else {
      _validateDescripcion = false;
    }

    if (cantidad_medicamento.text.isEmpty) {
      _validateCantidad = true;
      lleno = false;
    } else {
      _validateCantidad = false;
    }

    if (fecha_medicamento.text.isEmpty) {
      _validateFecha = true;
      lleno = false;
    } else {
      _validateFecha = false;
    }

    return lleno;
  }
}
