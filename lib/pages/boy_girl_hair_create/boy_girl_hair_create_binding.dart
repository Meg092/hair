import 'package:get/get.dart';

import 'boy_girl_hair_create_logic.dart';

class BoyGirlHairCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BoyGirlHairCreateLogic());
  }
}