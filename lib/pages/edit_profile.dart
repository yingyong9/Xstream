import 'package:flutter/material.dart';
import 'package:flutter_tiktok/style/style.dart';
import 'package:flutter_tiktok/utility/app_controller.dart';
import 'package:flutter_tiktok/utility/app_service.dart';
import 'package:flutter_tiktok/views/widget_avatar.dart';
import 'package:flutter_tiktok/views/widget_avatar_file.dart';
import 'package:flutter_tiktok/views/widget_button.dart';
import 'package:flutter_tiktok/views/widget_circel_image.dart';
import 'package:flutter_tiktok/views/widget_form.dart';
import 'package:flutter_tiktok/views/widget_icon_button.dart';
import 'package:flutter_tiktok/views/widget_text.dart';
import 'package:get/get.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  AppController controller = Get.put(AppController());
  TextEditingController textEditingController = TextEditingController();
  bool change = false;

  @override
  void initState() {
    super.initState();
    textEditingController.text = controller.currentUserModels.last.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPlate.back1,
        elevation: 0,
        title: WidgetText(data: 'แก้ไขโปรไฟล์'),
        centerTitle: true,
      ),
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return GetX(
            init: AppController(),
            builder: (AppController appController) {
              return appController.currentUserModels.isEmpty
                  ? const SizedBox()
                  : GestureDetector(
                      onTap: () =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      child: ListView(
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: appController.files.isEmpty
                                        ? WidgetAvatar(
                                            urlImage: appController
                                                .currentUserModels
                                                .last
                                                .urlAvatar,
                                          )
                                        : WidgetAvatarFile(
                                            file: appController.files.last),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: WidgetIconButton(
                                      iconData: Icons.camera_alt_outlined,
                                      pressFunc: () {
                                        AppService().processTakePhoto();
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 250,
                                child: WidgetForm(
                                  textEditingController: textEditingController,
                                  labelWidget: WidgetText(data: 'ชื่อ'),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 250,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    WidgetButton(
                                      label: 'บันทึก',
                                      pressFunc: () {},
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
            });
      }),
    );
  }
}
