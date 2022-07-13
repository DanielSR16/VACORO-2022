import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/model/cards.dart'; //82F562

SizedBox listaCards(context){
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.25,
    width: double.infinity,
    child: ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: tarjetasHome.length,
      itemBuilder: (_, index) {
      return createCard(context,tarjetasHome[index].imagen,tarjetasHome[index].descripcion,index);
      },
    )
  );
}

GestureDetector createCard(context,imagen,texto,id){
  return GestureDetector(
    onTap: (){
      if (id == 0){
        print("VISTA DE MEDICAMENTOS");
      }else if(id == 1){
        print("VISTA DE CATEGORIAS");
      }
    },
    child: Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.green, spreadRadius: 3),
        ],
      ),
    child: Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 30)),
        Expanded(
          child: Image(
            image: AssetImage(imagen),
          ),
        ),
        Expanded(
          child: Container(
            //margin: const EdgeInsets.only(top: 20),
            child: Text(
              texto,
              style: TextStyle(
                  color: HexColor("#3E762F"),
                  //fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
            ),
          ),
        )
      ],
    ),
    ),
  );
}