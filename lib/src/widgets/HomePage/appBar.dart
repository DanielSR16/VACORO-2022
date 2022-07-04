import 'package:flutter/material.dart';

Drawer drawer(texto,imagen){
  return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
              DrawerHeader(
                   child: Text("Header")),
              ListTile(
                  title: Text("Home"))
        ]),
  );
}