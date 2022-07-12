import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Container botones(context,imagen,texto){
  return Container(
    margin: EdgeInsets.all(20),
    width: MediaQuery.of(context).size.width,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: HexColor("#68C34E")
      ),
      onPressed: () => {

      },
      child: Container(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20),
        child:Row(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Image(
                  image: AssetImage(imagen),
                ),
            ),
            Container(
                margin: const EdgeInsets.only( left: 30.0 ),
                child: Text(
                  texto,
                  textAlign: TextAlign.center,
                  style: const TextStyle( fontSize: 20.0),
                )
            )
          ],
        ),
      ),
    ),
  );
}