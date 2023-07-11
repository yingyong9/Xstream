import 'package:flutter/material.dart';
import 'package:flutter_tiktok/views/widget_icon_button.dart';
import 'package:get/get.dart';

class WidgetBackButton extends StatelessWidget {
  const WidgetBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetIconButton(
      iconData: Icons.clear,
      pressFunc: () {
        Get.back();
      },
    );
  }
}
