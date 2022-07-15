import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/style/colors/colorview.dart';

class MedicationHistory extends StatefulWidget {
  MedicationHistory({Key? key}) : super(key: key);

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
              print("Regresar");
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
                              print("Buscar medicamentos");
                            },
                            child: const Icon(
                              Icons.search,
                              color: Color(0xff229567),
                            ),
                          ),
                          hintText: "Buscar Historial de medicamentos"),
                    ),
                  ),
                ),
                _createdCardMedicationHistory(size, "Dipirona",
                    "Para los dolores e inflamación.", 1, "10/07/2022"),
                _createdCardMedicationHistory(size, "Dipirona",
                    "Para los dolores e inflamación.", 1, "10/07/2022"),
                _createdCardMedicationHistory(size, "Dipirona",
                    "Para los dolores e inflamación.", 1, "10/07/2022"),
                _createdCardMedicationHistory(size, "Dipirona",
                    "Para los dolores e inflamación.", 1, "10/07/2022"),
                _createdCardMedicationHistory(size, "Dipirona",
                    "Para los dolores e inflamación.", 1, "10/07/2022"),
                _createdCardMedicationHistory(size, "Dipirona",
                    "Para los dolores e inflamación.", 1, "10/07/2022"),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("AGREGAR MEDICAMENTOS??");
        },
        child: const Icon(Icons.add),
        backgroundColor: ColorSelect.color5,
      ),
    );
  }

  Card _createdCardMedicationHistory(Size size, String medicamento,
      String description, int dosis, String fecha_aplicacion) {
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
                        'Medicamento: $medicamento',
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
                        'Dosis: $dosis',
                        style: const TextStyle(
                          color: Color(0xff3E762F),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Fecha aplicada: $fecha_aplicacion',
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
                        onTap: (() => {
                              print("Editar Medicamento!"),
                            }),
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
