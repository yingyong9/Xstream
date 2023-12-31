// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:flutter/material.dart';
import 'package:flutter_tiktok/views/widget_avatar.dart';
import 'package:get/get.dart';
import 'package:tapped/tapped.dart';

import 'package:flutter_tiktok/models/video_model.dart';
import 'package:flutter_tiktok/pages/confirm_buy_product.dart';
import 'package:flutter_tiktok/style/style.dart';
import 'package:flutter_tiktok/utility/app_controller.dart';
import 'package:flutter_tiktok/utility/app_dialog.dart';
import 'package:flutter_tiktok/views/widget_button.dart';
import 'package:flutter_tiktok/views/widget_icon_button.dart';
import 'package:flutter_tiktok/views/widget_image_network.dart';
import 'package:flutter_tiktok/views/widget_text.dart';

class TikTokButtonColumn extends StatelessWidget {
  final double? bottomPadding;
  final bool isFavorite;
  final Function? onFavorite;
  final Function? onComment;
  final Function? onShare;
  final Function? onAvatar;
  final VideoModel videoModel;

  const TikTokButtonColumn({
    Key? key,
    this.bottomPadding,
    required this.isFavorite,
    this.onFavorite,
    this.onComment,
    this.onShare,
    this.onAvatar,
    required this.videoModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppController appController = Get.put(AppController());

    return Container(
      // color: Colors.red,
      // width: SysSize.avatar,
      margin: EdgeInsets.only(
        bottom: bottomPadding ?? 0,
        right: 12,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Tapped(
            child: TikTokAvatar(
              videoModel: videoModel,
            ),
            onTap: onAvatar,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FavoriteIcon(
                onFavorite: onFavorite,
                isFavorite: isFavorite,
              ),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     _IconButton(
          //       icon: IconToText(Icons.mode_comment, size: SysSize.iconBig - 4),
          //       text: '4213',
          //       onTap: onComment,
          //     ),
          //   ],
          // ),
          displayImageProduct(appController, context: context),
          Container(
            width: SysSize.avatar,
            height: SysSize.avatar,
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SysSize.avatar / 2.0),
              // color: Colors.black.withOpacity(0.8),
            ),
          )
        ],
      ),
    );
  }

  Widget displayImageProduct(AppController appController, {required BuildContext context}) {
    return videoModel.urlProduct!.isEmpty
        ? const SizedBox()
        : InkWell(
            onTap: () {
              // dialogChooseAmountProduct(appController);

              AppDialog().dialogShowUser(videoModel: videoModel, title: 'ซื้อสินค้าที่นี่', context: context);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              width: 110,
              height: 170,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  WidgetImageNetwork(
                    urlImage: videoModel.urlProduct!,
                    size: 100,
                    boxFit: BoxFit.cover,
                  ),
                  Text(
                    videoModel.nameProduct!,
                    style: TextStyle(color: ColorPlate.black),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      WidgetText(
                        data: '฿',
                        textStyle: TextStyle(
                            color: ColorPlate.black,
                            fontWeight: FontWeight.w700),
                      ),
                      WidgetText(
                        data: videoModel.priceProduct!,
                        textStyle: TextStyle(
                            color: ColorPlate.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(color: ColorPlate.white),
            ),
          );
  }

  void dialogChooseAmountProduct(AppController appController) {
    appController.amount.value = 1;
    AppDialog().normalDialog(
        alignmentGeometry: Alignment(0, -0.3),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                WidgetText(
                  data: 'จำนวน',
                  textStyle: TextStyle(color: Colors.black),
                ),
                const Spacer(),
                WidgetIconButton(
                  iconData: Icons.remove_circle_outline,
                  color: Colors.black,
                  pressFunc: () {
                    if (appController.amount.value > 1) {
                      appController.amount.value--;
                    }
                  },
                ),
                Obx(() {
                  return WidgetText(
                    data: appController.amount.toString(),
                    textStyle: TextStyle(color: Colors.black),
                  );
                }),
                WidgetIconButton(
                  iconData: Icons.add_circle_outline,
                  color: Colors.black,
                  pressFunc: () {
                    appController.amount.value++;
                  },
                ),
              ],
            ),
            Row(
              children: [
                WidgetText(
                  data: 'ทั้งหมด',
                  textStyle: TextStyle(color: Colors.black),
                ),
                const Spacer(),
                Obx(() {
                  return WidgetText(
                    data:
                        '฿ ${int.parse(videoModel.priceProduct!) * appController.amount.value}',
                    textStyle: TextStyle(color: Colors.black),
                  );
                }),
                const SizedBox(
                  width: 50,
                )
              ],
            ),
          ],
        ),
        firstAction: SizedBox(
          width: double.infinity,
          child: WidgetButton(
            color: ColorPlate.red,
            label: 'ยืนยัน',
            pressFunc: () {
              Get.back();
              Get.to(ConfirmBuyProduct(
                  videoModel: videoModel,
                  amountProduct: appController.amount.value));
            },
          ),
        ));
  }
}

class FavoriteIcon extends StatelessWidget {
  const FavoriteIcon({
    Key? key,
    required this.onFavorite,
    this.isFavorite,
  }) : super(key: key);
  final bool? isFavorite;
  final Function? onFavorite;

  @override
  Widget build(BuildContext context) {
    return _IconButton(
      icon: IconToText(
        Icons.favorite,
        size: SysSize.iconBig,
        color: isFavorite! ? ColorPlate.red : null,
      ),
      text: '1.0w',
      onTap: onFavorite,
    );
  }
}

class TikTokAvatar extends StatelessWidget {
  const TikTokAvatar({
    Key? key,
    required this.videoModel,
  }) : super(key: key);

  final VideoModel videoModel;

  @override
  Widget build(BuildContext context) {
    Widget avatar = Container(
      width: SysSize.avatar,
      height: SysSize.avatar,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(SysSize.avatar / 2.0),
        color: Colors.black,
      ),
      child: WidgetAvatar(urlImage: videoModel.mapUserModel['urlAvatar']),
    );
    Widget addButton = Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorPlate.red,
      ),
      child: Icon(
        Icons.add,
        size: 16,
      ),
    );
    return Container(
      width: SysSize.avatar,
      height: 66,
      margin: EdgeInsets.only(bottom: 6),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[avatar, addButton],
      ),
    );
  }
}

class IconToText extends StatelessWidget {
  final IconData? icon;
  final TextStyle? style;
  final double? size;
  final Color? color;

  const IconToText(
    this.icon, {
    Key? key,
    this.style,
    this.size,
    this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      String.fromCharCode(icon!.codePoint),
      style: style ??
          TextStyle(
            fontFamily: 'MaterialIcons',
            fontSize: size ?? 30,
            inherit: true,
            color: color ?? ColorPlate.white,
          ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final Widget? icon;
  final String? text;
  final Function? onTap;
  const _IconButton({
    Key? key,
    this.icon,
    this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var shadowStyle = TextStyle(
      shadows: [
        Shadow(
          color: Colors.black.withOpacity(0.15),
          offset: Offset(0, 1),
          blurRadius: 1,
        ),
      ],
    );
    Widget body = Column(
      children: <Widget>[
        Tapped(
          child: icon ?? Container(),
          onTap: onTap,
        ),
        Container(height: 2),
        Text(
          text ?? '??',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: SysSize.small,
            color: ColorPlate.white,
          ),
        ),
      ],
    );
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: DefaultTextStyle(
        child: body,
        style: shadowStyle,
      ),
    );
  }
}
