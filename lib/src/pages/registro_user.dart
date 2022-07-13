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
          Row(
            children: [drop_button(220, "Estado"), drop_button(220, "Ciudad")],
          ),
          Container(
            padding: EdgeInsets.only(left: bordes, right: 250),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 5),
                  width: width_media,
                  child: const Text(
                    'Edad',
                    textAlign: TextAlign.left,
                    // ignore: unnecessary_const
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3E762F),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Color(0xFF68C24E)),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF3E762F), width: 2.0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF3E762F), width: 2.0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      labelText: 'Ingrese edad',
                    ),
                  ),
                ),
                const Divider(
                  height: 5,
                ),
              ],
            ),
          ),
          inputs('Ingrese nombre del rancho', 'Nombre del rancho'),
          Container(
            height: 70,
            padding: EdgeInsets.only(
                left: bordes, right: bordes, bottom: 10, top: 10),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFF68C24E)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'registroUser2');
              },
              child: const Text(
                'Siguiente',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          )
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
            ),
          ),
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
          ),
        ],
      ),
    );
  }

  Widget drop_button(
    int tam_width,
    String nameTopField,
  ) {
    String dropdownValue = 'One';
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 10, bottom: 5, left: 30),
          width: width_media - tam_width,
          child: Text(
            nameTopField,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3E762F),
            ),
          ),
        ),
        Container(
            width: width_media - tam_width,
            padding: EdgeInsets.only(left: bordes),
            child: SizedBox(
              height: 40,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color(0xFF3E762F), width: 2.0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButton<String>(
                  alignment: AlignmentDirectional.topEnd,
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
              ),
            )),
      ],
    );
  }
}
