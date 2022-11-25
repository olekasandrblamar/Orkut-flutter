import 'package:orkut/app/routes/app_routes.dart';
import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/constant.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/material.dart';

class PasswordDialog extends StatefulWidget {
  const PasswordDialog({Key? key}) : super(key: key);

  @override
  State<PasswordDialog> createState() => _PasswordDialogState();
}

class _PasswordDialogState extends State<PasswordDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return ScaleTransition(
      scale: scaleAnimation,
      child: Dialog(
          insetPadding:
              EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(16))),
          backgroundColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getVerSpace(FetchPixels.getPixelHeight(40)),
              getSvgImage("chage_password.svg"),
              getVerSpace(FetchPixels.getPixelHeight(27)),
              getCustomFont("Password Changed", 22, Colors.black, 1,
                  fontWeight: FontWeight.w700),
              getVerSpace(FetchPixels.getPixelHeight(8)),
              getPaddingWidget(
                EdgeInsets.symmetric(
                    horizontal: FetchPixels.getPixelHeight(20)),
                getMultilineCustomFont(
                    "Your password has been successfully changed!",
                    15,
                    Colors.black,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                    txtHeight: FetchPixels.getPixelHeight(1.3)),
              ),
              getVerSpace(FetchPixels.getPixelHeight(30)),
              getPaddingWidget(
                EdgeInsets.symmetric(
                    horizontal: FetchPixels.getPixelHeight(30)),
                getButton(context, blueColor, "Ok", Colors.white, () {
                  Constant.sendToNext(context, Routes.loginRoute);
                }, 16,
                    weight: FontWeight.w600,
                    borderRadius:
                        BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                    buttonHeight: FetchPixels.getPixelHeight(60)),
              ),
              getVerSpace(FetchPixels.getPixelHeight(40)),
            ],
          )),
    );
  }
}
