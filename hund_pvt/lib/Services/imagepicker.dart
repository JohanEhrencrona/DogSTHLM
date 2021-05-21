import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';


class PicPicker {
  final String uid;

  File _image; // Used only if you need a single picture
  FirebaseStorage storage = FirebaseStorage.instance;

  PicPicker({this.uid});

  Future getImage({ImageSource source}) async {
    ImagePicker picker = ImagePicker();
    PickedFile pickedFile;
    // Let user select photo from gallery
    pickedFile = await picker.getImage(source: ImageSource.gallery,);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      var storageRef = storage.ref('/profilePicture/' + uid);
      storageRef.putFile(_image);
      return _image;
    } else {
      return ('No image selected.');
    }
  }
}