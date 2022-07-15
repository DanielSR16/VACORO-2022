import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/style/colors/colorview.dart';

class ContainerdDialogCowCalfDetails extends StatelessWidget {
  const ContainerdDialogCowCalfDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      child: SingleChildScrollView(
        child: SizedBox(
          width: size.width * 0.8,
          height: size.height * 0.75,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CloseButton(
                      color: const Color(0xff2F6622),
                      onPressed: () {
                        print("Salir");
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, bottom: 10),
                  child: const Text(
                    "Nombre de la vaca",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xff2F6622),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: size.width * 0.75,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: _input("Nombre"),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20, bottom: 10, top: 20),
                          child: const Text(
                            "Becerros",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xff2F6622),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(children: [
                  _createCardsCowsCategoryModal(size, "Nombre del becerro"),
                  _createCardsCowsCategoryModal(size, "Otra becerro"),
                  _createCardsCowsCategoryModal(size, "Nombre del becerro"),
                  _createCardsCowsCategoryModal(size, "Otra becerro"),
                  _createCardsCowsCategoryModal(size, "Nombre del becerro"),
                  _createCardsCowsCategoryModal(size, "Otra becerro"),
                  _createCardsCowsCategoryModal(size, "Nombre del becerro"),
                  _createCardsCowsCategoryModal(size, "Otra becerro"),
                  _createCardsCowsCategoryModal(size, "Nombre del becerro"),
                  _createCardsCowsCategoryModal(size, "Otra becerro"),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Card _createCardsCowsCategoryModal(Size size, String nameCalf) {
    return Card(
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      margin: const EdgeInsets.all(15),
      elevation: 10,
      child: Column(
        children: [
          Container(
            width: size.width,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Text(
                        "$nameCalf",
                        style: const TextStyle(
                          color: Color(0xff3E762F),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: GestureDetector(
                        onTap: (() => {
                              print("Eliminar Becerro"),
                            }),
                        child: const Icon(
                          Icons.delete_outline_outlined,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _input(String hintText) {
    return TextField(
      onChanged: (text) {},
      decoration: InputDecoration(
        hintStyle: const TextStyle(
          color: ColorSelect.color5,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            style: BorderStyle.solid,
            color: Color(0xff2F6622),
            width: 3,
          ),
        ),
        hintText: hintText,
      ),
    );
  }
}
