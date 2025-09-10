import 'package:get/get.dart';

import 'ai_hair_logic.dart';

class Ai_hairBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Ai_hairLogic());
  }
}