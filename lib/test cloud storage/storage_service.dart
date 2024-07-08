
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as core;
class Storage {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> uploadFile(
    String filePath,
        String fileName) async {

    File file = File(filePath);

    try{
      Reference ref = await _storage.ref().child('test2').child(fileName);
      UploadTask task = ref.putFile(file);
      TaskSnapshot snap = await task;
      String url = await snap.ref.getDownloadURL();
      print(url);

    }on core.FirebaseException catch(e){
      print('Errorrrrrrrrrrrrrrrrrrrrrr ---.> $e');
    }
  }
}
