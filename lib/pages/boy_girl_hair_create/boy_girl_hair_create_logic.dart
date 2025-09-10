import 'dart:typed_data';

import 'package:ai_hair/db_hair/db_hair.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../db_hair/hair_entity.dart';

class BoyGirlHairCreateLogic extends GetxController {

  DBHair dbHair = Get.find();

  int gender = Get.arguments;

  var selectedIndex = 0;

  Uint8List? image;

  void imageSelected() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(imageQuality: 90,maxWidth: 1024,source: ImageSource.gallery);
      if (pickedFile != null) {
        final imageBytes = await pickedFile.readAsBytes();
        image = imageBytes;
        update();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Please check album permissions or select a new image');
      return;
    }
  }

  saveData(Uint8List mergeImage) async {
    await dbHair.insertHair(HairEntity(
      id: 0,
      createdTime: DateTime.now(),
      image: mergeImage,
    ));
    Fluttertoast.showToast(msg: 'Saved success');
    Get.back();
  }

}
