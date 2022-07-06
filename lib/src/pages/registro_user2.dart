import 'package:flutter/material.dart';

class registroUser2 extends StatefulWidget {
  const registroUser2({super.key});

  @override
  State<registroUser2> createState() => _registroUser2State();
}

class _registroUser2State extends State<registroUser2> {
  @override
  var size, height_media, width_media;
  late double bordes = 30;
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height_media = size.height;
    width_media = size.width;
    return Container(
      child: Scaffold(
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
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: bordes, top: 20),
                  child: const Text(
                    'Tomate una fotografia o agregala a tu \nperfil',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xFF3E752F),
                      fontSize: 45,
                      fontFamily: 'Cardo',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
