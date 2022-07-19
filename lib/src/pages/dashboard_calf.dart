import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/model/listCardsCalf.dart';
import 'package:vacoro_proyect/src/widgets/window_modal/modal_calf_details.dart';

class DashBoardCalf extends StatefulWidget {
  DashBoardCalf({Key? key}) : super(key: key);

  @override
  State<DashBoardCalf> createState() => _DashBoardCalfState();
}

class _DashBoardCalfState extends State<DashBoardCalf> {
  bool isSwitched = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          "BECERROS",
        ),
        centerTitle: true,
        // iconTheme: const IconThemeData(color: Color(0xff68C34E)),
        actions: [
          Container(
            child: Image.asset('assets/images/calf.png'),
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
                      hintText: 'Buscar Becerros...',
                    ),
                  ),
                ),
              ),
              Container(
                height: size.height * 0.75,
                width: size.width,
                child: Expanded(
                  child: _createCardCalf(size),
                ),
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

  ListView _createCardCalf(Size size) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: List.generate(
          cards_calf.length,
          (index) => Card(
                shadowColor: Colors.black,
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(30)),
                margin: const EdgeInsets.all(15),
                elevation: 10,
                child: InkWell(
                  onTap: () async {
                    print("Detalles VACAS");
                    await showDialog(
                        context: context,
                        builder: (_) => ContainerDialogModalCalfDetail(
                              id: 2,
                            ));
                  },
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 0),
                        width: double.infinity,
                        height: 250,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: Image(
                                height: 100,
                                width: 100,
                                image: AssetImage(cards_calf[index].foto!),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 0),
                              child: Text(
                                cards_calf[index].name! +
                                    "\n" +
                                    cards_calf[index].enfermedad! +
                                    "\n" +
                                    cards_calf[index].dolor!,
                                style: const TextStyle(
                                  color: Color(0xff3E762F),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      print("EDIT");
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Switch(
                                          value: isSwitched,
                                          onChanged: (value) {
                                            setState(() {
                                              isSwitched = value;
                                              print("$value");
                                            });
                                          },
                                          activeColor: const Color(0xff68C34E),
                                          activeTrackColor:
                                              const Color.fromARGB(
                                                  255, 27, 206, 36),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(right: 0),
                                          child: const Text(
                                            'Buen estado',
                                            style: TextStyle(
                                              color: Color(0xff3E762F),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ]),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 0),
                                  child: GestureDetector(
                                      onTap: () {
                                        print("otra TAP");
                                      },
                                      child: Image.asset(
                                        'assets/images/vaccine.png',
                                        height: 30,
                                        scale: 0.7,
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
    );
  }
}
