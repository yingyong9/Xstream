import 'package:flutter/material.dart';
import 'package:flutter_tiktok/views/widget_text_button.dart';
import 'package:get/get.dart';

class AppDialog {
  void normalDialog({
    Widget? icon,
    Widget? title,
    Widget? content,
    Widget? firstAction,
    Widget? secondAction,
    AlignmentGeometry? alignmentGeometry,
  }) {
    Get.dialog(
      AlertDialog(
        alignment: alignmentGeometry,
        backgroundColor: Colors.white,
        icon: icon,
        title: title,
        content: content,
        actions: [
          firstAction ??
              WidgetTextButton(
                label: 'Cancel',
                pressFunc: () {
                  Get.back();
                },
              )
        ],
      ),
    );
  }
}
