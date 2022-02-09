import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:superwoman/utils/file.utils.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<Reference> uploadFile(File f) async {
    return uploadBytes(f.readAsBytesSync(), FileUtils.getNameFile(f));
  }

  Future<Reference> uploadBytes(f, String name,
      {String mimeType = "image/png"}) async {
    final Reference ref = _storage.ref().child(name);
    try {

      SettableMetadata metadata = SettableMetadata(contentType: mimeType);

      final UploadTask uploadTask = ref.putData(f, metadata);


      uploadTask.snapshotEvents.listen(
        (snapshot) {
          final progress = (snapshot.bytesTransferred / snapshot.totalBytes);
          print('Task state: ${snapshot.state}');
          print('Progress: ${(progress * 100).toString()}%');
        },
        onError: (e) {
          print("--UPLOADBYTES -ONERROR $uploadTask.snapshot");
        },
      );

      final refFile = (await uploadTask.whenComplete(() => {})).ref;

      return refFile;
    } catch (err) {
      print(err);
      return ref;
    }
  }
}
