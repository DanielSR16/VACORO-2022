import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/services/medication_service.dart';
import 'package:vacoro_proyect/src/style/colors/colorview.dart';

class ContainerDialogEditMedication extends StatefulWidget {
  int id;
  String nombre;
  String descripcion;
  int cantidad;
  String fecha_caducidad;
  int id_usuario;
  String token;

  ContainerDialogEditMedication(
      {Key? key,
      required this.id,
      required this.nombre,
      required this.descripcion,
      required this.cantidad,
      required this.fecha_caducidad,
      required this.id_usuario,
      required this.token})
      : super(key: key);

  @override
  State<ContainerDialogEditMedication> createState() =>
      _ContainerDialogEditMedicationState();
}

class _ContainerDialogEditMedicationState
    extends State<ContainerDialogEditMedication> {
  TextEditingController nombre_medicamento = TextEditingController();
  TextEditingController descripcion_medicamento = TextEditingController();
  TextEditingController cantidad_medicamento = TextEditingController();

  late bool _validateNombre = false;
  late bool _validateDescripcion = false;
  late bool _validateCantidad = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      nombre_medicamento.text = widget.nombre;
      descripcion_medicamento.text = widget.descripcion;
      cantidad_medicamento.text = widget.cantidad.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                      "Editar Medicamento",
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
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: _input("Ingrese nombre del medicamento...",
                        nombre_medicamento, _validateNombre),
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
                        height: 80,
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
                                  ? 'El campo esta vacio'
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, bottom: 10, top: 20),
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
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: _inputCantidad("Ingrese la cantidad del medicamento",
                        cantidad_medicamento, _validateCantidad),
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 50, bottom: 50),
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
                          late bool res = valid();
                          if (res == true) {
                            updateMedication(
                                    widget.id,
                                    nombre_medicamento.text,
                                    descripcion_medicamento.text,
                                    int.parse(cantidad_medicamento.text),
                                    widget.fecha_caducidad,
                                    widget.id_usuario,
                                    widget.token)
                                .then((value) {
                              Navigator.pushNamed(context, 'dash_medication');
                            });
                          }
                        });
                      },
                      child: const Text(
                        "Editar",
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

  Widget _input(
    String hintText,
    TextEditingController controllerInput,
    bool validate_,
  ) {
    return TextField(
      controller: controllerInput,
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
        errorText: validate_ ? 'El campo esta vacio' : null,
      ),
    );
  }

  Widget _inputCantidad(
      String hintText, TextEditingController controllerInput, bool validate_) {
    return TextField(
      keyboardType: TextInputType.number,
      controller: controllerInput,
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
        errorText: validate_ ? 'El campo esta vacio' : null,
      ),
    );
  }

  bool valid() {
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
    return lleno;
  }
}
