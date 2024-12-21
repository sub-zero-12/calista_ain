import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService{
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Future<List<String>> uploadImages(List<File> images, String id) async {
    try{
      List<String> url = [];
      Reference reference = _storage.ref("Products").child(id);
      for(File image in images){
        String imageName = image.path.split("/").last;
        Reference temp = reference.child(imageName);
        await temp.putFile(image);
        url.add(await temp.getDownloadURL());
      }
      return url;
    } catch(e){
      return [];
    }
  }

}