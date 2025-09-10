import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../main.dart';
import 'ai_hair_logic.dart';

class Ai_hairWidget extends GetView<Ai_hairLogic> {
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

  Widget _statusItem(int index) {
    return SizedBox(
      height: 35,
      child: <Widget>[
        Visibility(
          visible: controller.statusNumList[index].first > 0,
          child: Image.asset(
            'assets/icon${controller.statusNumList[index].first > 1 ? 7 : 8}.png',
            fit: BoxFit.cover,
          ).marginOnly(right: 10),
        ),
        Expanded(
            child: Text(
                controller.statusList[index]
                    [controller.statusNumList[index].first],
                style: TextStyle(
                    color: controller.statusNumList[index].first > 0
                        ? (controller.statusNumList[index].first > 1
                            ? Colors.black
                            : primaryColor)
                        : Colors.grey,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis))),
      ].toRow(),
    );
  }

  Widget _item() {
    Widget item = const SizedBox();
    if (controller.progress < 2) {
      item = <Widget>[
        const SizedBox(
          height: 50,
        ),
        Image.asset(
          'assets/icon5.png',
          fit: BoxFit.cover,
        ),
        const SizedBox(
          height: 40,
        ),
        controller.progress == 0
            ? Container(
                width: double.infinity,
                height: 90,
                child: <Widget>[
                  const Icon(
                    Icons.add,
                    size: 25,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Add photo',
                    style: TextStyle(color: Colors.grey),
                  ),
                ].toColumn(mainAxisAlignment: MainAxisAlignment.center),
              )
                .decorated(
                    color: const Color(0xffe8e8e8),
                    borderRadius: BorderRadius.circular(45))
                .gestures(onTap: () {
                controller.imageSelected();
              })
            : Image.memory(
                controller.image!,
                width: 127,
                height: 155,
                fit: BoxFit.cover,
              ),
        const SizedBox(
          height: 40,
        ),
        Container(
                width: 230,
                height: 52,
                alignment: Alignment.center,
                child: const Text(
                  'Start the analysis',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ))
            .decorated(
                color: controller.progress == 0
                    ? const Color(0xffc7c7c7)
                    : primaryColor,
                borderRadius: BorderRadius.circular(26))
            .gestures(onTap: () {
          if (controller.progress == 1) {
            controller.progress = 2;
            controller.update();
            controller.incrementSubStatus();
          }
        }),
      ].toColumn().marginSymmetric(horizontal: 15);
    } else if (controller.progress == 2) {
      item = <Widget>[
        Image.asset(
          'assets/icon6.png',
          fit: BoxFit.cover,
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          height: 624,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
          child: <Widget>[
            Image.memory(
              controller.image!,
              width: 211,
              height: 255,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: <Widget>[
                _statusItem(0),
                _statusItem(1),
                _statusItem(2),
                _statusItem(3),
                _statusItem(4)
              ].toColumn(),
            ).decorated(
                color: const Color(0xfff4f4f4),
                borderRadius: BorderRadius.circular(10))
          ].toColumn(),
        ).decorated(
            color: Colors.white, borderRadius: BorderRadius.circular(20))
      ].toColumn().marginSymmetric(horizontal: 15);
    } else {
      item = <Widget>[
        Image.asset(
          'assets/icon6.png',
          fit: BoxFit.cover,
        ),
        const Text(
          'Analysis completed',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(
          height: 20,
        ),
        RepaintBoundary(
          key: _contentKey,
          child: Container(
                  width: 285,
                  height: 307,
                  child: <Widget>[
                    Image.memory(
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
                        child: Image.asset(
                          'assets/${controller.gender == 0 ? 'girl' : 'boy'}${controller.hairNumList[controller.selectedIndex]}.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ].toStack())
              .decorated(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
        ),
        const SizedBox(
          height: 20,
        ),
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                itemCount: controller.hairNumList.length,
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
                          'assets/${controller.gender == 0 ? 'girl' : 'boy'}${controller.hairNumList[index]}.png',
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
                  ].toStack(alignment: Alignment.center).gestures(onTap: () {
                    controller.selectedIndex = index;
                    controller.update();
                  });
                })
          ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
        ).decorated(color: Colors.white).marginSymmetric(vertical: 15),
      ].toColumn();
    }
    return item;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Ai_hairLogic>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Analysis of suitable hairstyles'),
          actions: [
            Visibility(
                visible: controller.progress == 3,
                child: Text('Save',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold))
                    .marginOnly(right: 20)
                    .gestures(onTap: () async {
                  final mergedImage = await _mergeImages();
                  await controller.saveData(mergedImage);
                })),
          ],
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(
              child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: _item(),
          ).marginSymmetric(vertical: 15)),
        ),
      );
    });
  }
}
