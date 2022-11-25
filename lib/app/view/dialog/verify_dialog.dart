import 'package:orkut/app/routes/app_routes.dart';
import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/constant.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/material.dart';

class VerifyDialog extends StatefulWidget {
  const VerifyDialog({Key? key}) : super(key: key);

  @override
  State<VerifyDialog> createState() => _VerifyDialogState();
}

class _VerifyDialogState extends State<VerifyDialog>
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
              getSvgImage("verify_logo.svg"),
              getVerSpace(FetchPixels.getPixelHeight(27)),
              getCustomFont("Account Created", 22, Colors.black, 1,
                  fontWeight: FontWeight.w700),
              getVerSpace(FetchPixels.getPixelHeight(8)),
              getPaddingWidget(
                EdgeInsets.symmetric(
                    horizontal: FetchPixels.getPixelHeight(20)),
                getMultilineCustomFont(
                    "Your account has been successfully created!",
                    15,
                    Colors.black,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                    txtHeight: FetchPixels.getPixelHeight(1.3)),
              ),
              getVerSpace(FetchPixels.getPixelHeight(30)),
              getPaddingWidget(
                EdgeInsets.symmetric(
                    horizontal: FetchPixels.getPixelHeight(20)),
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
