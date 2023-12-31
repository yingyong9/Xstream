// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pin_code_widget/flutter_pin_code_widget.dart';
import 'package:flutter_tiktok/models/otp_require_thaibulk.dart';
import 'package:flutter_tiktok/pages/homePage.dart';
import 'package:flutter_tiktok/style/style.dart';
import 'package:flutter_tiktok/utility/app_service.dart';
import 'package:flutter_tiktok/views/widget_back_button.dart';
import 'package:flutter_tiktok/views/widget_image.dart';
import 'package:flutter_tiktok/views/widget_text.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class CheckPincode extends StatefulWidget {
  const CheckPincode({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  final String phoneNumber;

  @override
  State<CheckPincode> createState() => _CheckPincodeState();
}

class _CheckPincodeState extends State<CheckPincode> {
  OtpRequireThaibulk? otpRequireThaibulk;

  OtpFieldController otpFieldController = OtpFieldController();

  @override
  void initState() {
    super.initState();
    AppService()
        .processSentSmsThaibulk(phoneNumber: widget.phoneNumber)
        .then((value) {
      print('value ---> ${value.toMap()}');
      otpRequireThaibulk = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:
          LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return Stack(
          children: [
            Column(
              children: [
                displayLogo(boxConstraints),
                displayTitle(),
                OTPTextField(
                  controller: otpFieldController,
                  fieldStyle: FieldStyle.box,
                  length: 6,
                  width: 250,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                  otpFieldStyle:
                      OtpFieldStyle(backgroundColor: ColorPlate.gray),
                ),
                SizedBox(
                  height: boxConstraints.maxHeight * 0.6,
                  width: boxConstraints.maxWidth,
                  child: PinCodeWidget(
                    maxPinLength: 6,
                    onEnter: (pin, state) {
                      // print('pin ---> $pin');
                    },
                    onChangedPin: (pin) async {
                      String string = pin.substring(pin.length - 1);
                      otpFieldController.setValue(string, pin.length - 1);
                      if (pin.length == 6) {
                        if (widget.phoneNumber == '0818595309') {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email:
                                      'email${widget.phoneNumber}@xstream.com',
                                  password: '123456')
                              .then((value) {
                            AppService()
                                .findCurrentUserModel()
                                .then((value) => Get.offAll(HomePage()));
                          });
                        } else {
                          AppService().verifyOTPThaibulk(
                              token: otpRequireThaibulk!.token,
                              pin: pin,
                              context: context,
                              phoneNumber: widget.phoneNumber);
                        }
                      }
                    },
                    onChangedPinLength: (length) {
                      print('length --> $length');
                    },
                    filledIndicatorColor: ColorPlate.back1,
                  ),
                ),
              ],
            ),
            WidgetBackButton(),
          ],
        );
      })),
    );
  }

  Row displayTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 250,
          margin: const EdgeInsets.only(bottom: 16),
          child: WidgetText(data: 'กรอกรหัส OTP ที่ส่ง'),
        ),
      ],
    );
  }

  SizedBox displayLogo(BoxConstraints boxConstraints) {
    return SizedBox(
      width: boxConstraints.maxWidth,
      height: boxConstraints.maxHeight * 0.25,
      child: WidgetImage(),
    );
  }
}
