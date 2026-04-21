import 'dart:typed_data';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StorageMethods {
  static const String cloudName = "iakoa-app";
  static const String uploadPreset = "holbegram_profile";

  final String cloudinaryUrl =
      "https://api.cloudinary.com/v1_1/$cloudName/image/upload";

  Future<String?> uploadImageToStorage(
    Uint8List file,
    String folder,
  ) async {
    try {
      String uniqueId = const Uuid().v1();
      var uri = Uri.parse(cloudinaryUrl);
      var request = http.MultipartRequest('POST', uri);

      request.fields['upload_preset'] = uploadPreset;
      request.fields['folder'] = folder;
      request.fields['public_id'] = uniqueId;

      var multipartFile = http.MultipartFile.fromBytes(
        'file',
        file,
        filename: '$uniqueId.jpg',
      );
      request.files.add(multipartFile);

      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseBody = String.fromCharCodes(responseData);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(responseBody);
        return jsonResponse['secure_url'];
      } else {
        print('Cloudinary error: ${response.statusCode} - $responseBody');
        return null;
      }
    } catch (e) {
      print('Upload exception: $e');
      return null;
    }
  }
}
