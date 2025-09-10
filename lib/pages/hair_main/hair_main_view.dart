import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'hair_main_logic.dart';

class HairMainWidget extends GetView<HairMainLogic> {
  Widget _item(int index) {
    final titles = [
      '''Lady's hairstyle''',
      '''Men's hairstyle''',
      // 'Analysis of suitable hairstyles',
      'Album'
    ];
    return Container(
      width: double.infinity,
      height: 83,
      padding: const EdgeInsets.all(12),
      child: <Widget>[
        <Widget>[
          Image.asset(
            'assets/icon$index.png',
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            titles[index],
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ].toRow(),
        Image.asset(
          'assets/icon4.png',
          fit: BoxFit.cover,
        )
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
    )
        .decorated(color: Colors.white, borderRadius: BorderRadius.circular(10))
        .marginOnly(bottom: 10)
        .gestures(onTap: () {
      if (index < 2) {
        Get.toNamed('/boy_girl_hair_create', arguments: index);
      } else if (index == 2) {
        Get.toNamed('/hair_list');
        // Get.toNamed(HairNames.aiHair);
      }
      // else {
      //   Get.toNamed(HairNames.hairList);
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: <Widget>[
        const SizedBox(
          width: double.infinity,
          height: double.infinity,
        ),
        Image.asset(
          'assets/bg.png',
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        Positioned(
            top: 160,
            left: 15,
            child: <Widget>[
              const Text(
                'Magic hairstyle',
                style: TextStyle(fontSize: 38, fontWeight: FontWeight.w900),
              ),
              const Text('Experience different hairstyles')
            ].toColumn(crossAxisAlignment: CrossAxisAlignment.start)),
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(
              child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: <Widget>[
              _item(0),
              _item(1),
              _item(2),
              // _item(3),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                child: <Widget>[
                  InkWell(onTap: (){
                    controller.cleanHairData();
                  },child: <Widget>[
                    const Text('Delete album entries'),
                    const Icon(
                      Icons.keyboard_arrow_right,
                      size: 20,
                      color: Colors.grey,
                    )
                  ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),),
                  <Widget>[
                    const Text('App version'),
                    Obx(() {
                      return Text(
                        controller.appVersion.value,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      );
                    })
                  ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
                ].toColumn(
                    separator: Divider(
                  height: 15,
                  color: Colors.grey[300],
                )),
              ).decorated(
                  color: Colors.white, borderRadius: BorderRadius.circular(10))
            ].toColumn().marginOnly(top: 250, left: 15, right: 15),
          )),
        )
      ].toStack(),
    );
  }
}
