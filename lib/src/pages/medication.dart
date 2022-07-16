import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/style/colors/colorview.dart';
import 'package:vacoro_proyect/src/widgets/window_modal/modal_add_medication.dart';

class Medication extends StatefulWidget {
  Medication({Key? key}) : super(key: key);

  @override
  State<Medication> createState() => _MedicationState();
}

class _MedicationState extends State<Medication> {
  String? medication = '';
  String? description = '';
  int? cant = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
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
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: 35,
                    width: 350,
                    margin: const EdgeInsets.only(top: 40),
                    decoration: BoxDecoration(
                      color: ColorSelect.color2,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      textAlignVertical: TextAlignVertical.bottom,
                      autocorrect: true,
                      autofocus: false,
                      onChanged: (text) {},
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.purple,
                              width: 1,
                              strokeAlign: StrokeAlign.inside,
                            ),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              print("Buscar Medicamentos, TAP");
                            },
                            child: const Icon(
                              Icons.search,
                              color: Color(0xff229567),
                            ),
                          ),
                          hintText: "Buscar Medicamentos..."),
                    ),
                  ),
                ),
                ///////////////////////////////////////////////
                _createdCardMedication(
                    size, "Jarabe", "Para la diarrea", 10, "MODAL"),
                _createdCardMedication(
                    size, "Inyección", "Para la fiebre", 200, "MODAL2"),
                _createdCardMedication(
                    size, "medication", "description", 50, "MODAL3")
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Agregar Medicamento");
        },
        child: const Icon(Icons.add),
        backgroundColor: ColorSelect.color5,
      ),
    );
  }

  Card _createdCardMedication(Size size, String medication, String description,
      int cantidad, String text) {
    return Card(
      shadowColor: Colors.grey,
      // shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(30)),
      margin: const EdgeInsets.all(15),
      elevation: 10,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            // margin: const EdgeInsets.only(top: 0),
            width: size.width,
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  // margin: const EdgeInsets.only(left: 20),
                  child: const Image(
                    image: AssetImage('assets/images/cow.png'),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      // margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Medicamento: $medication',
                        style: const TextStyle(
                          color: Color(0xff3E762F),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Descripcion: $description',
                        style: const TextStyle(
                          color: Color(0xff3E762F),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Cantidad: $cantidad disponibles',
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
                      // margin: const EdgeInsets.only(left: 50),
                      child: GestureDetector(
                        onTap: () async {
                          // print("Editar Medicamento!")
                          await showDialog(
                              context: context,
                              builder: (_) => DialogContainer(text: text));
                        },
                        child: Image.asset('assets/images/edit_logo.png'),
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
}
