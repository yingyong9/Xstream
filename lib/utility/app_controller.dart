import 'dart:io';

import 'package:flutter_tiktok/models/amphure_model.dart';
import 'package:flutter_tiktok/models/districe_model.dart';
import 'package:flutter_tiktok/models/province_model.dart';
import 'package:flutter_tiktok/models/user_model.dart';
import 'package:flutter_tiktok/models/video_model.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  RxList<VideoModel> videoModels = <VideoModel>[].obs;
  RxList<UserModel> currentUserModels = <UserModel>[].obs;
  RxList<File> files = <File>[].obs;
  RxList<String> nameFiles = <String>[].obs;
  RxList<File> productFiles = <File>[].obs;
  RxList<String> productNameFiles = <String>[].obs;
  RxInt amount = 1.obs;

  RxList<ProvinceModel> provinceModels = <ProvinceModel>[].obs;
  RxList<ProvinceModel?> chooseProvinceModels = <ProvinceModel?>[null].obs;

  RxList<AmphureModel> amphureModels = <AmphureModel>[].obs;
  RxList<AmphureModel?> chooseAmphureModels = <AmphureModel?>[null].obs;

  RxList<DistriceModel> districeModels = <DistriceModel>[].obs;
  RxList<DistriceModel?> chooseDistriceModels = <DistriceModel?>[null].obs;
}
