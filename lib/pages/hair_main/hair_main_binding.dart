import 'package:get/get.dart';

import 'hair_main_logic.dart';

class HairMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HairMainLogic());
  }
}