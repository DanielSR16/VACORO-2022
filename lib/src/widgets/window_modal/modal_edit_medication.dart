import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/style/colors/colorview.dart';

class ContainerDialogEditMedication extends StatelessWidget {
  ContainerDialogEditMedication({Key? key})
      : super(key: key);
  

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
                    child: _input("Ingrese nombre del medicamento..."),
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
                    child: _input("Ingrese la cantidad del medicamento"),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: TextButton(
                        onPressed: () {
                          print("Eliminar medicamento");
                        },
                        child: const Text(
                          "Borrar medicamento",
                          style: TextStyle(
                            color: ColorSelect.color5,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      height: 50,
                      width: 50,
                      child: GestureDetector(
                        onTap: () {
                          print("Eliminar datos");
                        },
                        child: Image.asset('assets/images/image_delete.png'),
                      ),
                    )
                  ],
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

  Widget _input(String hintText) {
    return TextField(
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
      ),
    );
  }
}
