import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vacoro_proyect/src/pages/date.dart';
import 'package:vacoro_proyect/src/style/colors/colorview.dart';

class EditarAnimal extends StatefulWidget {
  const EditarAnimal({Key? key}) : super(key: key);

  @override
  State<EditarAnimal> createState() => _EditarAnimalState();
}

class _EditarAnimalState extends State<EditarAnimal> {
  File? image;
  bool isSwitched = false;
  TextEditingController nombreVacaToroEditar = TextEditingController();
  TextEditingController descripcionVacaToroEditar = TextEditingController();
  TextEditingController razaVacaToroEditar = TextEditingController();
  TextEditingController numeroAreteVacaToroEditar = TextEditingController();

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      //final imageTemporary = File(image.path);
      final imageTemporary = await saveImagePermanently(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double bordes = 20.0;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Center(
          child: Text(
            'EDITAR ANIMAL',
            style: TextStyle(fontSize: 18),
          ),
        ),
        leading: SizedBox(
          child: IconButton(
            splashRadius: 15,
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 40,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(left: 30),
            width: 85,
            child: Image.asset('assets/images/logo_blanco.png'),
          )
        ],
        backgroundColor: ColorSelect.color5,
      ),
      body: SizedBox(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: bordes, left: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  inputs("Nombre", "", size, nombreVacaToroEditar),
                  inputs("Descripción", "", size, descripcionVacaToroEditar),
                  inputs("Raza", "", size, razaVacaToroEditar),
                  inputs(
                      "Número de arete", "", size, numeroAreteVacaToroEditar),
                  date(),
                  edadEstado("Edad", "Buen estado", size),
                  selectImage(),
                  Container(
                    width: 220,
                    margin: const EdgeInsets.only(left: 88),
                    padding:
                        const EdgeInsets.only(left: 20, bottom: 20, top: 25),
                    child: Material(
                      color: Colors.transparent, // button color
                      child: InkWell(
                        splashColor: Colors.green, // splash color
                        onTap: () {}, // button pressed
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Text("Borrar animal de mi lista",
                                style: TextStyle(
                                    fontSize: 16, color: ColorSelect.color5)),
                            Icon(
                              Icons.delete,
                              color: ColorSelect.color1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 20),
                    child: SizedBox(
                      width: size.width - 50,
                      height: 50,
                      child: ElevatedButton(
                          child: const Text(
                            'Editar',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              primary: ColorSelect.color5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)))),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget inputs(String nameTopField, String nameInField, Size size,
      TextEditingController controllerInput) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            width: size.width,
            child: Text(
              nameTopField,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3E762F),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: TextField(
              controller: controllerInput,
              decoration: InputDecoration(
                labelStyle: const TextStyle(color: ColorSelect.color5),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorSelect.color1, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorSelect.color5, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                labelText: nameInField,
              ),
            ),
          ),
          const Divider(
            height: 5,
          )
        ],
      ),
    );
  }

  Widget buildButton({
    required String title,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(35),
          primary: ColorSelect.color1,
          onPrimary: Colors.white,
          textStyle: const TextStyle(fontSize: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        child: Row(children: [
          const SizedBox(width: 2),
          Text(title),
        ]),
        onPressed: onClicked,
      );

  Widget selectImage() {
    return Row(
      children: <Widget>[
        Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
              child: const Text(
                'Imagen de su marca',
                style: TextStyle(
                  color: ColorSelect.color1,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16),
              child: image != null
                  ? Image.file(
                      image!,
                      width: 160,
                      height: 150,
                      fit: BoxFit.cover,
                    )
                  : const Image(
                      width: 160,
                      height: 150,
                      image: AssetImage('assets/images/logo.png'),
                    ),
            ),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          padding: const EdgeInsets.only(
            //left: 1,
            right: 1,
          ),
          child: SizedBox(
            width: 140,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildButton(
                  title: 'Elija una imagen',
                  icon: Icons.image_outlined,
                  onClicked: () => pickImage(),
                ),
                buildButton(
                  title: 'Tomar fotografía',
                  icon: Icons.image_outlined,
                  onClicked: () => pickCamera(),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget edadEstado(String nameTopField, String nameTopField2, Size size) {
    var dropdownValue = "1 años";
    return Row(
      children: <Widget>[
        Container(
          width: 240,
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                width: size.width,
                child: Text(
                  nameTopField,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ColorSelect.color1,
                  ),
                ),
              ),
              SizedBox(
                height: 45,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorSelect.color1, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        fillColor: Colors.white),
                    value: dropdownValue,
                    iconSize: 25,
                    iconEnabledColor: ColorSelect.color1,
                    icon: Container(
                        margin: const EdgeInsets.only(right: 30),
                        child: const Icon(Icons.arrow_drop_down)),
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['1 años', '2 años', '3 años', '4 años']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: Text(value)),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 92,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 1, top: 10, bottom: 5),
                width: size.width,
                child: Text(
                  nameTopField2,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ColorSelect.color1,
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                child: Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                  activeTrackColor: ColorSelect.color5,
                  activeColor: ColorSelect.color1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
