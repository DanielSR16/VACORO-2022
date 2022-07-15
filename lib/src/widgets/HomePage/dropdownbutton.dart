// import 'package:flutter/material.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';

// DropdownButtonHideUnderline listaElecciones(){
//   return DropdownButtonHideUnderline(
//     child: DropdownButton2(
//       isExpanded: true,
//           hint: Text(
//             'Select Item',
//             style: TextStyle(
//               fontSize: 14,
//               color: Theme.of(context).hintColor,
//             ),
//           ),
//           items: items
//                   .map((item) => DropdownMenuItem<String>(
//             value: item,
//             child: Text(
//               item,
//               style: const TextStyle(
//                 fontSize: 14,
//               ),
//             ),
//           ))
//                   .toList(),
//           value: selectedValue,
//           onChanged: (value) {
//             setState(() {
//               selectedValue = value as String;
//             });
//           },
//     ),
//   );
// }