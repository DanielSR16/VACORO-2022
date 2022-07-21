import 'package:flutter/cupertino.dart';

Container containerLabel(String text, int index) {
  return Container(
    margin: const EdgeInsets.only(left: 0),
    child: Text(
      text,
      style: const TextStyle(
        color: Color(0xff3E762F),
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
