import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:vacoro_proyect/src/services/editarBecerro.dart';
import 'package:vacoro_proyect/src/services/generate_image_url.dart';
import 'package:vacoro_proyect/src/services/obtenerVacaToro.dart';
import 'package:vacoro_proyect/src/services/upload_file.dart';
import 'package:vacoro_proyect/src/style/colors/colorview.dart';
import 'package:vacoro_proyect/src/utils/user_secure_storage.dart';

import '../services/deleteCategoriabyAnimal.dart';
import '../services/deleteHistorialAnimal.dart';

class EditarBecerro extends StatefulWidget {
  int id;
  String token;
  EditarBecerro({Key? key, required this.id, required this.token})
      : super(key: key);

  @override
  State<EditarBecerro> createState() => _EditarBecerroState();
}

class _EditarBecerroState extends State<EditarBecerro> {
  File? image;
  late bool isSwitched = false;
  int estado = 0;
  late String url_img = imageAnimal;
  TextEditingController nombreBecerroEditar = TextEditingController();
  TextEditingController descripcionBecerroEditar = TextEditingController();
  TextEditingController razaBecerroEditar = TextEditingController();
  TextEditingController numeroAreteBecerroEditar = TextEditingController();
  TextEditingController edadBecerro = TextEditingController();
  TextEditingController dateinput = TextEditingController();

  late bool _validateNombre = false;
  late bool _validateDescripcion = false;
  late bool _validateRaza = false;
  late bool _validateNumeroArete = false;
  late bool _validateEdad = false;
  late bool _validateDate = false;

  String? dropdownValue;
  late Map<int, String> listaVacas = {0: 'vaca'};
  String nameMadre = "";
  late int id;
  late int id_usuario;
  late String token = '';
  late var imageAnimal =
      'https://image-vacoro.s3.amazonaws.com/37b04641-514f-491a-b96e-6a115372a994.jpg';

  @override
  void initState() {
    super.initState();
    UserSecureStorage.getId().then((id_) {
      UserSecureStorage.getToken().then((token_) {
        int id_cast = int.parse(id_!);
        getVacasbyIdUser(id_cast, widget.token).then((value) {
          setState(() {
            id_usuario = id_cast;
            token = token_!;

            // Future.delayed(const Duration(milliseconds: 200), () {

            listaVacas = value[0][0];
            List map = value[1];

            // });
          });
        });
      });
    });

    becerro_id(widget.id, widget.token).then((value) {
      nombreBecerroEditar.text = value.nombre;
      descripcionBecerroEditar.text = value.descripcion;
      razaBecerroEditar.text = value.raza;
      numeroAreteBecerroEditar.text = value.num_arete;
      dateinput.text = value.fecha_llegada;
      edadBecerro.text = value.edad.toString();
      id = value.id;
      id_usuario = value.id_usuario;

      setState(() {
        imageAnimal = value.url_img.toString();
        if (value.estado == 1) {
          isSwitched = true;
        }

        if (value.id_vaca != -1) {
          vacatoro_id(value.id_vaca, "Vaca", widget.token).then((value) {
            setState(() {
              print(value);
              nameMadre = value.nombre + " " + value.num_arete;
              print(listaVacas);
            });
          });
        } else {
          if (value.id_vaca == -1) {
            Future.delayed(const Duration(milliseconds: 700), () {
              setState(() {
                nameMadre = listaVacas[-1].toString();
                // dropdownValue = listaVacas[-1];
              });
            });
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Center(
          child: Text(
            'EDITAR BECERRO',
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
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                inputs("Nombre", "Ingrese nombre del becerro", size,
                    nombreBecerroEditar, _validateNombre),
                inputs("Descripción", "Ingrese una descripción del becerro",
                    size, descripcionBecerroEditar, _validateDescripcion),
                inputs("Raza", "Ingrese la raza del animal", size,
                    razaBecerroEditar, _validateRaza),
                inputs("Número de arete", "Ingrese el número de arete", size,
                    numeroAreteBecerroEditar, _validateNumeroArete),
                fecha(context, 'Fecha de llegada', dateinput, _validateDate),
                // selectMadre("Vaca madre" + nameMadre, size),
                edadEstado("Edad (Meses)", "Ingrese los meses que tiene",
                    "Buen estado", size, edadBecerro, _validateEdad),
                selectImage(size),
                Container(
                  width: 220,
                  margin: const EdgeInsets.only(left: 88),
                  padding: const EdgeInsets.only(left: 20, bottom: 20, top: 25),
                  child: Material(
                    color: Colors.transparent, // button color
                    child: InkWell(
                      splashColor: Colors.green, // splash color
                      onTap: () {
                        servicedeletebecerro_categoria(widget.id)
                            .then((categoria) {
                          if (categoria['status'] == 'ok') {
                            servicedeletebecerro_historial(widget.id, token)
                                .then((historial) {
                              if (historial['status'] == 'ok') {
                                servicedeletebecerro(token, id).then((value) {
                                  if (value['status'] == 'ok') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        duration: Duration(milliseconds: 1000),
                                        content: Text(
                                            'Animal eliminado correctamente'),
                                      ),
                                    );
                                    Future.delayed(
                                        const Duration(milliseconds: 200), () {
                                      Navigator.popAndPushNamed(
                                        context,
                                        'dash_calf',
                                      );

                                      setState(() {
                                        // Here you can write your code for open new view
                                      });
                                    });
                                  }
                                });
                              }
                            });
                          }
                        });
                      }, // button pressed
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 10, top: 10),
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Text("Eliminar Animal",
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
                              serviceeditarbecerro(
                                      token,
                                      id_usuario,
                                      id,
                                      nombreBecerroEditar.text,
                                      descripcionBecerroEditar.text,
                                      razaBecerroEditar.text,
                                      numeroAreteBecerroEditar.text,
                                      url_img,
                                      estado,
                                      int.parse(edadBecerro.text),
                                      obtenerIdVacaSelect(),
                                      dateinput.text)
                                  .then((value) {
                                if (value['status'] == 'ok') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      duration: Duration(milliseconds: 1000),
                                      content:
                                          Text('Actualizado correctamente'),
                                    ),
                                  );
                                  Future.delayed(
                                      const Duration(milliseconds: 200), () {
                                    Navigator.popAndPushNamed(
                                      context,
                                      'dash_calf',
                                    );

                                    setState(() {
                                      // Here you can write your code for open new view
                                    });
                                  });
                                  //Navigator.pop(context);
                                }
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

  Widget selectImage(Size size) {
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
              width: MediaQuery.of(context).size.width * 0.40,
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
        Container(
          width: MediaQuery.of(context).size.width * 0.40,
          padding: const EdgeInsets.only(
            //left: 1,
            right: 1,
          ),
          child: SizedBox(
            width: size.width - 255,
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
                buildButton(
                  title: 'Cancelar selección',
                  icon: Icons.image_outlined,
                  onClicked: () {
                    setState(() {
                      print(imageAnimal);
                      image = null;
                      imageAnimal =
                          'https://image-vacoro.s3.amazonaws.com/37b04641-514f-491a-b96e-6a115372a994.jpg';
                      print(imageAnimal);
                    });
                  },
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
    TextEditingController edadToroVaca,
    bool validate_,
  ) {
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
                  controller: edadToroVaca,
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

  int obtenerIdVacaSelect() {
    var id = listaVacas.keys.firstWhere(
        (element) => listaVacas[element] == dropdownValue,
        orElse: () => -1);
    return id;
  }

  Widget selectMadre(String nameTopField, Size size) {
    return Container(
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
                    enabledBorder: InputBorder.none, fillColor: Colors.white),
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
                items: listaVacas.values
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
    if (nombreBecerroEditar.text.isEmpty) {
      _validateNombre = true;
      lleno = false;
    } else {
      _validateNombre = false;
    }

    if (descripcionBecerroEditar.text.isEmpty) {
      _validateDescripcion = true;
      lleno = false;
    } else {
      _validateDescripcion = false;
    }

    if (razaBecerroEditar.text.isEmpty) {
      _validateRaza = true;
      lleno = false;
    } else {
      _validateRaza = false;
    }

    if (numeroAreteBecerroEditar.text.isEmpty) {
      _validateNumeroArete = true;
      lleno = false;
    } else {
      _validateNumeroArete = false;
    }

    if (edadBecerro.text.isEmpty) {
      _validateEdad = true;
      lleno = false;
    } else {
      _validateEdad = false;
    }

    if (dateinput.text.isEmpty) {
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

      var croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        compressQuality: 100,
        maxHeight: 200,
        maxWidth: 200,
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Edicion de imagen',
              toolbarColor: Colors.green,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
        ],
      );
      if (croppedFile != null) {
        final imageTemporary = File(croppedFile.path);

        String fileExtension = path.extension(croppedFile.path);

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

        setState(
          () => this.image = imageTemporary,
        );
      }
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

      var croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        compressQuality: 100,
        maxHeight: 200,
        maxWidth: 200,
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Edicion de imagen',
              toolbarColor: Colors.green,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
        ],
      );

      if (croppedFile != null) {
        final imageTemporary = File(croppedFile.path);
        setState(() => this.image = imageTemporary);
        String fileExtension = path.extension(croppedFile.path);
        //final imageTemporary = File(image.path);

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
      }
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
