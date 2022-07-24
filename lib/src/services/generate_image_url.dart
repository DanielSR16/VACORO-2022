import 'dart:convert';
import 'package:http/http.dart' as http;

class GenerateImageUrl {
  late bool success;
  late String message;

  late bool isGenerated;
  late String uploadUrl;
  late String downloadUrl;
  String ip = '192.168.0.2';
  Future<void> call(String fileType) async {
    // try {
    Map body = {"fileType": fileType};

    var response = await http.post(
      Uri.http('upload-image-1854400322.us-east-1.elb.amazonaws.com',
          '/generatePresignedUrl'),
      body: body,
    );

    var result = jsonDecode(response.body);

    if (result['success'] != null) {
      success = result['success'];
      message = result['message'];

      if (response.statusCode == 201) {
        isGenerated = true;
        uploadUrl = result["uploadUrl"];
        downloadUrl = result["downloadUrl"];
      }
    }
  }
}
