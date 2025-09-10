import 'package:get/get.dart';

import '../../db_hair/db_hair.dart';
import '../../db_hair/hair_entity.dart';

class HairListLogic extends GetxController {

  DBHair dbHair = Get.find();

  var list = <HairEntity>[].obs;

  var isEdit = false;

  var selectedList = <HairEntity>[];

  getData() async {
    list.value = await dbHair.getHairAllData();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }

}
