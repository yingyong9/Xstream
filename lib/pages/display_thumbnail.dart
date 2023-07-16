// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tiktok/utility/app_service.dart';

import 'package:flutter_tiktok/views/widget_button.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class DisplayThumbnail extends StatefulWidget {
  const DisplayThumbnail({
    Key? key,
    required this.fileThumbnail,
    required this.fileVideo,
  }) : super(key: key);

  final File fileThumbnail;
  final File fileVideo;

  @override
  State<DisplayThumbnail> createState() => _DisplayThumbnailState();
}

class _DisplayThumbnailState extends State<DisplayThumbnail> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();

    videoPlayerController = VideoPlayerController.file(widget.fileVideo)
      ..initialize()
      ..play();
    chewieController = ChewieController(
        videoPlayerController: videoPlayerController!,
        autoPlay: true,
        aspectRatio: 9 / 16,
        looping: true);
  }

  @override
  void dispose() {
    videoPlayerController!.dispose();
    chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return Column(
          children: [
            SizedBox(
              width: boxConstraints.maxWidth,
              height: boxConstraints.maxHeight - 48,
              child: Chewie(controller: chewieController!),
            ),
            bottomPanal(boxConstraints: boxConstraints),
          ],
        );
      }),
    );
  }

  Widget bottomPanal({required BoxConstraints boxConstraints}) {
    return Positioned(
      bottom: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: boxConstraints.maxWidth * 0.5 - 16,
            child: WidgetButton(
              label: 'ยกเลิก',
              pressFunc: () {
                Get.back();
              },
            ),
          ),
          SizedBox(
            width: boxConstraints.maxWidth * 0.5 - 16,
            child: WidgetButton(
              color: Colors.red.shade700,
              // label: 'โฟสต์',
              label: 'ต่อไป',
              pressFunc: () {
               
              },
            ),
          ),
        ],
      ),
    );
  }
}
