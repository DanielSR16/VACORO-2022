import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/model/listCardsBull.dart';
import 'package:vacoro_proyect/src/services/animal_service_bull.dart';
import 'package:vacoro_proyect/src/style/colors/colorview.dart';
import 'package:vacoro_proyect/src/widgets/widgets_views/widgets_views.dart';
import 'package:vacoro_proyect/src/widgets/window_modal/modal_bull_details.dart';

class DashBoardBull extends StatefulWidget {
  DashBoardBull({Key? key}) : super(key: key);

  @override
  State<DashBoardBull> createState() => _DashBoardBullState();
}

class _DashBoardBullState extends State<DashBoardBull> {
  bool? value;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    value = false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: const EdgeInsets.only(right: 0),
          onPressed: () {
            // Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: const Text(
          "TOROS",
        ),
        centerTitle: true,
        // iconTheme: const IconThemeData(color: Color(0xff68C34E)),
        actions: [
          Container(
            child: Image.asset('assets/images/bull.png'),
            height: 60,
            width: 30,
            margin: const EdgeInsets.only(right: 0, left: 3),
          ),
          Container(
            child: Image.asset('assets/images/logoVacoro.png'),
            height: 60,
            width: 170,
            padding: const EdgeInsets.only(left: 90),
          )
        ],
        backgroundColor: const Color(0xff68C34E),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  height: 35,
                  width: 350,
                  margin: const EdgeInsets.only(top: 40),
                  decoration: BoxDecoration(
                    color: const Color(0xffBDF7AD),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    textAlignVertical: TextAlignVertical.bottom,
                    onChanged: (text) {},
                    decoration: const InputDecoration(
                      // focusColor: Colors.grey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        borderSide: BorderSide(
                          color: Colors.pink,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      suffixIcon: Icon(
                        Icons.search,
                        color: Color(0xff229567),
                      ),
                      hintText: 'Buscar Toros...',
                    ),
                  ),
                ),
              ),
              FutureBuilder(
                future: getAllBull(),
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
                    return Container(
                      height: size.height,
                      width: size.width,
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return FadeIn(
                              duration: Duration(milliseconds: 200 * index),
                              child: _createdCardBull(size, snapshot, index),
                            );
                          }),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xff68C34E),
      ),
    );
  }

  Card _createdCardBull(Size size, AsyncSnapshot<dynamic> snapshot, int index) {
    return Card(
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: ColorSelect.color5,
          width: 2,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(40),
      ),
      elevation: 20,
      child: InkWell(
        onTap: () async {
          await showDialog(
              context: context,
              builder: (_) => ContainerDialogModalBullDetail());
        },
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 0),
              width: size.width,
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: size.width * 0.3,
                    height: 150,
                    margin: const EdgeInsets.only(left: 5, top: 0, bottom: 0),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loading_green.gif',
                      image: snapshot.data[index]['url_img'],
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        containerLabel(
                            "Nombre: ${snapshot.data[index]['nombre']}", index),
                        containerLabel(
                            "Número De Arete: ${snapshot.data[index]['num_arete']}",
                            index),
                        containerLabel(
                            "Raza: ${snapshot.data[index]['raza']}", index),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            print("Edit Bull");
                          },
                          child: Image.asset(
                            'assets/images/edit_logo.png',
                            height: 30,
                            scale: 0.7,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Switch(
                              value: snapshot.data[index]['estado'],
                              onChanged: (value) {
                                setState(() {
                                  value = value;
                                  print("$value");
                                });
                              },
                              activeColor: const Color(0xff68C34E),
                              activeTrackColor:
                                  const Color.fromARGB(255, 27, 206, 36),
                            ),
                            containerLabel("Buen estado", index)
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 0),
                        child: GestureDetector(
                          onTap: () {
                            print("VACUNAS");
                          },
                          child: Image.asset(
                            'assets/images/vaccine.png',
                            height: 30,
                            scale: 0.7,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
