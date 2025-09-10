import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:ai_hair/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'boy_girl_hair_create_logic.dart';

class BoyGirlHairCreateWidget extends GetView<BoyGirlHairCreateLogic> {
  GlobalKey _contentKey = GlobalKey();

  Offset _position = const Offset(30, 0);

  Future<Uint8List> _mergeImages() async {
    try {
      final RenderRepaintBoundary boundary = _contentKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage();
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      return byteData!.buffer.asUint8List();
    } catch (e) {
      throw Exception('Failed to merge images: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BoyGirlHairCreateLogic>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(controller.gender == 0
              ? '''Lady's hairstyle'''
              : '''Men's hairstyle'''),
          actions: [
            Visibility(
                visible: controller.image != null,
                child: Text('Change the photo',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold))
                    .marginOnly(right: 20)
                    .gestures(onTap: () {
                  controller.imageSelected();
                }))
          ],
        ),
        body: SafeArea(
            child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 381,
                padding:
                    const EdgeInsets.symmetric(horizontal: 66, vertical: 55),
                child: RepaintBoundary(
                    key: _contentKey,
                    child: <Widget>[
                      const SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      controller.image == null
                          ? InkWell(
                              onTap: () {
                                controller.imageSelected();
                              },
                              child: <Widget>[
                                const Icon(
                                  Icons.add,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Add photo',
                                  style: TextStyle(color: Colors.grey),
                                )
                              ].toColumn(
                                  mainAxisAlignment: MainAxisAlignment.center),
                            )
                          : Image.memory(
                              controller.image!,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                      Positioned(
                        left: _position.dx,
                        top: _position.dy,
                        child: GestureDetector(
                          onPanUpdate: (details) {
                            _position = Offset(
                              _position.dx + details.delta.dx,
                              _position.dy + details.delta.dy,
                            );
                            controller.update();
                          },
                          child: Visibility(
                              visible: controller.image != null,
                              child: Image.asset(
                                'assets/${controller.gender == 0 ? 'girl' : 'boy'}${controller.selectedIndex}.png',
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                    ].toStack(alignment: Alignment.center)),
              ).decorated(color: Colors.white),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                child: <Widget>[
                  const Text(
                    'Choose a hairstyle',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10),
                      itemCount: 10,
                      itemBuilder: (_, index) {
                        return <Widget>[
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: <Widget>[
                              const SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                              ),
                              Image.asset(
                                'assets/${controller.gender == 0 ? 'girl' : 'boy'}$index.png',
                                fit: BoxFit.cover,
                              ),
                            ].toStack(alignment: Alignment.center),
                          ).decorated(
                            borderRadius: BorderRadius.circular(7),
                            color: index == controller.selectedIndex
                                ? const Color(0xffffd9cc)
                                : const Color(0xfff4f4f4),
                          ),
                          Positioned(
                            right: 6,
                            top: 6,
                            child: Visibility(
                              visible: index == controller.selectedIndex,
                              child: Icon(
                                Icons.check_circle,
                                color: primaryColor,
                                size: 20,
                              ),
                            ),
                          )
                        ].toStack(alignment: Alignment.center).gestures(
                            onTap: () {
                          controller.selectedIndex = index;
                          controller.update();
                        });
                      })
                ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
              ).decorated(color: Colors.white).marginSymmetric(vertical: 15),
              Visibility(
                visible: controller.image != null,
                child: Container(
                  width: double.infinity,
                  height: 52,
                  alignment: Alignment.center,
                  child: const Text(
                    'Save',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                )
                    .decorated(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(25))
                    .marginSymmetric(horizontal: 15)
                    .gestures(onTap: () async {
                  if (controller.image == null) {
                    Fluttertoast.showToast(msg: 'Please select an image');
                    return;
                  }
                  final mergeImage = await _mergeImages();
                  await controller.saveData(mergeImage);
                }),
              )
            ].toColumn(),
          ),
        )),
      );
    });
  }
}
