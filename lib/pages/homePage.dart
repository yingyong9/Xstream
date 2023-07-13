import 'package:flutter_tiktok/mock/video.dart';
import 'package:flutter_tiktok/models/video_model.dart';
import 'package:flutter_tiktok/pages/authen.dart';
import 'package:flutter_tiktok/pages/cameraPage.dart';
import 'package:flutter_tiktok/pages/followPage.dart';
import 'package:flutter_tiktok/pages/searchPage.dart';
import 'package:flutter_tiktok/pages/userPage.dart';
import 'package:flutter_tiktok/style/physics.dart';
import 'package:flutter_tiktok/utility/app_controller.dart';
import 'package:flutter_tiktok/utility/app_service.dart';
import 'package:flutter_tiktok/views/tikTokCommentBottomSheet.dart';
import 'package:flutter_tiktok/views/tikTokHeader.dart';
import 'package:flutter_tiktok/views/tikTokScaffold.dart';
import 'package:flutter_tiktok/views/tikTokVideo.dart';
import 'package:flutter_tiktok/views/tikTokVideoButtonColumn.dart';
import 'package:flutter_tiktok/controller/tikTokVideoListController.dart';
import 'package:flutter_tiktok/views/tiktokTabBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safemap/safemap.dart';
import 'package:video_player/video_player.dart';

import 'msgPage.dart';
import 'package:flutter_tiktok/other/bottomSheet.dart' as CustomBottomSheet;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  TikTokPageTag tabBarType = TikTokPageTag.home;

  TikTokScaffoldController tkController = TikTokScaffoldController();

  PageController _pageController = PageController();

  TikTokVideoListController _videoListController = TikTokVideoListController();

  Map<int, bool> favoriteMap = {};

  List<VideoModel> videoDataList = [];

  AppController appController = Get.put(AppController());

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state != AppLifecycleState.resumed) {
      _videoListController.currentPlayer.pause();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _videoListController.currentPlayer.pause();
    super.dispose();
  }

  @override
  void initState() {
    AppService().findCurrentUserModel();

    homePageLoadVideo();

    super.initState();
  }

  void homePageLoadVideo() {
    AppService().readAllVideo().then((value) {
      // videoDataList = UserVideo.fetchVideo();
      videoDataList = appController.videoModels;
      WidgetsBinding.instance.addObserver(this);
      _videoListController.init(
        pageController: _pageController,
        initialList: videoDataList
            .map(
              (e) => VPVideoController(
                videoInfo: e,
                builder: () => VideoPlayerController.network(e.url),
              ),
            )
            .toList(),
        videoProvider: (int index, List<VPVideoController> list) async {
          return videoDataList
              .map(
                (e) => VPVideoController(
                  videoInfo: e,
                  builder: () => VideoPlayerController.network(e.url),
                ),
              )
              .toList();
        },
      );
      _videoListController.addListener(() {
        setState(() {});
      });
      tkController.addListener(
        () {
          if (tkController.value == TikTokPagePositon.middle) {
            _videoListController.currentPlayer.play();
          } else {
            _videoListController.currentPlayer.pause();
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget? currentPage;

    switch (tabBarType) {
      case TikTokPageTag.home:
        break;
      case TikTokPageTag.follow:
        currentPage = FollowPage();
        break;
      case TikTokPageTag.msg:
        currentPage = MsgPage();
        break;
      case TikTokPageTag.me:
        currentPage = UserPage(isSelfPage: true);
        break;
    }
    double a = MediaQuery.of(context).size.aspectRatio;
    bool hasBottomPadding = a < 0.55;

    bool hasBackground = hasBottomPadding;
    hasBackground = tabBarType != TikTokPageTag.home;
    if (hasBottomPadding) {
      hasBackground = true;
    }
    Widget tikTokTabBar = TikTokTabBar(
      hasBackground: hasBackground,
      current: tabBarType,
      onTabSwitch: (type) async {
        if (appController.currentUserModels.isEmpty) {
          Get.to(const Authen());
        } else {
          setState(() {
            tabBarType = type;
            if (type == TikTokPageTag.home) {
              _videoListController.currentPlayer.play();
            } else {
              _videoListController.currentPlayer.pause();
            }
          });
        }
      },
      onAddButton: () {
        if (appController.currentUserModels.isEmpty) {
          Get.to(const Authen());
        } else {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     fullscreenDialog: true,
          //     builder: (context) => CameraPage(),
          //   ),
          // );

          Get.to(CameraPage())!.then((value) => homePageLoadVideo());
        }
      },
    );

    var userPage = UserPage(
      isSelfPage: false,
      canPop: true,
      onPop: () {
        tkController.animateToMiddle();
      },
    );
    var searchPage = SearchPage(
      onPop: tkController.animateToMiddle,
    );

    var header = tabBarType == TikTokPageTag.home
        ? TikTokHeader(
            onSearch: () {
              tkController.animateToLeft();
            },
          )
        : Container();

    // 组合
    return TikTokScaffold(
      controller: tkController,
      hasBottomPadding: hasBackground,
      tabBar: tikTokTabBar,
      header: header,
      leftPage: searchPage,
      rightPage: userPage,
      enableGesture: tabBarType == TikTokPageTag.home,
      // onPullDownRefresh: _fetchData,
      page: Stack(
        // index: currentPage == null ? 0 : 1,
        children: <Widget>[
          PageView.builder(
            key: Key('home'),
            physics: QuickerScrollPhysics(),
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: _videoListController.videoCount,
            itemBuilder: (context, i) {
              bool isF = SafeMap(favoriteMap)[i].boolean;
              var player = _videoListController.playerOfIndex(i)!;
              var data = player.videoInfo!;

              Widget buttons = TikTokButtonColumn(
                isFavorite: isF,
                onAvatar: () {
                  tkController.animateToPage(TikTokPagePositon.right);
                },
                onFavorite: () {
                  setState(() {
                    favoriteMap[i] = !isF;
                  });
                  // showAboutDialog(context: context);
                },
                onComment: () {
                  CustomBottomSheet.showModalBottomSheet(
                    backgroundColor: Colors.white.withOpacity(0),
                    context: context,
                    builder: (BuildContext context) =>
                        TikTokCommentBottomSheet(),
                  );
                },
                onShare: () {},
              );
              // video
              Widget currentVideo = Center(
                child: AspectRatio(
                  aspectRatio: player.controller.value.aspectRatio,
                  child: VideoPlayer(player.controller),
                ),
              );

              currentVideo = TikTokVideoPage(
                hidePauseIcon: !player.showPauseIcon.value,
                aspectRatio: 9 / 16.0,
                key: Key(data.url + '$i'),
                tag: data.url,
                bottomPadding: hasBottomPadding ? 16.0 : 16.0,
                userInfoWidget: VideoUserInfo(
                  desc: data.desc,
                  bottomPadding: hasBottomPadding ? 16.0 : 50.0,
                ),
                onSingleTap: () async {
                  if (player.controller.value.isPlaying) {
                    await player.pause();
                  } else {
                    await player.play();
                  }
                  setState(() {});
                },
                onAddFavorite: () {
                  setState(() {
                    favoriteMap[i] = true;
                  });
                },
                rightButtonColumn: buttons,
                video: currentVideo,
              );
              return currentVideo;
            },
          ),
          currentPage ?? Container(),
        ],
      ),
    );
  }
}
