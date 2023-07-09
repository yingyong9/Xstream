import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tiktok/models/video_model.dart';
import 'package:flutter_tiktok/utility/app_controller.dart';
import 'package:get/get.dart';

class AppService {
  AppController appController = Get.put(AppController());

  Future<void> readAllVideo() async {
    await FirebaseFirestore.instance.collection('video').get().then((value) {
      for (var element in value.docs) {
        VideoModel videoModel = VideoModel.fromMap(element.data());
        appController.videoModels.add(videoModel);
      }
    });
  }
}
