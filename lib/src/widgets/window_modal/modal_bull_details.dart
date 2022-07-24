import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/style/colors/colorview.dart';

import '../../services/obtenerVacaToro.dart';

//TORO
class ContainerDialogModalBullDetail extends StatefulWidget {
  String tipoAnimal;
  int id;
  String token;
  ContainerDialogModalBullDetail(
      {Key? key,
      required this.tipoAnimal,
      required this.id,
      required this.token})
      : super(key: key);

  @override
  State<ContainerDialogModalBullDetail> createState() =>
      _ContainerDialogModalBullDetailState();
}

class _ContainerDialogModalBullDetailState
    extends State<ContainerDialogModalBullDetail> {
  late String nombre = '';
  late String descripcion = '';
  late String raza = '';
  late int edad = 0;
  late String num_arete = '';
  late String url_img =
      'https://animapedia.org/wp-content/uploads/2018/07/vaca-perfil.jpg';
  late String fecha_llegada = '';
  late String estado = '';

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    vacatoro_id(widget.id, widget.tipoAnimal, widget.token).then((value) {
      setState(() {
        nombre = value.nombre;
        descripcion = value.descripcion;
        raza = value.raza;
        edad = value.edad;
        num_arete = value.num_arete;
        url_img = value.url_img;

        fecha_llegada = value.fecha_llegada;
        if (value.estado == 1) {
          estado = 'Enfermo';
        } else {
          estado = 'No esta enfermo';
        }
      });
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
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        color: ColorSelect.color5,
                        width: size.width * 0.65,
                        child: const Center(
                          child: Text(
                            "Detalles",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: size.width * 0.65,
                        child: const Text(
                          "Nombre",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xff2F6622),
                          ),
                        ),
                      ),
                    ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      width: size.width * 0.65,
                      height: 30,
                      child: _input(nombre),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: size.width * 0.65,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      width: size.width * 0.65,
                      height: size.height * 0.085,
                      child: _input(descripcion),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: size.width * 0.65,
                      child: const Text(
                        "Raza",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xff2F6622),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: size.width * 0.65,
                      height: 50,
                      child: _input(raza),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: size.width * 0.65,
                      child: const Text(
                        "Edad (Meses)",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xff2F6622),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      width: size.width * 0.65,
                      height: 30,
                      child: _input(edad.toString()),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: size.width * 0.65,
                      child: const Text(
                        "Estado del animal",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xff2F6622),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      width: size.width * 0.65,
                      height: 30,
                      child: _input(estado),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: size.width * 0.65,
                      child: const Text(
                        "Número de aretes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xff2F6622),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      width: size.width * 0.65,
                      height: 30,
                      child: _input(num_arete),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: size.width * 0.65,
                      child: const Text(
                        "Imagen de su marca",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xff2F6622),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10, top: 10),
                      width: size.width * 0.65,
                      height: 150,
                      child: Image.network(url_img),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: size.width * 0.65,
                      child: const Text(
                        "Fecha de llegada",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xff2F6622),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 50),
                      width: size.width * 0.65,
                      height: 50,
                      child: _input(fecha_llegada),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _input(String text) {
    return Text(
      "$text",
      style: const TextStyle(
        fontSize: 20,
        color: ColorSelect.color5,
      ),
    );
  }
}
