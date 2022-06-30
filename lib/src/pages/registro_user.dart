import 'package:flutter/material.dart';

class registroUser extends StatefulWidget {
  const registroUser({Key? key}) : super(key: key);

  @override
  State<registroUser> createState() => _registroUserState();
}

class _registroUserState extends State<registroUser> {
  var size, height_media, width_media;
  late double bordes = 30;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height_media = size.height;
    width_media = size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF68C34E),
        actions: [
          Container(
            width: 50,
            child: Image.asset(
              'assets/images/vacoro-blanco.png',
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(left: bordes, top: 20),
            child: const Text(
              'Registrate',
              style: TextStyle(
                  color: Color(0xFF3E752F),
                  fontSize: 40,
                  fontFamily: 'Cardo',
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: bordes, top: 10),
            child: const Text(
              'Integresa tus datos para crear una cuenta',
              style: TextStyle(
                color: Color(0xFF3E752F),
                fontSize: 17,
                fontFamily: 'Cardo',
              ),
            ),
          ),
          inputs('Nombre', 'Ingrese Nombre'),
          inputs('Apellidos', 'Ingrese Apellidos'),
          inputs('Correo Electronico', 'Ingrese Correo Electronico'),
          inputs('Contraseña', 'Ingrese contraseña'),
          inputs('Repetir contraseña', 'Repila la contraseña'),
          drop_button()
        ],
      ),
    );
  }

  Widget inputs(String nameTopField, String nameInField) {
    return Container(
      padding: EdgeInsets.only(left: bordes, right: bordes),
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.only(top: 10, bottom: 5),
              width: width_media,
              child: Text(
                nameTopField,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3E762F),
                ),
              )),
          SizedBox(
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                labelStyle: const TextStyle(color: Color(0xFF68C24E)),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF3E762F), width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF3E762F), width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                labelText: nameInField,
              ),
            ),
          ),
          const Divider(
            height: 5,
          )
        ],
      ),
    );
  }

  Widget drop_button() {
    String dropdownValue = 'One';
    return Container(
      color: Colors.amber,
      padding: EdgeInsets.only(left: bordes, right: bordes),
      child: DropdownButton<String>(
        style: const TextStyle(
          color: Color(0xFF68C24E),
        ),
        value: dropdownValue,
        items: <String>['One', 'Two', 'Free', 'Four']
            .map<DropdownMenuItem<String>>(
          (String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          },
        ).toList(),
        onChanged: (String? newValue) {
          setState(
            () {
              dropdownValue = newValue!;
            },
          );
        },
      ),
    );
  }
}
