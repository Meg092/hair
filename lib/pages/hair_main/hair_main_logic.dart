import 'package:ai_hair/db_hair/db_hair.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HairMainLogic extends GetxController {

  DBHair dbHair = Get.find();

  var appVersion = '1.0.0'.obs;

  cleanHairData() async {
    Get.dialog(AlertDialog(
      title: const Text('Warm reminder'),
      content: const Text('Do you want to clean all records?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel',style: TextStyle(color: Colors.black),),
        ),
        TextButton(
          onPressed: () async {
            await dbHair.cleanAllData();
            Get.back();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ));
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    final info = await PackageInfo.fromPlatform();
    appVersion.value = info.version;
    super.onInit();
  }

}
