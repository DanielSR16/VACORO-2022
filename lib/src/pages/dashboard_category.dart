import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/services/category_service.dart';
import 'package:vacoro_proyect/src/style/colors/colorview.dart';
import 'package:vacoro_proyect/src/widgets/widgets_views/widgets_views.dart';
import 'package:vacoro_proyect/src/widgets/window_modal/modal_category_details.dart';

class DashboardCategory extends StatefulWidget {
  DashboardCategory({Key? key}) : super(key: key);

  @override
  State<DashboardCategory> createState() => _DashboardCategoryState();
}

class _DashboardCategoryState extends State<DashboardCategory> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            print("Regresar...");
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("CATEGORIAS"),
        centerTitle: true,
        actions: [
          Container(
            child: Image.asset('assets/images/logoVacoro.png'),
            height: 60,
            width: 60,
          )
        ],
        backgroundColor: ColorSelect.color5,
      ),
      body: SafeArea(
        child: _futureBuilderCategory(size),
      ),
      bottomNavigationBar: BottomAppBar(
        color: ColorSelect.color5,
        shape: const CircularNotchedRectangle(),
        notchMargin: 1,
        elevation: 2.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 0),
              height: 50,
              width: size.width,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(
              "Añadir Categoria /////////////////////////////////////////////////");
          Navigator.popAndPushNamed(context, 'anadir_categoria');
        },
        child: const Icon(Icons.add),
        backgroundColor: ColorSelect.color5,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  FutureBuilder<dynamic> _futureBuilderCategory(Size size) {
    return FutureBuilder(
      future: getCategoryAll(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 5,
              backgroundColor: ColorSelect.color5,
              color: Colors.white,
            ),
          );
        } else {
          if (snapshot.data.length > 0) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return FadeInLeft(
                  duration: Duration(milliseconds: 100 * index),
                  delay: Duration(milliseconds: 100 * index),
                  child: _createdCardCategory(size, snapshot, index),
                );
              },
            );
          } else {
            return Center(
              child: _alertDialogCategory(context),
            );
          }
        }
      },
    );
  }

  Card _createdCardCategory(
      Size size, AsyncSnapshot<dynamic> snapshot, int index) {
    return Card(
      shadowColor: ColorSelect.color5,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: ColorSelect.color5,
          width: 2,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(40),
      ),
      elevation: 20,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 0),
            width: size.width,
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      containerLabel(
                          "Nombre: ${snapshot.data[index]['nombre']}", index),
                      containerLabel(
                          'Descripción: ${snapshot.data[index]['descripcion']}',
                          index),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, 'editar_categoria');
                            },
                            child: Image.asset(
                              'assets/images/edit_logo.png',
                              height: 30,
                              scale: 0.7,
                            ),
                          ),
                        ),
                      ],
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

  AlertDialog _alertDialogCategory(BuildContext context) {
    return AlertDialog(
      elevation: 20,
      title: const Text("Sin categorias"),
      content: const Text("Para visualizar las categorias, debe de agregarlas"),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              child: const Text(
                "Registrar",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ColorSelect.color5,
                ),
              ),
              onPressed: () {
                print("Registrar historial");
              },
            ),
            TextButton(
              child: const Text(
                "Ok",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ColorSelect.color5,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ],
    );
  }

  // Card _createdCardCategory(Size size, String name, String description,
  //     String category, String text) {
  //   return Card(
  //     shadowColor: Colors.grey,
  //     // shape: RoundedRectangleBorder(
  //     //     borderRadius: BorderRadius.circular(30)),
  //     margin: const EdgeInsets.all(15),
  //     elevation: 10,
  //     child: InkWell(
  //       onTap: () async {
  //         print("TAP CARDS");
  //         await showDialog(
  //             context: context,
  //             builder: (_) => ContainerDialogCategoryDetails(text: text));
  //       },
  //       child: Column(
  //         // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           Container(
  //             // margin: const EdgeInsets.only(top: 0),
  //             width: size.width,
  //             height: 200,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //               children: [
  //                 Container(
  //                   // margin: const EdgeInsets.only(left: 20),
  //                   child: const Image(
  //                     image: AssetImage('assets/images/cow.png'),
  //                   ),
  //                 ),
  //                 Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Container(
  //                       // margin: const EdgeInsets.only(left: 10),
  //                       child: Text(
  //                         'Name: $name',
  //                         style: const TextStyle(
  //                           color: Color(0xff3E762F),
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                     ),
  //                     Container(
  //                       child: Text(
  //                         'Descripcion: $description',
  //                         style: const TextStyle(
  //                           color: Color(0xff3E762F),
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                     ),
  //                     Container(
  //                       child: Text(
  //                         'Categoria: $category',
  //                         style: const TextStyle(
  //                           color: Color(0xff3E762F),
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 Column(
  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   children: [
  //                     Container(
  //                       // margin: const EdgeInsets.only(left: 50),
  //                       child: GestureDetector(
  //                         onTap: (() => {
  //                               print("Editar Categoria!"),
  //                             }),
  //                         child: Image.asset('assets/images/edit_logo.png'),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
