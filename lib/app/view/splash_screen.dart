import 'dart:async';
import 'package:orkut/app/routes/app_routes.dart';
import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/constant.dart';
import 'package:orkut/base/pref_data.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    PrefData.isLogIn().then((value) {
      Timer(
        const Duration(seconds: 3),
        () {
          (value)
              ? Constant.sendToNext(context, Routes.homeScreenRoute)
              : Constant.sendToNext(context, Routes.introRoute);
        },
      );
    });
  }

  void backClick() {
    Constant.backToPrev(context);
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return  WillPopScope(
       child:Scaffold(
          body: SafeArea(
            child: Container(
              color: Color(0xff0075FF),
              child: Center(
              child:Column(
                children: [
                  SizedBox(height: 110,),
                  getAssetImage(
                    "logo.png",
                  ),
                  getCustomFont("Welcome to new world....", 18, Colors.white, 1),
                ],
              )
              ),
            ),
          ),
        ),
        onWillPop: () async {
          backClick();
          return false;
        }
        );
  }
}
