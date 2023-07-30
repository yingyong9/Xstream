import 'package:flutter_tiktok/pages/edit_profile.dart';
import 'package:flutter_tiktok/style/style.dart';
import 'package:flutter_tiktok/utility/app_controller.dart';
import 'package:flutter_tiktok/utility/app_service.dart';
import 'package:flutter_tiktok/views/tilTokAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tiktok/views/widget_image.dart';
import 'package:get/get.dart';
import 'package:tapped/tapped.dart';

class UserDetailPage extends StatefulWidget {
  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    Widget head = Obx(() {
      return TikTokAppbar(
        title: appController.currentUserModels.last.name,
      );
    });
    var userHead = Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              'ข้อมูลส่วนตัว',
              style: StandardTextStyle.smallWithOpacity,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Get.to(EditProfile());
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              'แก้ไข',
              style: StandardTextStyle.smallWithOpacity.apply(
                color: ColorPlate.orange,
              ),
            ),
          ),
        )
      ],
    );
    Widget body = Obx(() {
      return ListView(
        padding: EdgeInsets.only(
          bottom: 80 + MediaQuery.of(context).padding.bottom,
        ),
        children: <Widget>[
          userHead,
          _UserInfoRow(
            title: 'ชื่อ',
            rightIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  appController.currentUserModels.last.name,
                  style: StandardTextStyle.small,
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
            onTap: () {},
          ),
          _UserInfoRow(
            title: 'Email',
            rightIcon: Row(
              children: [
                Text(
                  '',
                  style: StandardTextStyle.small,
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
          _UserInfoRow(
            icon: WidgetImage(
              path: 'images/call.png',
              size: 24,
            ),
            rightIcon: Row(
              children: [
                Text(
                  appController.currentUserModels.last.phoneContact ?? '',
                  style: StandardTextStyle.small,
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
          _UserInfoRow(
            icon: WidgetImage(
              path: 'images/line.png',
              size: 24,
            ),
            rightIcon: Row(
              children: [
                Text(
                  appController.currentUserModels.last.linkLine ?? '',
                  style: StandardTextStyle.small,
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
          _UserInfoRow(
            icon: WidgetImage(
              path: 'images/tiktok.png',
              size: 24,
            ),
            rightIcon: Row(
              children: [
                Text(
                  appController.currentUserModels.last.linktiktok ?? '',
                  style: StandardTextStyle.small,
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
          _UserInfoRow(
            icon: WidgetImage(
              path: 'images/facebook.png',
              size: 24,
            ),
            rightIcon: Row(
              children: [
                Text(
                  '',
                  style: StandardTextStyle.small,
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
          _UserInfoRow(
            icon: WidgetImage(
              path: 'images/messaging.png',
              size: 24,
            ),
            rightIcon: Row(
              children: [
                Text(
                  '',
                  style: StandardTextStyle.small,
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
          _UserInfoRow(
            icon: WidgetImage(
              path: 'images/lazada.png',
              size: 24,
            ),
            rightIcon: Row(
              children: [
                Text(
                  '',
                  style: StandardTextStyle.small,
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
          _UserInfoRow(
            icon: WidgetImage(
              path: 'images/shopee.png',
              size: 24,
            ),
            rightIcon: Row(
              children: [
                Text(
                  '',
                  style: StandardTextStyle.small,
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
          _UserInfoRow(
            title: 'Sign Out',
            rightIcon: Row(
              children: [
                Text(
                  'ออกจากระบบ',
                  style: StandardTextStyle.big,
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
            onTap: () {
              AppService().processSignOut();
            },
          ),
        ],
      );
    });
    body = Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: body,
      ),
    );
    return Scaffold(
      body: Container(
        color: ColorPlate.back1,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            head,
            Expanded(child: body),
          ],
        ),
      ),
    );
  }
}

class _UserInfoRow extends StatelessWidget {
  _UserInfoRow({
    this.icon,
    this.title,
    this.rightIcon,
    this.onTap,
  });
  final Widget? icon;
  final Widget? rightIcon;
  final String? title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    Widget iconImg = Container(
      height: 30,
      width: 30,
      child: icon,
    );

    Widget row = Container(
      height: 48,
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        border: Border(
          bottom: BorderSide(color: Colors.white12),
        ),
      ),
      child: Row(
        children: <Widget>[
          icon != null ? iconImg : const SizedBox(),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 12),
              child: title == null
                  ? const SizedBox()
                  : Text(
                      title!,
                      style: TextStyle(fontSize: 14),
                    ),
            ),
          ),
          Opacity(
            opacity: 0.6,
            child: rightIcon ??
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                ),
          ),
        ],
      ),
    );
    row = Tapped(
      onTap: onTap,
      child: row,
    );

    return row;
  }
}
