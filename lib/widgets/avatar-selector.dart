import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:superwoman/services/service-locator.dart';
import 'package:superwoman/services/storage.service.dart';

class AvatarSelector extends StatefulWidget {


  String image;
  AvatarSelector(this.image, {Key? key}) : super(key: key);

  @override
  _AvatarSelectorState createState() => _AvatarSelectorState();
}

class _AvatarSelectorState extends State<AvatarSelector> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showBottomSheet(),
      child: CircleAvatar(
        radius: 40.0,
        backgroundColor: Colors.grey,
        backgroundImage: NetworkImage(widget.image),
      ),
    );
  }

  _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Seleccionar de Galería'),
                      onTap: () {

                        Navigator.of(context).pop();
                      }),

                  /*new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Cámara'),
                    onTap: () {
                      _imgFromCamera(user);
                      Navigator.of(context).pop();
                    },
                  ),*/
                ],
              ),
            ),
          );
        });
  }
  _uploadImgFromGallery() async {
    await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50)
        .then((image) {
          if(image!=null){
           _uploadImgToFirebase(image);
          }


    });
  }

  _uploadImgToFirebase(XFile image) async {
    Reference f = await locator<StorageService>().uploadFile(File(image.path));
    var mediaUrl = await f.getDownloadURL();
    setState(() {
      widget.image = mediaUrl;
    });
  }
}
