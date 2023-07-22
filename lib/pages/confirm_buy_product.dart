// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_tiktok/models/province_model.dart';

import 'package:flutter_tiktok/models/video_model.dart';
import 'package:flutter_tiktok/style/style.dart';
import 'package:flutter_tiktok/utility/app_controller.dart';
import 'package:flutter_tiktok/utility/app_service.dart';
import 'package:flutter_tiktok/views/widget_form.dart';
import 'package:flutter_tiktok/views/widget_text.dart';
import 'package:get/get.dart';

class ConfirmBuyProduct extends StatefulWidget {
  const ConfirmBuyProduct({
    Key? key,
    required this.videoModel,
    required this.amountProduct,
  }) : super(key: key);

  final VideoModel videoModel;
  final int amountProduct;

  @override
  State<ConfirmBuyProduct> createState() => _ConfirmBuyProductState();
}

class _ConfirmBuyProductState extends State<ConfirmBuyProduct> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    AppService().readAllProvince();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPlate.back1,
        elevation: 0,
        title: WidgetText(data: 'ที่อยู่จัดส่ง'),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 250,
                  margin: const EdgeInsets.only(top: 8),
                  child: WidgetForm(
                    labelWidget: WidgetText(data: 'ชื่อ-นามผู้รับ'),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 250,
                  margin: const EdgeInsets.only(top: 8),
                  child: WidgetForm(
                    labelWidget: WidgetText(data: 'เบอร์โทรศัพย์มือถือ'),
                  ),
                ),
              ],
            ),
            Obx(() {
              return appController.provinceModels.isEmpty
                  ? const SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(color: ColorPlate.darkGray),
                          width: 250,
                          height: 60,
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: DropdownButton<dynamic>(
                            isExpanded: true,
                            underline: const SizedBox(),
                            items: appController.provinceModels
                                .map(
                                  (element) => DropdownMenuItem(
                                    child: WidgetText(data: element.name_th),
                                    value: element,
                                  ),
                                )
                                .toList(),
                            value: appController.chooseProvinceModels.last,
                            hint: WidgetText(data: 'โปรดเลือกจังหวัด'),
                            onChanged: (value) {
                              appController.chooseProvinceModels.add(value);
                              AppService().readAmphure(provinceId: value.id);
                            },
                          ),
                        ),
                      ],
                    );
            }),
            Obx(() {
              return appController.amphureModels.isEmpty
                  ? const SizedBox()
                  : Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                         decoration: BoxDecoration(color: ColorPlate.darkGray),
                              width: 250,
                              height: 60,
                              margin: const EdgeInsets.only(top: 8),
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: DropdownButton<dynamic>(isExpanded: true,underline: const SizedBox(),
                            items: appController.amphureModels
                                .map(
                                  (element) => DropdownMenuItem(
                                    child: WidgetText(data: element.name_th),
                                    value: element,
                                  ),
                                )
                                .toList(),
                            value: appController.chooseAmphureModels.last,
                            hint: WidgetText(data: 'โปรดเลือกอำเภอ'),
                            onChanged: (value) {
                              appController.chooseAmphureModels.add(value);
                            },
                          ),
                      ),
                    ],
                  );
            }),
          ],
        ),
      ),
    );
  }
}
