import 'package:flutter/material.dart';
import 'package:flutter_tiktok/models/video_model.dart';
import 'package:flutter_tiktok/utility/app_service.dart';
import 'package:flutter_tiktok/views/widget_avatar.dart';
import 'package:flutter_tiktok/views/widget_image.dart';
import 'package:flutter_tiktok/views/widget_text.dart';
import 'package:flutter_tiktok/views/widget_text_button.dart';
import 'package:get/get.dart';

class AppDialog {
  void dialogShowUser({required BuildContext context, required VideoModel videoModel, String? title}) {
    Get.dialog(AlertDialog(
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              title == null
                  ? Column(mainAxisSize: MainAxisSize.min,
                    children: [
                      WidgetAvatar(urlImage: videoModel.mapUserModel['urlAvatar']),
                      title == null ?  WidgetText(data: videoModel.mapUserModel['name']) : const SizedBox(),
                    ],
                  )
                  : Container(margin: const EdgeInsets.only(bottom: 16),
                      child: WidgetText(data: title, textStyle: Theme.of(context).textTheme.titleLarge,),
                    ),
              
            ],
          ),
        ],
      ),
      
      
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              WidgetImage(
                path: 'images/call.png',
                size: 36,
              ),
              const SizedBox(
                width: 16,
              ),
              WidgetText(data: videoModel.mapUserModel['phoneContact']),
            ],
          ),
          Row(
            children: [
              WidgetImage(
                path: 'images/line.png',
                size: 36,
              ),
              const SizedBox(
                width: 16,
              ),
              WidgetText(data: videoModel.mapUserModel['linkLine']),
            ],
          ),
          Row(
            children: [
              WidgetImage(
                path: 'images/messaging.png',
                size: 36,
              ),
              const SizedBox(
                width: 16,
              ),
              WidgetText(data: videoModel.mapUserModel['linkMessaging']),
            ],
          ),
        ],
      ),
    ));
  }

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
