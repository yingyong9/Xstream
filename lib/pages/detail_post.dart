// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tiktok/utility/app_service.dart';
import 'package:get/get.dart';

import 'package:flutter_tiktok/pages/homePage.dart';
import 'package:flutter_tiktok/style/style.dart';
import 'package:flutter_tiktok/views/widget_back_button.dart';
import 'package:flutter_tiktok/views/widget_button.dart';
import 'package:flutter_tiktok/views/widget_form_multiline.dart';
import 'package:flutter_tiktok/views/widget_image_file.dart';

class DetailPost extends StatefulWidget {
  const DetailPost({
    Key? key,
    required this.fileThumbnail,
    required this.fileVideo,
    required this.nameFileVideo,
    required this.nameFileImage,
  }) : super(key: key);

  final File fileThumbnail;
  final File fileVideo;
  final String nameFileVideo;
  final String nameFileImage;

  @override
  State<DetailPost> createState() => _DetailPostState();
}

class _DetailPostState extends State<DetailPost> {
  TextEditingController detailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPlate.back1,
        leading: WidgetBackButton(
          pressFunc: () {
            Get.offAll(HomePage());
          },
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SizedBox(
              width: boxConstraints.maxWidth,
              height: boxConstraints.maxHeight,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: boxConstraints.maxWidth * 0.75 - 16,
                        child: WidgetFormMultiLine(
                          textEditingController: detailController,
                          hint: 'กรอกข้อความ',
                          maxLines: 5,
                        ),
                      ),
                      SizedBox(
                        width: boxConstraints.maxWidth * 0.25,
                        height: boxConstraints.maxWidth * 0.35,
                        child: WidgetImageFile(fileImage: widget.fileThumbnail),
                      ),
                    ],
                  ),
                  const Divider(
                    color: ColorPlate.gray,
                  ),
                  Row(
                    children: [
                      WidgetButton(
                        label: 'สร้างสินค้า',
                        pressFunc: () {},
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(color: ColorPlate.back1),
        width: double.infinity,
        child: WidgetButton(
          color: ColorPlate.red,
          label: 'โพสต์',
          pressFunc: () async {
            String? urlImage = await AppService().processUploadThumbnailVideo(
                fileThumbnail: widget.fileThumbnail,
                nameFile: widget.nameFileImage);
            print('urlImage ---> $urlImage');
            AppService().processFtpUploadAndInsertDataVideo(
                fileVideo: widget.fileVideo,
                nameFileVideo: widget.nameFileVideo,
                urlThumbnail: urlImage!,
                detail: detailController.text);
          },
        ),
      ),
    );
  }
}
