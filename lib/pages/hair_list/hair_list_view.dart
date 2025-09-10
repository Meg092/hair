import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../main.dart';
import 'hair_list_logic.dart';

class HairListWidget extends GetView<HairListLogic> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HairListLogic>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Album'),
          actions: [
            Visibility(
                visible: !controller.isEdit,
                child: Text('Edit',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold))
                    .marginOnly(right: 20)
                    .gestures(onTap: () {
                  controller.isEdit = !controller.isEdit;
                  controller.update();
                })),
            Visibility(
                visible: controller.isEdit,
                child: Text('Cancel',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold))
                    .marginOnly(right: 20)
                    .gestures(onTap: () {
                  controller.isEdit = !controller.isEdit;
                  controller.selectedList.clear();
                  controller.update();
                })),
            Visibility(
                visible: controller.isEdit,
                child: Text('Delete',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold))
                    .marginOnly(right: 20)
                    .gestures(onTap: () async {
                  if (controller.selectedList.isEmpty) {
                    Fluttertoast.showToast(
                        msg: 'Please select at least one item');
                    return;
                  }
                  await controller.dbHair
                      .cleanHairsData(controller.selectedList);
                  await controller.getData();
                })),
          ],
        ),
        body: Obx(() {
          return controller.list.isEmpty
              ? const Center(
                  child: Text('No Data'),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(15),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 103 / 140),
                  itemCount: controller.list.length,
                  itemBuilder: (_, index) {
                    final entity = controller.list[index];
                    return <Widget>[
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: <Widget>[
                          const SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          Image.memory(
                            entity.image,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ].toStack(alignment: Alignment.center),
                      ).decorated(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      Positioned(
                        right: 15,
                        top: 15,
                        child: Visibility(
                          visible: controller.isEdit,
                          child: Icon(
                            controller.selectedList.contains(entity)
                                ? Icons.check_circle
                                : Icons.circle_outlined,
                            color: controller.selectedList.contains(entity)
                                ? primaryColor
                                : Colors.grey,
                            size: 20,
                          ),
                        ),
                      )
                    ].toStack(alignment: Alignment.center).gestures(onTap: () {
                      if (controller.isEdit) {
                        controller.selectedList.contains(entity)
                            ? controller.selectedList.remove(entity)
                            : controller.selectedList.add(entity);
                      }
                      controller.update();
                    });
                  });
        }),
      );
    });
  }
}
