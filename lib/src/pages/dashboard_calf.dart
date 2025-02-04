import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/model/listCardsCalf.dart';
import 'package:vacoro_proyect/src/pages/anadir_becerro.dart';
import 'package:vacoro_proyect/src/pages/editar_becerro.dart';
import 'package:vacoro_proyect/src/pages/homepage.dart';
import 'package:vacoro_proyect/src/pages/medication_history_calf.dart';
import 'package:vacoro_proyect/src/services/animal_service_calf.dart';
import 'package:vacoro_proyect/src/style/colors/colorview.dart';
import 'package:vacoro_proyect/src/utils/user_secure_storage.dart';
import 'package:vacoro_proyect/src/widgets/widgets_views/widgets_views.dart';
import 'package:vacoro_proyect/src/widgets/window_modal/modal_calf_details.dart';

class DashBoardCalf extends StatefulWidget {
  DashBoardCalf({Key? key}) : super(key: key);

  @override
  State<DashBoardCalf> createState() => _DashBoardCalfState();
}

class _DashBoardCalfState extends State<DashBoardCalf> {
  bool? value1;
  var id_usuario = 0;
  var token = '';
  var name = '';
  var correo = '';
  @override
  void initState() {
    super.initState();
    UserSecureStorage.getId().then((value) {
      UserSecureStorage.getToken().then((token_) {
        UserSecureStorage.getName().then((name_) {
          UserSecureStorage.getCorreo().then((correo_) {
            setState(() {
              int id_cast = int.parse(value!);
              correo = correo_!;
              id_usuario = id_cast;
              token = token_!;
              name = name_!;
            });
          });
        });
      });
    });

    // TODO: implement initState

    value1 = false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: const EdgeInsets.only(right: 0),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => homePage(
                        nombre: name,
                        correo: correo,
                      )),
            );
            // Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: const Text(
          "BECERROS",
        ),
        centerTitle: true,
        // iconTheme: const IconThemeData(color: Color(0xff68C34E)),
        actions: [
          Container(
            child: Image.asset('assets/images/calf.png'),
            height: 60,
            width: 30,
            margin: const EdgeInsets.only(right: 0, left: 3),
          ),
          Container(
            child: Image.asset('assets/images/logoVacoro.png'),
            height: 60,
            width: 170,
            padding: const EdgeInsets.only(left: 90),
          )
        ],
        backgroundColor: const Color(0xff68C34E),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: getAllCalf(id_usuario, token),
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
              if (snapshot.data.length > 0 &&
                  snapshot.data[0]['error'] != 'error') {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FadeInLeft(
                      duration: Duration(milliseconds: 100 * index),
                      child: _createdCardCalf(size, snapshot, index),
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
                        "",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    label: Text("${name.toUpperCase()}."),
                  ),
                  content: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      text: '',
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'No hay historial medico de la vaca ',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text: '${name} ',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const TextSpan(
                          text: 'debe registrar medicamentos a esta vaca.',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          child: const Text(
                            "Registrar",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: ColorSelect.color5,
                            ),
                          ),
                          onPressed: () {
                            print("Registrar historial");
                          },
                        ),
                        TextButton(
                          child: const Text(
                            "Ok",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: ColorSelect.color5,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ],
                );
              }
            }
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: ColorSelect.color5,
        shape: const CircularNotchedRectangle(),
        notchMargin: 1,
        elevation: 2.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 0),
              height: 50,
              width: size.width,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, 'AnadirBecerro');
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xff68C34E),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Card _createdCardCalf(Size size, AsyncSnapshot<dynamic> snapshot, int index) {
    return Card(
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: ColorSelect.color5,
          width: 2,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(40),
      ),
      elevation: 20,
      child: InkWell(
        onTap: () async {
          await showDialog(
              context: context,
              builder: (_) => ContainerDialogModalCalfDetail(
                    id: snapshot.data[index]['id'],
                    token: token,
                  ));
        },
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 0),
              width: size.width,
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: size.width * 0.3,
                      height: 150,
                      margin: const EdgeInsets.only(left: 5, top: 0, bottom: 0),
                      child: CachedNetworkImage(
                        imageUrl: snapshot.data[index]['url_img'],
                        placeholder: (context, url) =>
                            Image.asset('assets/images/loading_green.gif'),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        containerLabel(
                            "Nombre: ${snapshot.data[index]['nombre']}", index),
                        containerLabel(
                            "Nº Arete: ${snapshot.data[index]['num_arete']}",
                            index),
                        containerLabel(
                            "Raza: ${snapshot.data[index]['raza']}", index)
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    EditarBecerro(
                                  id: snapshot.data[index]['id'],
                                  token: token,
                                ),
                              ),
                            );
                          },
                          child: Image.asset(
                            'assets/images/edit_logo.png',
                            height: 30,
                            scale: 0.7,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Switch(
                              value: snapshot.data[index]['estado'],
                              onChanged: (value) {
                                setState(() {
                                  value = value;
                                  print("$value");
                                });
                              },
                              activeColor: const Color(0xff68C34E),
                              activeTrackColor:
                                  const Color.fromARGB(255, 27, 206, 36),
                            ),
                            containerLabel("Buen estado", index)
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 0),
                        child: GestureDetector(
                          onTap: () {
                            print("VACUNAS");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MedicationHitoryCalf(
                                        idAnimal: snapshot.data[index]['id'],
                                        nombre: snapshot.data[index]['nombre'],
                                        idUsuario: id_usuario),
                              ),
                            );
                          },
                          child: Image.asset(
                            'assets/images/vaccine.png',
                            height: 30,
                            scale: 0.7,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
