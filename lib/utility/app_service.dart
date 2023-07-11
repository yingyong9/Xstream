import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tiktok/models/otp_require_thaibulk.dart';
import 'package:flutter_tiktok/models/video_model.dart';
import 'package:flutter_tiktok/utility/app_constant.dart';
import 'package:flutter_tiktok/utility/app_controller.dart';
import 'package:flutter_tiktok/utility/app_snackbar.dart';
import 'package:get/get.dart';

class AppService {
  AppController appController = Get.put(AppController());

  Future<void> verifyOTPThaibulk(
      {required String token,
      required String pin,
      required BuildContext context,
      required String phoneNumber}) async {
    try {
      String urlApi = 'https://otp.thaibulksms.com/v2/otp/verify';
      Map<String, dynamic> map = {};
      map['key'] = AppConstant.key;
      map['secret'] = AppConstant.secret;
      map['token'] = token;
      map['pin'] = pin;

      Dio dio = Dio();
      dio.options.headers['Content-Type'] = 'application/x-www-form-urlencoded';
      await dio.post(urlApi, data: map).then((value) async {
        print('##11july statusCode --> ${value.statusCode}');
        if (value.statusCode == 200) {
          //Everything OK

          AppSnackBar(title: 'OTP True', message: 'Welcome').normalSnackBar();

          // readAllUserModel().then((value) async {
          //   UserModel? havePhoneUserModel;

          //   bool havePhone = false;

          //   print(
          //       '##13may userModels.length ---->>>${appController.userModels.length}');

          //   for (var element in appController.userModels) {
          //     if (element.phoneNumber == phoneNumber) {
          //       havePhone = true;
          //       havePhoneUserModel = element;
          //     }
          //   }
          //   print('##13may havePhone = $havePhone');

          //   if (havePhone) {
          //     print('##13may เคยเอาเบอร์นี่ไปสมัครแล้ว');
          //     print('##13may havePhoneModel ---> ${havePhoneUserModel!.toMap()}');

          //     await FirebaseAuth.instance
          //         .signInWithEmailAndPassword(
          //             email: havePhoneUserModel.email!,
          //             password: havePhoneUserModel.password!)
          //         .then((value) {
          //       appController.mainUid.value = value.user!.uid;
          //       Get.offAllNamed('/commentChat');
          //     });
          //   } else {
          //     print('##13may เบอร์ใหม่');

          //     print('##13may ต่อไปก็ไป สมัครสมาชิกใหม่');

          //     String email = 'phone$phoneNumber@realpost.com';
          //     String password = '123456';

          //     await FirebaseAuth.instance
          //         .createUserWithEmailAndPassword(
          //             email: email, password: password)
          //         .then((value) {
          //       String uidUser = value.user!.uid;
          //       appController.mainUid.value = uidUser;
          //       print('##13may uidUser ---> $uidUser');
          //       Get.offAll(DisplayName(
          //           uidLogin: uidUser,
          //           phoneNumber: phoneNumber,
          //           email: email,
          //           password: password));
          //     }).catchError((onError) {
          //       print(
          //           '##13may onError on create new accoount ---> ${onError.message}');
          //     });
          //   }
          // });
        }
      });
    } on Exception catch (e) {
      Get.back();
      AppSnackBar(title: 'OTP ผิด', message: 'กรุณาลองใหม่').errorSnackBar();
    }
  }

  Future<OtpRequireThaibulk> processSentSmsThaibulk(
      {required String phoneNumber}) async {
    String urlApi = 'https://otp.thaibulksms.com/v2/otp/request';

    Map<String, dynamic> map = {};
    map['key'] = AppConstant.key;
    map['secret'] = AppConstant.secret;
    map['msisdn'] = phoneNumber;

    Dio dio = Dio();
    dio.options.headers['Content-Type'] = 'application/x-www-form-urlencoded';

    var result = await dio.post(urlApi, data: map);
    OtpRequireThaibulk otpRequireThaibulk =
        OtpRequireThaibulk.fromMap(result.data);
    return otpRequireThaibulk;
  }

  Future<void> readAllVideo() async {
    await FirebaseFirestore.instance.collection('video').get().then((value) {
      for (var element in value.docs) {
        VideoModel videoModel = VideoModel.fromMap(element.data());
        appController.videoModels.add(videoModel);
      }
    });
  }
}
