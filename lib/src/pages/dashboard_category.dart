import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/style/colors/colorview.dart';
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
        child: SingleChildScrollView(
            child: Center(
          child: Column(
            children: [
              Center(
                child: Container(
                  width: size.width * 0.90,
                  height: 35,
                  margin: const EdgeInsets.only(top: 40),
                  decoration: BoxDecoration(
                    color: ColorSelect.color2,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                      textAlignVertical: TextAlignVertical.bottom,
                      autocorrect: true,
                      autofocus: false,
                      onChanged: (text) {},
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.purple,
                              width: 1,
                              strokeAlign: StrokeAlign.inside,
                            ),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              print("Buscar Categorias");
                            },
                            child: const Icon(
                              Icons.search,
                              color: Color(0xff229567),
                            ),
                          ),
                          hintText: "Buscar Medicamentos...")),
                ),
              ),
              _createdCardCategory(size, "N",
                  "Aqui va la descripción de la categoria", "Categoria", ""),
              _createdCardCategory(size, "N",
                  "Aqui va la descripción de la categoria", "Categoria", ""),
              _createdCardCategory(size, "N",
                  "Aqui va la descripción de la categoria", "Categoria", ""),
              _createdCardCategory(
                  size,
                  "N",
                  "Aqui va la descripción de la categoria",
                  "Categoria",
                  "Modal1"),
              _createdCardCategory(
                  size,
                  "N",
                  "Aqui va la descripción de la categoria",
                  "Categoria",
                  "Modal"),
              _createdCardCategory(
                  size,
                  "N",
                  "Aqui va la descripción de la categoria",
                  "Categoria",
                  "Modal"),
              _createdCardCategory(
                  size,
                  "N",
                  "Aqui va la descripción de la categoria",
                  "Categoria",
                  "Modal"),
              _createdCardCategory(
                  size,
                  "N",
                  "Aqui va la descripción de la categoria",
                  "Categoria",
                  "Modal"),
              _createdCardCategory(
                  size,
                  "N",
                  "Aqui va la descripción de la categoria",
                  "Categoria",
                  "Modal"),
              _createdCardCategory(
                  size,
                  "N",
                  "Aqui va la descripción de la categoria",
                  "Categoria",
                  "Modal"),
              _createdCardCategory(
                  size,
                  "N",
                  "Aqui va la descripción de la categoria",
                  "Categoria",
                  "Modal"),
            ],
          ),
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Añadir Categoria");
        },
        child: const Icon(Icons.add),
        backgroundColor: ColorSelect.color5,
      ),
    );
  }

  Card _createdCardCategory(Size size, String name, String description,
      String category, String text) {
    return Card(
        shadowColor: Colors.grey,
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(30)),
        margin: const EdgeInsets.all(15),
        elevation: 10,
        child: InkWell(
          onTap: () async {
            print("TAP CARDS");
            await showDialog(
                context: context,
                builder: (_) => ContainerDialogCategoryDetails(text: text));
          },
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                // margin: const EdgeInsets.only(top: 0),
                width: size.width,
                height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      // margin: const EdgeInsets.only(left: 20),
                      child: const Image(
                        image: AssetImage('assets/images/cow.png'),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          // margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Name: $name',
                            style: const TextStyle(
                              color: Color(0xff3E762F),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            'Descripcion: $description',
                            style: const TextStyle(
                              color: Color(0xff3E762F),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            'Categoria: $category',
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
                          // margin: const EdgeInsets.only(left: 50),
                          child: GestureDetector(
                            onTap: (() => {
                                  print("Editar Categoria!"),
                                }),
                            child: Image.asset('assets/images/edit_logo.png'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
