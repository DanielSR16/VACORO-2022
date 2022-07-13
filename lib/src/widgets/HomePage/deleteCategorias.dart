import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Container deleteCat(texto,altura){
  return Container(
    margin: EdgeInsets.only(right: 15, top: altura),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          child: TextButton(
            child: Text(texto+"     "),
            onPressed: (){
              print("presiono");
            },
          ),
        ),
        //Text(texto),
        Icon(Icons.delete, color: Colors.grey)
      ],
    ),
  );
}