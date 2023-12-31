import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_tiktok/pages/homePage.dart';
import 'package:flutter_tiktok/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tiktok/utility/app_service.dart';
import 'package:get/get.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverride();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event != null) {
        AppService().findCurrentUserModel();
      }
    });
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Xstream',
      theme: ThemeData(
        brightness: Brightness.dark,
        hintColor: Colors.white,
        // accentColor: Colors.white,
        primaryColor: ColorPlate.orange,
        primaryColorBrightness: Brightness.dark,
        scaffoldBackgroundColor: ColorPlate.back1,
        dialogBackgroundColor: ColorPlate.back2,
        // accentColorBrightness: Brightness.light,
        textTheme: TextTheme(
          bodyText1: StandardTextStyle.normal,
        ),
      ),
      home: HomePage(),
      // home: CameraPage(),
    );
  }
}

class MyHttpOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}
