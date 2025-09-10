import 'hair_preview_logic.dart';
import 'package:get/get.dart';


class HairPreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      HairPreviewLogic(),
      permanent: true,
    );
  }
}
