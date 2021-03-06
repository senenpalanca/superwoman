import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:superwoman/pallete.dart';
import 'package:superwoman/service-locator.dart';
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
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50.0,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(widget.image),
          ),
          const Positioned(
              right: 0,
              bottom: 0,
              child: CircleButton(
                iconData: Icons.find_replace,
              ))
        ],
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
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Select from Gallery'),
                      onTap: () {
                        _uploadImgFromGallery();
                        Navigator.of(context).pop();
                      }),
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
      if (image != null) {
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

class CircleButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final IconData? iconData;

  const CircleButton({Key? key, this.onTap, this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 30.0;

    return new InkResponse(
      onTap: onTap,
      child: new Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: new Icon(
          iconData,
          color: Colors.white,
        ),
      ),
    );
  }
}
