import 'package:orkut/app/view/dialog/password_dialog.dart';
import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/constant.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  void finish() {
    Constant.backToPrev(context);
  }

  TextEditingController newpasswordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  var isnewpass = false;
  var isconfirmpass = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: getPaddingWidget(
                EdgeInsets.symmetric(
                    horizontal: FetchPixels.getPixelHeight(20)),
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
                    getCustomFont("Change Password", 24, Colors.black, 1,
                        fontWeight: FontWeight.w700),
                    getVerSpace(FetchPixels.getPixelHeight(10)),
                    getMultilineCustomFont(
                        "Please enter new password for change your password.",
                        15,
                        Colors.black,
                        fontWeight: FontWeight.w400,
                        txtHeight: FetchPixels.getPixelHeight(1.3),
                        textAlign: TextAlign.center),
                    getVerSpace(FetchPixels.getPixelHeight(30)),
                    getDefaultTextFiledWithLabel(
                        context, "New Password", newpasswordController,
                        height: FetchPixels.getPixelHeight(60),
                        withSufix: true,
                        suffiximage: "eye.svg",
                        isEnable: false,
                        isPass: isnewpass, imagefunction: () {
                      setState(() {
                        !isnewpass ? isnewpass = true : isnewpass = false;
                      });
                    }),
                    getVerSpace(FetchPixels.getPixelHeight(20)),
                    getDefaultTextFiledWithLabel(
                        context, "Confirm Password", confirmpasswordController,
                        height: FetchPixels.getPixelHeight(60),
                        withSufix: true,
                        suffiximage: "eye.svg",
                        isEnable: false,
                        isPass: isconfirmpass, imagefunction: () {
                      setState(() {
                        !isconfirmpass
                            ? isconfirmpass = true
                            : isconfirmpass = false;
                      });
                    }),
                    getVerSpace(FetchPixels.getPixelHeight(30)),
                    getButton(context, blueColor, "Submit", Colors.white, () {
                      showDialog(
                          barrierDismissible: false,
                          builder: (context) {
                            return const PasswordDialog();
                          },
                          context: context);
                    }, 16,
                        weight: FontWeight.w600,
                        borderRadius: BorderRadius.circular(
                            FetchPixels.getPixelHeight(15)),
                        buttonHeight: FetchPixels.getPixelHeight(60)),
                  ],
                )),
          ),
        ),
        onWillPop: () async {
          finish();
          return false;
        });
  }
}
