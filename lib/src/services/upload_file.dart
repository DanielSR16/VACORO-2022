import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class UploadFile {
  late bool success = false;
  late String message = 'a';
  late bool isUploaded = false;
  Future<void> call(String url, File image) async {
    try {
      var urlUri = Uri.parse(url);
      var response = await http.put(urlUri, body: image.readAsBytesSync());
      print(response.body);
      if (response.statusCode == 200) {
        isUploaded = true;
      }
    } catch (e) {
      print('error xd');
      print(e);
      throw ('Error uploading photo');
    }
  }
}
