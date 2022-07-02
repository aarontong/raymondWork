import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
class nameCardImageField extends StatefulWidget{
  @override
  State<nameCardImageField> createState() => nameCardImageState();

}

class nameCardImageState extends State<nameCardImageField>{
late File _image;
bool imageExist = false;
final ImagePicker _picker = ImagePicker();
  Future getImageFromCamera() async{
  final XFile? photo =  await _picker.pickImage(source: ImageSource.camera) as XFile?;

    setState(() {

      _image = File(photo!.path);
      imageExist = _image.existsSync();
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return imageExist? Image.file(File(_image.path), height: 300,):GestureDetector(
  onTap: getImageFromCamera, // Image tapped
  child: Image.asset('assets/images/camera-icon.jpeg',width: 150, height: 150)
);
  }

}