
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

Future<File> downloadImageToFile(String imageUrl, String fileName) async {
  final dir = await getApplicationDocumentsDirectory();
  final filePath = '${dir.path}/$fileName';

  final file = File(filePath);

  if (await file.exists()) {
    return file;
  }

  final response = await http.get(Uri.parse(imageUrl));

  if (response.statusCode == 200) {
    await file.writeAsBytes(response.bodyBytes);
    return file;
  } else {
    throw Exception('Failed to download image');
  }
}
