import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/services/obtenerBecerro_Vaca.dart';
import 'package:vacoro_proyect/src/style/colors/colorview.dart';

import '../../services/deleteCategoriabyAnimal.dart';
import '../../services/deleteHistorialAnimal.dart';
import '../../services/editarBecerro.dart';
import '../../utils/user_secure_storage.dart';

class ContainerdDialogCowCalfDetails extends StatefulWidget {
  int id_vaca;
  String nombreVaca;
  ContainerdDialogCowCalfDetails(
      {Key? key, required this.nombreVaca, required this.id_vaca})
      : super(key: key);

  @override
  State<ContainerdDialogCowCalfDetails> createState() =>
      _ContainerdDialogCowCalfDetailsState();
}

class _ContainerdDialogCowCalfDetailsState
    extends State<ContainerdDialogCowCalfDetails> {
  int id_usuario = 0;
  var token = '';
  var name = '';
  @override
  void initState() {
    super.initState();
    UserSecureStorage.getId().then((value) {
      UserSecureStorage.getToken().then((token_) {
        UserSecureStorage.getName().then((name_) {
          setState(() {
            int id_cast = int.parse(value!);
            id_usuario = id_cast;
            token = token_!;
            name = name_!;
            print(token);
          });
        });
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
                Container(
                  margin: const EdgeInsets.only(left: 20, bottom: 10),
                  child: const Text(
                    "Nombre de la vaca",
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
                    child: _input("Nombre"),
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
                            "Becerros",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xff2F6622),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                FutureBuilder(
                  future: getBecerrobyIdvaca(widget.id_vaca, token),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 5,
                          backgroundColor: ColorSelect.color5,
                          color: Colors.white,
                        ),
                      );
                    } else {
                      if (snapshot.data.length > 0) {
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return FadeInLeft(
                              duration: Duration(milliseconds: 100 * index),
                              child: _createCardsCowsCategoryModal(
                                  size, snapshot, index),
                            );
                          },
                        );
                      } else {
                        return AlertDialog(
                          elevation: 20,
                          title: Chip(
                            backgroundColor: ColorSelect.color2,
                            avatar: CircleAvatar(
                              backgroundColor: ColorSelect.color5,
                              foregroundColor: Colors.white,
                              child: Text(
                                "${name[0].toUpperCase()}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            label: Text("${name.toUpperCase()}."),
                          ),
                          content: RichText(
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: const <TextSpan>[
                                TextSpan(
                                  text: 'La vaca no tiene becerros ',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Card _createCardsCowsCategoryModal(
      Size size, AsyncSnapshot<dynamic> snapshot, int index) {
    return Card(
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      margin: const EdgeInsets.all(15),
      elevation: 10,
      child: Column(
        children: [
          Container(
            width: size.width,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Text(
                        snapshot.data[index]['nombre'],
                        style: const TextStyle(
                          color: Color(0xff3E762F),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: IconButton(
                        splashRadius: 25,
                        icon: const Icon(
                          Icons.delete_outline_outlined,
                          color: ColorSelect.color5,
                        ),
                        onPressed: () {
                          servicedeletebecerro_categoria(
                                  snapshot.data[index]['id'])
                              .then((categoria) {
                            if (categoria['status'] == 'ok') {
                              servicedeletebecerro_historial(
                                      snapshot.data[index]['id'], token)
                                  .then((historial) {
                                if (historial['status'] == 'ok') {
                                  servicedeletebecerro(
                                          token, snapshot.data[index]['id'])
                                      .then((value) {
                                    if (value['status'] == 'ok') {
                                      Future.delayed(
                                          const Duration(milliseconds: 200),
                                          () {
                                        setState(() {
                                          // Here you can write your code for open new view
                                        });
                                      });
                                    }
                                  });
                                }
                              });
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
