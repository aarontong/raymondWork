import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safe_device/safe_device.dart';

import 'package:path_provider/path_provider.dart';

class nameCardImageField extends StatefulWidget {
  static late File _image;

  static File profileFilePath() {
    return _image;
  }

  @override
  State<nameCardImageField> createState() => nameCardImageState();
}

class nameCardImageState extends State<nameCardImageField> {
  bool imageExist = false;
  final ImagePicker _picker = ImagePicker();
  Future getImageFromCamera() async {
    final XFile? photo =
        await _picker.pickImage(source: ImageSource.camera) as XFile?;
    bool isAnEmulator = await SafeDevice.isRealDevice;
    if (isAnEmulator && Platform.isIOS) {
      setState(() async {
        nameCardImageField._image =
            await imageToFile(imageName: "camera-icon", ext: "jpeg");
        imageExist = nameCardImageField._image.existsSync();
      });
    } else {
      setState(() {
        nameCardImageField._image = File(photo!.path);
        imageExist = nameCardImageField._image.existsSync();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return imageExist
        ? Image.file(
            File(nameCardImageField._image.path),
            height: 300,
          )
        : GestureDetector(
            onTap: getImageFromCamera, // Image tapped
            child: Image.asset('assets/images/camera-icon.jpeg',
                width: 150, height: 150));
  }

  static Future<File> imageToFile(
      {required String imageName, required String ext}) async {
    var bytes = await rootBundle.load('assets/images/$imageName.$ext');
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/profile.png');
    await file.writeAsBytes(
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    return file;
  }
}
