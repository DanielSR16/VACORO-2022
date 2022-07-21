import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/services/service_medication_history.dart';
import 'package:vacoro_proyect/src/style/colors/colorview.dart';
import 'package:vacoro_proyect/src/widgets/widgets_views/widgets_views.dart';

class MedicationHistory extends StatefulWidget {
  int id_animal;
  String nombre;
  MedicationHistory({Key? key, required this.id_animal, required this.nombre})
      : super(key: key);

  @override
  State<MedicationHistory> createState() => _MedicationHistoryState();
}

class _MedicationHistoryState extends State<MedicationHistory> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: const Text("HISTORIAL DE MEDICAMENTOS"),
        centerTitle: true,
        actions: [
          Container(
            height: 60,
            width: 60,
            child: Image.asset('assets/images/logoVacoro.png'),
          )
        ],
        backgroundColor: ColorSelect.color5,
      ),
      body: SafeArea(
        child: _futureBuildCowHistory(size),
      ),
    );
  }

  FutureBuilder<dynamic> _futureBuildCowHistory(Size size) {
    return FutureBuilder(
      future: getMedicationHistoryByIdCow(widget.id_animal),
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
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return FadeInLeft(
                  child:
                      _createdCardMedicationHistoryCow(size, snapshot, index),
                );
              },
            );
          } else {
            return Center(
              child: _alertDialogCow(context),
            );
          }
        }
      },
    );
  }

  AlertDialog _alertDialogCow(BuildContext context) {
    return AlertDialog(
      title: Chip(
        backgroundColor: ColorSelect.color2,
        avatar: CircleAvatar(
          backgroundColor: ColorSelect.color5,
          foregroundColor: Colors.white,
          child: Text(
            "${widget.nombre[0].toUpperCase()}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        label: Text("${widget.nombre.toUpperCase()}."),
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
              text: '${widget.nombre} ',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const TextSpan(
              text: 'debe registrar medicamentos a esta vaca.',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      actions: [
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
        )
      ],
    );
  }

  Card _createdCardMedicationHistoryCow(
      Size size, AsyncSnapshot<dynamic> snapshot, int index) {
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
                          "Dosis: ${snapshot.data[index]['dosis']}", index),
                      containerLabel(
                          'Descripción: ${snapshot.data[index]['descripcion']}',
                          index),
                      containerLabel(
                          'Fecha de apliación: ${snapshot.data[index]['fecha_aplicacion']}',
                          index)
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: () {
                              print("Edit historial");
                            },
                            child: Image.asset(
                              'assets/images/edit_logo.png',
                              height: 30,
                              scale: 0.7,
                            ),
                          ),
                        ),
                      ],
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
}
