import 'package:flutter_tiktok/pages/edit_profile.dart';
import 'package:flutter_tiktok/pages/userDetailPage.dart';
import 'package:flutter_tiktok/style/style.dart';
import 'package:flutter_tiktok/utility/app_controller.dart';
import 'package:flutter_tiktok/utility/app_service.dart';
import 'package:flutter_tiktok/views/topToolRow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tiktok/views/user_video_table.dart';
import 'package:get/get.dart';
import 'package:tapped/tapped.dart';

class UserPage extends StatefulWidget {
  final bool canPop;
  final bool isSelfPage;
  final Function? onPop;
  final Function? onSwitch;

  const UserPage({
    Key? key,
    this.canPop: false,
    this.onPop,
    required this.isSelfPage,
    this.onSwitch,
  }) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    // AppService().findCurrentUserModel().then((value) {
    //   AppService()
    //     .findUrlImageVideo(uid: appController.currentUserModels.last.uid);
    // });
  }

  @override
  Widget build(BuildContext context) {
    Widget likeButton = Container(
      color: ColorPlate.back1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Tapped(
            child: _UserRightButton(
              // title: widget.isSelfPage ? 'แก้ไขโปรไฟร์' : 'เจ้าของวีดีโอ',
              title: '',
            ),
            onTap: () {
              Get.to(EditProfile());
            },
          ),
        ],
      ),
    );
    Widget avatar = Container(
      height: 120 + MediaQuery.of(context).padding.top,
      // padding: EdgeInsets.only(left: 18),
      alignment: Alignment.center,
      child: OverflowBox(
        // alignment: Alignment.bottomLeft,
        minHeight: 20,
        maxHeight: 300,
        child: Container(
          height: 104,
          width: 104,
          margin: EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(74),
            color: Colors.black,
            border: Border.all(
              color: Colors.white,
              width: 1,
            ),
          ),
          child: ClipOval(
                    child: Image.asset(
                      'images/logo3.png',
                      fit: BoxFit.cover,
                    ),
                  ),
        ),
      ),
    );
    Widget body = ListView(
              physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              children: <Widget>[
                Container(height: 20),
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: <Widget>[likeButton, avatar],
                ),
                Container(
                  color: ColorPlate.back1,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 18),
                        color: ColorPlate.back1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                 Text(
                                  'Name',
                                  style: StandardTextStyle.big,
                                ),
                              ],
                            ),
                            Container(height: 8),
                            Container(height: 10),
                            Row(
                              children: <Widget>[
                                _UserTag(tag: 'สินค้าของคุณ'),
                                _UserTag(tag: 'เพิ่มเพื่อน'),
                                _UserTag(tag: 'คำสั่งซื้อของคุณ'),
                                // _UserTag(tag: '狮子座'),
                              ],
                            ),
                            Container(height: 10),
                          ],
                        ),
                      ),
                      Container(
                        color: ColorPlate.back1,
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            TextGroup('356', 'กำลังติดตาม'),
                            TextGroup('145', 'ผู้ติดตาม'),
                            TextGroup('1423', 'ถูกใจ'),
                          ],
                        ),
                      ),
                      Container(
                        height: 10,
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                        ),
                      ),
                      // UserVideoTable(
                      //   uid: appController.currentUserModels.last.uid,
                      // ),
                    ],
                  ),
                ),
              ],
            );
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          colors: <Color>[
            ColorPlate.back1,
            ColorPlate.back1,
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 400),
            height: double.infinity,
            width: double.infinity,
            color: ColorPlate.back1,
          ),
          body,
          Container(
            margin: EdgeInsets.only(top: 20),
            height: 62,
            child: TopToolRow(
              canPop: widget.canPop,
              onPop: widget.onPop,
              right: Tapped(
                child: Container(
                  width: 30,
                  height: 30,
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.36),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.more_horiz,
                    size: 24,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => UserDetailPage(),
                  ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void aaa() {}

class _UserRightButton extends StatelessWidget {
  const _UserRightButton({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 20,
      ),
      margin: EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(color: ColorPlate.orange),
      ),
      // decoration: BoxDecoration(
      //   border: Border.all(color: ColorPlate.orange),
      //   borderRadius: BorderRadius.circular(4),
      // ),
    );
  }
}

class _UserTag extends StatelessWidget {
  final String? tag;
  const _UserTag({
    Key? key,
    this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      padding: EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 4,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        tag ?? '标签',
        style: StandardTextStyle.smallWithOpacity,
      ),
    );
  }
}

class _UserVideoTable extends StatelessWidget {
  const _UserVideoTable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        Container(
          child: Row(
            children: <Widget>[
              _SmallVideo(),
              _SmallVideo(),
              _SmallVideo(),
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              _SmallVideo(),
              _SmallVideo(),
              _SmallVideo(),
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              _SmallVideo(),
              _SmallVideo(),
              _SmallVideo(),
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              _SmallVideo(),
              _SmallVideo(),
              _SmallVideo(),
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              _SmallVideo(),
              _SmallVideo(),
              _SmallVideo(),
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              _SmallVideo(),
              _SmallVideo(),
              _SmallVideo(),
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              _SmallVideo(),
              _SmallVideo(),
              _SmallVideo(),
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              _SmallVideo(),
              _SmallVideo(),
              _SmallVideo(),
            ],
          ),
        ),
      ],
    );
  }
}

class _SmallVideo extends StatelessWidget {
  const _SmallVideo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 3 / 4.0,
        child: Container(
          decoration: BoxDecoration(
            color: ColorPlate.darkGray,
            border: Border.all(color: Colors.black),
          ),
          alignment: Alignment.center,
          child: Text(
            '作品',
            style: TextStyle(
              color: Colors.white.withOpacity(0.1),
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
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

// class _IconTextButton extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final Function onTap;
//   const _IconTextButton(
//     this.icon,
//     this.title, {
//     Key key,
//     this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 12),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Icon(icon, color: ColorPlate.yellow),
//           Container(
//             padding: EdgeInsets.only(left: 2),
//             child: Text(
//               title,
//               style: TextStyle(color: ColorPlate.yellow),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

class TextGroup extends StatelessWidget {
  final String title, tag;
  final Color? color;

  const TextGroup(
    this.title,
    this.tag, {
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            title,
            style: StandardTextStyle.big.apply(color: color),
          ),
          Container(width: 4),
          Text(
            tag,
            style: StandardTextStyle.smallWithOpacity.apply(
              color: color?.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
