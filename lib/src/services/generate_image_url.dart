import 'dart:convert';
import 'package:http/http.dart' as http;

class GenerateImageUrl {
  late bool success;
  late String message;

  late bool isGenerated;
  late String uploadUrl;
  late String downloadUrl;
  String ip = '192.168.0.3';
  Future<void> call(String fileType) async {
    // try {
    Map body = {"fileType": fileType};

    var response = await http.post(
      Uri.http(ip + ':5000', '/generatePresignedUrl'),
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
    // } catch (e) {
    //   throw ('Error getting url');
    // }
  }
}
