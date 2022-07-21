import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/services/medication_service.dart';
import 'package:vacoro_proyect/src/style/colors/colorview.dart';
import 'package:vacoro_proyect/src/utils/user_secure_storage.dart';
import 'package:vacoro_proyect/src/widgets/widgets_views/widgets_views.dart';
import 'package:vacoro_proyect/src/widgets/window_modal/modal_add_medication.dart';
import 'package:vacoro_proyect/src/widgets/window_modal/modal_edit_medication.dart';

class Medication extends StatefulWidget {
  Medication({Key? key}) : super(key: key);

  @override
  State<Medication> createState() => _MedicationState();
}

class _MedicationState extends State<Medication> {
  late int id_usuario = 0;
  late String token = '';
  @override
  void initState() {
    super.initState();
    UserSecureStorage.getId().then((value) {
      UserSecureStorage.getToken().then((token_) {
        setState(() {
          int id_cast = int.parse(value!);

          id_usuario = id_cast;
          token = token_!;
        });
      });
    });

    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('MEDICAMENTOS'),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(left: 0),
            child: Image.asset('assets/images/logoVacoro.png'),
            height: 60,
            width: 100,
          )
        ],
        backgroundColor: ColorSelect.color5,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: getMedicationAll(id_usuario,token),
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
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return FadeInLeft(
                    duration: Duration(milliseconds: 100 * index),
                    child: _createdCardMedication(size, snapshot, index),
                  );
                },
              );
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
        onPressed: () async {
          // print("Agregar Medicamento");
          await showDialog(
            context: context,
            builder: (_) => DialogContainerAddMedication(),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: ColorSelect.color5,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Card _createdCardMedication(Size size, AsyncSnapshot snapshot, int index) {
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
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 0),
            width: size.width,
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      containerLabel(
                          "Nombre: ${snapshot.data[index]['nombre']}", index),
                      containerLabel(
                          "Descripción: ${snapshot.data[index]['descripcion']}",
                          index),
                      containerLabel(
                          "Cantidad: ${snapshot.data[index]['cantidad']}",
                          index),
                      containerLabel(
                          "Fecha Caducidad: ${snapshot.data[index]['fecha_caducidad']}",
                          index)
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 40, right: 0),
                      child: GestureDetector(
                        onTap: () async {
                          // print("Edit Medicina");

                          await showDialog(
                            context: context,
                            builder: (_) => ContainerDialogEditMedication(),
                          );
                        },
                        child: Image.asset(
                          'assets/images/edit_logo.png',
                          height: 30,
                          scale: 0.7,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
