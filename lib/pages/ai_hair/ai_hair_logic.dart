import 'dart:math';
import 'dart:typed_data';

import 'package:ai_hair/db_hair/db_hair.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../db_hair/hair_entity.dart';

class Ai_hairLogic extends GetxController {
  Uint8List? image;

  DBHair dbHair = Get.find();

  int progress = 0;

  var gender = 0;
  var hairNumList = [];

  var selectedIndex = 0;
  var mainStatus = 0;
  var subStatus = 0;

  List<int> generateUniqueNumbers() {
    final random = Random();
    final Set<int> numbers = {};

    while (numbers.length < 4) {
      numbers.add(random.nextInt(10));
    }

    return numbers.toList();
  }

  void incrementSubStatus() async {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 500));
      if (subStatus < 2) {
        subStatus++;
        statusNumList[mainStatus][0] = subStatus;
      }
      if (subStatus == 2 && mainStatus < 4) {
        mainStatus++;
        subStatus = 0;
        statusNumList[mainStatus][0] = subStatus;
      }
      update();
      if (mainStatus == 4 && subStatus == 2) {
        progress = 3;
        final random = Random();
        gender = random.nextInt(2);
        hairNumList = generateUniqueNumbers();
        update();
        break;
      }

    }
  }

  var statusNumList = [[0],[0],[0],[0],[0]];

  var statusList = [
    ['Waiting for face analysis', 'Analyzing face', 'Face analysis completed'],
    ['Waiting for ear analysis', 'Analyzing ears', 'Ear analysis completed'],
    ['Waiting for nose analysis', 'Analyzing nose', 'Nose analysis completed'],
    ['Waiting for eye analysis', 'Analyzing eyes', 'Eye analysis completed'],
    ['Waiting for hair analysis', 'Analyzing hair', 'Hair analysis completed']
  ];

  void imageSelected() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(
          imageQuality: 90, maxWidth: 1024, source: ImageSource.gallery);
      if (pickedFile != null) {
        final imageBytes = await pickedFile.readAsBytes();
        image = imageBytes;
        progress = 1;
        update();
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Please check album permissions or select a new image');
      return;
    }
  }

  saveData(Uint8List mergedImage) async {

    await dbHair.insertHair(HairEntity(
      id: 0,
      createdTime: DateTime.now(),
      image: mergedImage,
    ));
    Fluttertoast.showToast(msg: 'Saved success');
    Get.back();
  }
}
