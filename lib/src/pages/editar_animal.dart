import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:vacoro_proyect/src/services/deleteAnimalVacaToro.dart';
import 'package:vacoro_proyect/src/services/editarAnimalVacaToro.dart';
import 'package:vacoro_proyect/src/services/generate_image_url.dart';
import 'package:vacoro_proyect/src/services/obtenerVacaToro.dart';
import 'package:vacoro_proyect/src/services/upload_file.dart';
import 'package:vacoro_proyect/src/style/colors/colorview.dart';

class EditarAnimal extends StatefulWidget {
  String tipoAnimal;
  int id;
  EditarAnimal({Key? key, required this.tipoAnimal, required this.id})
      : super(key: key);

  @override
  State<EditarAnimal> createState() => _EditarAnimalState();
}

class _EditarAnimalState extends State<EditarAnimal> {
  File? image;
  late bool isSwitched = false;
  int estado = 0;
  late String url_img = imageAnimal;
  TextEditingController nombreVacaToroEditar = TextEditingController();
  TextEditingController descripcionVacaToroEditar = TextEditingController();
  TextEditingController razaVacaToroEditar = TextEditingController();
  TextEditingController numeroAreteVacaToroEditar = TextEditingController();
  TextEditingController edadToroVacaEditar = TextEditingController();
  TextEditingController dateinputEditar = TextEditingController();

  late bool _validateNombre = false;
  late bool _validateDescripcion = false;
  late bool _validateRaza = false;
  late bool _validateNumeroArete = false;
  late bool _validateEdad = false;
  late bool _validateDate = false;

  late int id;
  late int id_usuario;
  late var imageAnimal =
      'https://image-vacoro.s3.amazonaws.com/8f74ad4a-ae4d-4473-aff1-f19e0199e68b.jpg';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vacatoro_id(widget.id, widget.tipoAnimal).then((value) {
      nombreVacaToroEditar.text = value.nombre;
      descripcionVacaToroEditar.text = value.descripcion;
      razaVacaToroEditar.text = value.raza;
      numeroAreteVacaToroEditar.text = value.num_arete;
      dateinputEditar.text = value.fecha_llegada;
      edadToroVacaEditar.text = value.edad.toString();
      id = value.id;
      id_usuario = value.id_usuario;

      setState(() {
        imageAnimal = value.url_img.toString();
        if (value.estado == 1) {
          isSwitched = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double bordes = 20.0;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text(
            'EDITAR ANIMAL (' + widget.tipoAnimal + ')',
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
                  inputs("Nombre", "Ingrese el nombre", size,
                      nombreVacaToroEditar, _validateNombre),
                  inputs("Descripción", "Ingrese una descripción", size,
                      descripcionVacaToroEditar, _validateDescripcion),
                  inputs("Raza", "Ingrese la raza", size, razaVacaToroEditar,
                      _validateRaza),
                  inputs("Número de arete", "Ingrese el número de arete", size,
                      numeroAreteVacaToroEditar, _validateNumeroArete),
                  fecha(context, "Fecha de llegada", dateinputEditar,
                      _validateDate),
                  edadEstado("Edad (Meses)", "Ingrese los meses que tiene",
                      "Buen estado", size, edadToroVacaEditar, _validateEdad),
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
                        onTap: () {
                          servicedeletevacatoro(widget.tipoAnimal, id)
                              .then((value) {
                            if (value['status'] == 'ok') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  duration: Duration(milliseconds: 1000),
                                  content:
                                      Text('Animal eliminado correctamente'),
                                ),
                              );
                            }
                          });
                        }, // button pressed
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
                          onPressed: () {
                            setState(() {
                              late bool res = valid();
                              if (res == true) {
                                serviceeditarvacatoro(
                                        widget.tipoAnimal,
                                        id,
                                        id_usuario,
                                        nombreVacaToroEditar.text,
                                        descripcionVacaToroEditar.text,
                                        razaVacaToroEditar.text,
                                        numeroAreteVacaToroEditar.text,
                                        url_img,
                                        estado,
                                        int.parse(edadToroVacaEditar.text),
                                        dateinputEditar.text)
                                    .then((value) {
                                  if (value['status'] == 'ok') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        duration: Duration(milliseconds: 1000),
                                        content:
                                            Text('Actualizado correctamente'),
                                      ),
                                    );
                                  }
                                  print(value);
                                });
                              }
                            });
                          },
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

  Widget inputs(
    String nameTopField,
    String nameInField,
    Size size,
    TextEditingController controllerInput,
    bool validate_,
  ) {
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
            height: validate_ ? 60 : 40,
            child: TextField(
              controller: controllerInput,
              decoration: InputDecoration(
                labelStyle: const TextStyle(color: ColorSelect.color5),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorSelect.color1, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
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
                errorText: validate_ ? 'El campo esta vacio' : null,
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
                  : Image(
                      width: 160,
                      height: 150,
                      image: NetworkImage(imageAnimal),
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

  Widget edadEstado(
      String nameTopField,
      String nameInField,
      String nameTopField2,
      Size size,
      TextEditingController edadToroVacaEditar,
      bool validate_) {
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
                height: validate_ ? 60 : 45,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: edadToroVacaEditar,
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(color: ColorSelect.color5),
                    border: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorSelect.color1, width: 2.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorSelect.color1, width: 2.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorSelect.color5, width: 2.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    labelText: nameInField,
                    errorText: validate_ ? 'El campo esta vacio' : null,
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
                      if (isSwitched == false) {
                        estado = 0;
                      } else {
                        estado = 1;
                      }
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

  Widget fecha(
    BuildContext context,
    String nameTopField,
    TextEditingController dateinput,
    bool validate_,
  ) {
    Size size = MediaQuery.of(context).size;
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
            height: validate_ ? 60 : 40,
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.calendar_today,
                  color: ColorSelect.color1,
                ),
                iconColor: ColorSelect.color1,
                labelText: "Seleccionar la fecha de llegada",
                labelStyle: const TextStyle(color: ColorSelect.color5),
                errorText: validate_ ? 'El campo esta vacio' : null,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorSelect.color1, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
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
              ),
              controller: dateinput,

              readOnly:
                  true, //Para que el usuario no pueda editar en el textField
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(
                      2001, //Fecha limite para seleccionar
                    ),
                    lastDate: DateTime(2101),
                    //Fecha limite para seleccionar
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: ColorSelect.color5,
                            onPrimary: Colors.white,
                            onSecondary: ColorSelect.color1,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              primary: ColorSelect.color1, // button text color
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    });
                if (pickedDate != null) {
                  String formattedDate = DateFormat('yyyy-MM-dd')
                      .format(pickedDate); //La fecha se mostrar en este formato
                  setState(
                    () {
                      dateinput.text =
                          formattedDate; //Fecha de salida en el textField
                    },
                  );

                  print(dateinput.text);
                } else {
                  validate_ = true;
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  bool valid() {
    bool lleno = true;
    if (nombreVacaToroEditar.text.isEmpty) {
      _validateNombre = true;
      lleno = false;
    } else {
      _validateNombre = false;
    }

    if (descripcionVacaToroEditar.text.isEmpty) {
      _validateDescripcion = true;
      lleno = false;
    } else {
      _validateDescripcion = false;
    }

    if (razaVacaToroEditar.text.isEmpty) {
      _validateRaza = true;
      lleno = false;
    } else {
      _validateRaza = false;
    }

    if (numeroAreteVacaToroEditar.text.isEmpty) {
      _validateNumeroArete = true;
      lleno = false;
    } else {
      _validateNumeroArete = false;
    }

    if (edadToroVacaEditar.text.isEmpty) {
      _validateEdad = true;
      lleno = false;
    } else {
      _validateEdad = false;
    }

    if (dateinputEditar.text.isEmpty) {
      _validateDate = true;
      lleno = false;
    } else {
      _validateDate = false;
    }
    return lleno;
  }

  Future pickCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemporary = File(image.path);

      String fileExtension = path.extension(image.path);

      GenerateImageUrl generateImageUrl = GenerateImageUrl();
      await generateImageUrl.call(fileExtension);

      url_img = generateImageUrl.downloadUrl;
      var uploadUrl;
      if (generateImageUrl.isGenerated != null &&
          generateImageUrl.isGenerated) {
        uploadUrl = generateImageUrl.uploadUrl;
      } else {
        throw generateImageUrl.message;
      }

      bool isUploaded = await uploadFile(context, uploadUrl, imageTemporary);
      print(isUploaded);

      setState(
        () => this.image = imageTemporary,
      );

      // String fileExtension = path.extension(image.path);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = path.basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      //final imageTemporary = File(image.path);
      final imageTemporary = await saveImagePermanently(image.path);
      setState(() => this.image = imageTemporary);

      String fileExtension = path.extension(image.path);

      GenerateImageUrl generateImageUrl = GenerateImageUrl();
      await generateImageUrl.call(fileExtension);

      url_img = generateImageUrl.downloadUrl;
      var uploadUrl;
      if (generateImageUrl.isGenerated != null &&
          generateImageUrl.isGenerated) {
        uploadUrl = generateImageUrl.uploadUrl;
      } else {
        throw generateImageUrl.message;
      }

      bool isUploaded = await uploadFile(context, uploadUrl, imageTemporary);
      print(isUploaded);
      print("url");
      print(url_img);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<bool> uploadFile(context, String url, File image) async {
    try {
      UploadFile uploadFile = UploadFile();
      await uploadFile.call(url, image);

      if (uploadFile.isUploaded != null && uploadFile.isUploaded) {
        return true;
      } else {
        throw uploadFile.message;
      }
    } catch (e) {
      throw e;
    }
  }
}
