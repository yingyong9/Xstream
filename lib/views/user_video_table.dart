// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_tiktok/style/style.dart';
import 'package:flutter_tiktok/utility/app_controller.dart';
import 'package:flutter_tiktok/utility/app_service.dart';
import 'package:flutter_tiktok/views/widget_image_network.dart';
import 'package:flutter_tiktok/views/widget_text.dart';
import 'package:get/get.dart';

class UserVideoTable extends StatefulWidget {
  const UserVideoTable({
    Key? key,
    required this.uid,
  }) : super(key: key);

  final String uid;

  @override
  State<UserVideoTable> createState() => _UserVideoTableState();
}

class _UserVideoTableState extends State<UserVideoTable> {
  @override
  void initState() {
    super.initState();
    AppService().findUrlImageVideo(uid: widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          print(
              '##2aug postVideoModel ----> ${appController.postVideoModels.length}');
          return Column(
            children: <Widget>[
              Container(
                color: ColorPlate.back1,
                padding: EdgeInsets.symmetric(
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _PointSelectTextButton(true, 'วีดีโอของฉัน'),
                    _PointSelectTextButton(false, 'ติดตาม'),
                    _PointSelectTextButton(false, 'ชื่นชอบ'),
                  ],
                ),
              ),
              Obx(() {
                return appController.postVideoModels.isEmpty
                    ? const SizedBox()
                    : GridView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: appController.postVideoModels.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, childAspectRatio: 3/4, mainAxisSpacing: 4, crossAxisSpacing: 4),
                        itemBuilder: (context, index) => WidgetImageNetwork(
                            urlImage:
                                appController.postVideoModels[index].image, boxFit: BoxFit.cover,),
                      );
              }),
            ],
          );
        });
  }
}

class _PointSelectTextButton extends StatelessWidget {
  final bool isSelect;
  final String title;
  final Function? onTap;
  const _PointSelectTextButton(
    this.isSelect,
    this.title, {
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          isSelect
              ? Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: ColorPlate.orange,
                    borderRadius: BorderRadius.circular(3),
                  ),
                )
              : Container(),
          Container(
            padding: EdgeInsets.only(left: 2),
            child: Text(
              title,
              style: isSelect
                  ? StandardTextStyle.small
                  : StandardTextStyle.smallWithOpacity,
            ),
          )
        ],
      ),
    );
  }
}
