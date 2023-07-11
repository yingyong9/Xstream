// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_pin_code_widget/flutter_pin_code_widget.dart';
import 'package:flutter_tiktok/models/otp_require_thaibulk.dart';
import 'package:flutter_tiktok/utility/app_service.dart';
import 'package:flutter_tiktok/views/widget_back_button.dart';
import 'package:flutter_tiktok/views/widget_image.dart';

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
                SizedBox(
                  width: boxConstraints.maxWidth,
                  height: boxConstraints.maxHeight * 0.4,
                  child: WidgetImage(),
                ),
                SizedBox(
                  height: boxConstraints.maxHeight * 0.6,
                  width: boxConstraints.maxWidth,
                  child: PinCodeWidget(
                    maxPinLength: 6,
                    onEnter: (pin, state) {
                      // print('pin ---> $pin');
                    },
                    onChangedPin: (pin) {
                      print('pin ---> $pin');
                      if (pin.length == 6) {
                        print('Check');
                        AppService().verifyOTPThaibulk(
                            token: otpRequireThaibulk!.token,
                            pin: pin,
                            context: context,
                            phoneNumber: widget.phoneNumber);
                      }
                    },
                    onChangedPinLength: (length) {
                      print('length --> $length');
                    },
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
}
