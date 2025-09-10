import 'package:ai_hair/db_hair/db_hair.dart';
import 'package:ai_hair/pages/boy_girl_hair_create/boy_girl_hair_create_binding.dart';
import 'package:ai_hair/pages/boy_girl_hair_create/boy_girl_hair_create_view.dart';
import 'package:ai_hair/pages/hair_list/hair_list_binding.dart';
import 'package:ai_hair/pages/hair_list/hair_list_view.dart';
import 'package:ai_hair/pages/hair_main/hair_main_binding.dart';
import 'package:ai_hair/pages/hair_main/hair_main_shape.dart';
import 'package:ai_hair/pages/hair_main/hair_main_view.dart';
import 'package:ai_hair/pages/hair_preview/hair_preview_binding.dart';
import 'package:ai_hair/pages/hair_preview/hair_preview_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Color primaryColor = const Color(0xffff6c39);
Color bgColor = const Color(0xfff7f7f7);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Get.putAsync(() => DBHair().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Hair,
      initialRoute: '/',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
List<GetPage<dynamic>> Hair = [
  GetPage(name: '/', page: () => HairPreviewView(), binding: HairPreviewBinding()),
  GetPage(name: '/hair_main', page: () => HairMainWidget(), binding: HairMainBinding()),
  GetPage(name: '/hair_list', page: () => HairListWidget(), binding: HairListBinding()),
  GetPage(name: '/hair_shape', page: () => HairMainShape()),
  GetPage(name: '/boy_girl_hair_create', page: () => BoyGirlHairCreateWidget(), binding: BoyGirlHairCreateBinding()),
];