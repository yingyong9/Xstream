import 'dart:io';

import 'package:flutter_tiktok/models/user_model.dart';
import 'package:flutter_tiktok/models/video_model.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  
  RxList<VideoModel> videoModels = <VideoModel>[].obs;
  RxList<UserModel> currentUserModels = <UserModel>[].obs;

  RxList<File> files = <File>[].obs;
  RxList<String> nameFiles = <String>[].obs;


}