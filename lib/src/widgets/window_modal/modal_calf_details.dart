import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/services/editarBecerro.dart';
import 'package:vacoro_proyect/src/services/obtenerVacaToro.dart';
import 'package:vacoro_proyect/src/style/colors/colorview.dart';

//BECERROS
class ContainerDialogModalCalfDetail extends StatefulWidget {
  int id;
  String token;
  ContainerDialogModalCalfDetail(
      {Key? key, required this.id, required this.token})
      : super(key: key);

  @override
  State<ContainerDialogModalCalfDetail> createState() =>
      _ContainerDialogModalCalfDetailState();
}

class _ContainerDialogModalCalfDetailState
    extends State<ContainerDialogModalCalfDetail> {
  late String nombre = '';
  late String descripcion = '';
  late String raza = '';
  late int edad = 0;
  late String num_arete = '';
  late String url_img =
      'https://image-vacoro.s3.amazonaws.com/37b04641-514f-491a-b96e-6a115372a994.jpg';
  late String fecha_llegada = '';
  late String estado = '';
  late String nombre_madre = '';
  late String num_areteMadre = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    becerro_id(widget.id, widget.token).then((value) {
      print(value);
      setState(() {
        nombre = value.nombre;
        descripcion = value.descripcion;
        raza = value.raza;
        edad = value.edad;
        num_arete = value.num_arete;
        url_img = value.url_img ?? 'assets/images/logo.png';
        fecha_llegada = value.fecha_llegada;

        if (value.estado == 1) {
          estado = 'Buen estado';
        } else {
          estado = 'Enfermo';
        }
        if (value.id_vaca != -1) {
          vacatoro_id(value.id_vaca, "Vaca", widget.token).then((value) {
            print(value);
            setState(() {
              nombre_madre = value.nombre;
              num_areteMadre = value.num_arete;
            });
          });
        } else {
          nombre_madre = 'Sin madre';
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
                          "Nombre/Núm. arete de la madre",
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
                      child: _inputVaca(nombre_madre, num_areteMadre),
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
                        child: CachedNetworkImage(
                          imageUrl: url_img,
                          placeholder: (context, url) =>
                              Image.asset('assets/images/loading_green.gif'),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        )),
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

  Widget _inputVaca(String text, String text2) {
    return Text(
      "$text  $text2",
      style: const TextStyle(
        fontSize: 20,
        color: ColorSelect.color5,
      ),
    );
  }
}
