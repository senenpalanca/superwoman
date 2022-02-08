import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:superwoman/utils/file.utils.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<Reference> uploadFile(File f) async {
    return uploadBytes(f.readAsBytesSync(), FileUtils.getNameFile(f));
  }

  Future<Reference> uploadFileWithName(File f, String nameFile) async {
    return uploadBytes(f.readAsBytesSync(), nameFile);
  }

  Future<Reference> uploadBytes(f, String name,
      {String mimeType = "image/png"}) async {
    final Reference ref = _storage.ref().child(name);
    try {
      // Create your custom metadata.
      SettableMetadata metadata = SettableMetadata(contentType: mimeType);

      final UploadTask uploadTask = ref.putData(f, metadata);

      //Get task progress
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

  Future<String> downloadImage(String firePath, String localPath) async {
    if (firePath == null || firePath.isEmpty) {
      return "";
    }

    final Reference ref = _storage.ref().child(firePath);
    Uint8List? bytes = await ref.getData();
    print("downloadImage");
    File f = new File(localPath);
    f.create();
    if (bytes != null) {
      f.writeAsBytesSync(bytes);
    }

    return "";
  }

  Future<Uint8List> getBytesImageFromUrl(String url) async {
    var response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }

  Future<Reference> uploadImage(File f) {
    return uploadFile(f);
  }

  Future<Reference> uploadImageWithName(File f, String nameFile) {
    return uploadFileWithName(f, nameFile);
  }

  Future<Reference> uploadImagePath(String f) {
    return uploadFile(new File(f));
  }
}
