import 'package:flutter/material.dart';

class DashBoardCalf extends StatefulWidget {
  DashBoardCalf({Key? key}) : super(key: key);

  @override
  State<DashBoardCalf> createState() => _DashBoardCalfState();
}

class _DashBoardCalfState extends State<DashBoardCalf> {
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
              Card(
                shadowColor: Colors.grey,
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(30)),
                margin: const EdgeInsets.all(15),
                elevation: 10,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 0),
                      width: size.width,
                      height: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: const Image(
                              image: AssetImage('assets/images/calf.png'),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: const Text(
                              'Juan \nEnfermedad estomacal\nSufriendo Mucho',
                              style: TextStyle(
                                color: Color(0xff3E762F),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: const Icon(
                                  Icons.edit,
                                  color: Color(0xff3E762F),
                                  size: 50,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: const Icon(
                                  Icons.check_box_rounded,
                                  color: Color(0xff3E762F),
                                  size: 50,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: const Text(
                                  'Buen estado',
                                  style: TextStyle(
                                    color: Color(0xff3E762F),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: const Icon(
                                  Icons.medical_services_sharp,
                                  color: Color(0xff3E762F),
                                  size: 50,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                shadowColor: Colors.grey,
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(30)),
                margin: const EdgeInsets.all(15),
                elevation: 10,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 0),
                      width: size.width,
                      height: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: const Image(
                              image: AssetImage('assets/images/calf.png'),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: const Text(
                              'Juan \nEnfermedad estomacal\nSufriendo Mucho',
                              style: TextStyle(
                                color: Color(0xff3E762F),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: const Icon(
                                  Icons.edit,
                                  color: Color(0xff3E762F),
                                  size: 50,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: const Icon(
                                  Icons.check_box_rounded,
                                  color: Color(0xff3E762F),
                                  size: 50,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: const Text(
                                  'Buen estado',
                                  style: TextStyle(
                                    color: Color(0xff3E762F),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: const Icon(
                                  Icons.medical_services_sharp,
                                  color: Color(0xff3E762F),
                                  size: 50,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                shadowColor: Colors.grey,
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(30)),
                margin: const EdgeInsets.all(15),
                elevation: 10,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 0),
                      width: size.width,
                      height: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: const Image(
                              image: AssetImage('assets/images/calf.png'),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: const Text(
                              'Juan \nEnfermedad estomacal\nSufriendo Mucho',
                              style: TextStyle(
                                color: Color(0xff3E762F),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: const Icon(
                                  Icons.edit,
                                  color: Color(0xff3E762F),
                                  size: 50,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: const Icon(
                                  Icons.check_box_rounded,
                                  color: Color(0xff3E762F),
                                  size: 50,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: const Text(
                                  'Buen estado',
                                  style: TextStyle(
                                    color: Color(0xff3E762F),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: const Icon(
                                  Icons.medical_services_sharp,
                                  color: Color(0xff3E762F),
                                  size: 50,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                shadowColor: Colors.grey,
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(30)),
                margin: const EdgeInsets.all(15),
                elevation: 10,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 0),
                      width: size.width,
                      height: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: const Image(
                              image: AssetImage('assets/images/calf.png'),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: const Text(
                              'Juan \nEnfermedad estomacal\nSufriendo Mucho',
                              style: TextStyle(
                                color: Color(0xff3E762F),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: const Icon(
                                  Icons.edit,
                                  color: Color(0xff3E762F),
                                  size: 50,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: const Icon(
                                  Icons.check_box_rounded,
                                  color: Color(0xff3E762F),
                                  size: 50,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: const Text(
                                  'Buen estado',
                                  style: TextStyle(
                                    color: Color(0xff3E762F),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: const Icon(
                                  Icons.medical_services_sharp,
                                  color: Color(0xff3E762F),
                                  size: 50,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                shadowColor: Colors.grey,
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(30)),
                margin: const EdgeInsets.all(15),
                elevation: 10,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 0),
                      width: size.width,
                      height: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: const Image(
                              image: AssetImage('assets/images/calf.png'),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: const Text(
                              'Juan \nEnfermedad estomacal\nSufriendo Mucho',
                              style: TextStyle(
                                color: Color(0xff3E762F),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: const Icon(
                                  Icons.edit,
                                  color: Color(0xff3E762F),
                                  size: 50,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: const Icon(
                                  Icons.check_box_rounded,
                                  color: Color(0xff3E762F),
                                  size: 50,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: const Text(
                                  'Buen estado',
                                  style: TextStyle(
                                    color: Color(0xff3E762F),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: const Icon(
                                  Icons.medical_services_sharp,
                                  color: Color(0xff3E762F),
                                  size: 50,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                shadowColor: Colors.grey,
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(30)),
                margin: const EdgeInsets.all(15),
                elevation: 10,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 0),
                      width: size.width,
                      height: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: const Image(
                              image: AssetImage('assets/images/calf.png'),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: const Text(
                              'Juan \nEnfermedad estomacal\nSufriendo Mucho',
                              style: TextStyle(
                                color: Color(0xff3E762F),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: const Icon(
                                  Icons.edit,
                                  color: Color(0xff3E762F),
                                  size: 50,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: const Icon(
                                  Icons.check_box_rounded,
                                  color: Color(0xff3E762F),
                                  size: 50,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: const Text(
                                  'Buen estado',
                                  style: TextStyle(
                                    color: Color(0xff3E762F),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: const Icon(
                                  Icons.medical_services_sharp,
                                  color: Color(0xff3E762F),
                                  size: 50,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                shadowColor: Colors.grey,
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(30)),
                margin: const EdgeInsets.all(15),
                elevation: 10,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 0),
                      width: size.width,
                      height: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: const Image(
                              image: AssetImage('assets/images/calf.png'),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: const Text(
                              'Juan \nEnfermedad estomacal\nSufriendo Mucho',
                              style: TextStyle(
                                color: Color(0xff3E762F),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: const Icon(
                                  Icons.edit,
                                  color: Color(0xff3E762F),
                                  size: 50,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: const Icon(
                                  Icons.check_box_rounded,
                                  color: Color(0xff3E762F),
                                  size: 50,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: const Text(
                                  'Buen estado',
                                  style: TextStyle(
                                    color: Color(0xff3E762F),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: const Icon(
                                  Icons.medical_services_sharp,
                                  color: Color(0xff3E762F),
                                  size: 50,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
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
}
