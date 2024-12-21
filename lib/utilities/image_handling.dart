import 'dart:io';

import 'package:file_picker/file_picker.dart';

class ImageHandling {


  static Future<List<File>?> pickImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
      compressionQuality: 50,
    );
    if (result != null) {
      List<File>? pickedImages = result.paths.map((images) => File(images!)).toList();
      return pickedImages;
    }
    return null;
  }
}
