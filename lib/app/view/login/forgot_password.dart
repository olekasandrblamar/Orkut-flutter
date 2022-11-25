import 'package:orkut/app/routes/app_routes.dart';
import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/constant.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  void finish() {
    Constant.backToPrev(context);
  }

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: getPaddingWidget(
              EdgeInsets.symmetric(horizontal: FetchPixels.getPixelHeight(20)),
              Column(
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(26)),
                  gettoolbarMenu(
                    context,
                    "back.svg",
                    () {
                      finish();
                    },
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(46)),
                  getCustomFont("Forgot Password", 24, Colors.black, 1,
                      fontWeight: FontWeight.w700),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  getMultilineCustomFont(
                      "Please enter email for forgot your password.",
                      15,
                      Colors.black,
                      fontWeight: FontWeight.w400,
                      txtHeight: FetchPixels.getPixelHeight(1.3),
                      textAlign: TextAlign.center),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  getDefaultTextFiledWithLabel(
                      context, "Email", emailController,
                      isEnable: false, height: FetchPixels.getPixelHeight(60)),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  getButton(context, blueColor, "Submit", Colors.white, () {
                    Constant.sendToNext(context, Routes.changePasswordRoute);
                  }, 16,
                      weight: FontWeight.w600,
                      borderRadius:
                          BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                      buttonHeight: FetchPixels.getPixelHeight(60)),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          finish();
          return false;
        });
  }
}
