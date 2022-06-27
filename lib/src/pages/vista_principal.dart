import 'package:flutter/material.dart';

class vista_principal extends StatefulWidget {
  const vista_principal({Key? key}) : super(key: key);

  @override
  State<vista_principal> createState() => _vista_principalState();
}

class _vista_principalState extends State<vista_principal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('PRUEBA FEATURE'),
    );
  }
}
