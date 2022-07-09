import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
class nameCardImageField extends StatefulWidget{
  static late File _image;

  static File profileFilePath(){
    return _image;
  }
  @override
  State<nameCardImageField> createState() => nameCardImageState();

   

}

class nameCardImageState extends State<nameCardImageField>{

bool imageExist = false;
final ImagePicker _picker = ImagePicker();
  Future getImageFromCamera() async{
  final XFile? photo =  await _picker.pickImage(source: ImageSource.camera) as XFile?;

    setState(() {

      nameCardImageField._image = File(photo!.path);
      imageExist = nameCardImageField._image.existsSync();
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return imageExist? Image.file(File(nameCardImageField._image.path), height: 300,):GestureDetector(
  onTap: getImageFromCamera, // Image tapped
  child: Image.asset('assets/images/camera-icon.jpeg',width: 150, height: 150)
);
  }

}