import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:vacoro_proyect/src/pages/registro_user.dart';
import 'package:vacoro_proyect/src/services/generate_image_url.dart';
import 'package:vacoro_proyect/src/services/servicios_user.dart';
import 'package:vacoro_proyect/src/services/upload_file.dart';

class registroUser2 extends StatefulWidget {
  const registroUser2({super.key});

  @override
  State<registroUser2> createState() => _registroUser2State();
}

class _registroUser2State extends State<registroUser2> {
  File? image;
  bool isSwitched = false;
  @override
  var size, height_media, width_media;
  late double bordes = 30;
  Widget build(BuildContext context) {
    var con;
    var args = ModalRoute.of(context)!.settings.arguments;
    Usuario? usuario = args as Usuario?;

    size = MediaQuery.of(context).size;
    height_media = size.height;
    width_media = size.width;
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF68C34E),
          actions: [
            Container(
              width: 50,
              child: Image.asset(
                'assets/images/vacoro-blanco.png',
              ),
            ),
          ],
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(left: bordes),
              child: const Text(
                'Tomate una fotografia o agregala a tu \nperfil',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color(0xFF3E752F),
                  fontSize: 45,
                  fontFamily: 'Cardo',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            selectImage(usuario)
          ],
        ),
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
          primary: Color(0xFF3E752F),
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

  Widget selectImage(var usuario) {
    return Column(
      children: <Widget>[
        Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
              child: const Text(
                'Ingresar fotografia',
                style: TextStyle(
                  color: Color(0xFF3E752F),
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
        ),
        Container(
          height: 70,
          width: width_media - 150,
          padding: const EdgeInsets.only(bottom: 10),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xFF68C24E)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
            ),
            onPressed: () {
              var nombre = usuario!.nombre.text;
              var apellidos = usuario!.apellidos.text;
              var correoElectronico = usuario!.correoElectronico.text;
              var contrasenia = usuario!.contrasenia.text;
              var estado = usuario!.estado;
              var ciudad = usuario!.ciudad;
              var edad = usuario!.edad.text;
              late int edad_int = int.parse(edad);
              var nombreRancho = usuario!.nombreRancho.text;

              register_user(nombre, apellidos, correoElectronico, contrasenia,
                      estado, ciudad, edad_int, nombreRancho, "url")
                  .then((value) {
                print(value);
              });

              // Navigator.pushNamed(context, 'registroUser2',
              //         arguments: usuario);
            },
            child: const Text(
              'Siguiente',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }

  Future pickCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;
      late String uploadURL;
      final imageTemporary = File(image.path);

      String fileExtension = path.extension(image.path);

      GenerateImageUrl generateImageUrl = GenerateImageUrl();
      await generateImageUrl.call(fileExtension);

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
