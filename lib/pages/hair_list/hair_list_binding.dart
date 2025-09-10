import 'package:get/get.dart';

import 'hair_list_logic.dart';

class HairListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HairListLogic());
  }
}