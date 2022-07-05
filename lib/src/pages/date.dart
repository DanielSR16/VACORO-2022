import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vacoro_proyect/src/style/colors/colorview.dart';

class date extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _date();
  }
}

class _date extends State<date> {
  TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    dateinput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            width: size.width,
            child: const Text(
              "Fecha de llegada",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3E762F),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.calendar_today,
                  color: ColorSelect.color1,
                ),
                iconColor: ColorSelect.color1,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorSelect.color1, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorSelect.color1, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                labelText: "Seleccionar la fecha de llegada",
                labelStyle: TextStyle(color: ColorSelect.color5),
              ),
              controller: dateinput,
              readOnly:
                  true, //Para que el usuario no pueda editar en el textField
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(
                      2001, //Fecha limite para seleccionar
                    ),
                    lastDate: DateTime(2101),
                    //Fecha limite para seleccionar
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: ColorSelect.color5,
                            onPrimary: Colors.white,
                            onSecondary: ColorSelect.color1,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              primary: ColorSelect.color1, // button text color
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    });
                if (pickedDate != null) {
                  String formattedDate = DateFormat('yyyy-MM-dd')
                      .format(pickedDate); //La fecha se mostrar en este formato
                  setState(
                    () {
                      dateinput.text =
                          formattedDate; //Fecha de salida en el textField
                      // print(formattedDate);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
