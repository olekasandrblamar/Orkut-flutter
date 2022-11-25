import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/constant.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/material.dart';

class PriceDialog extends StatefulWidget {
  const PriceDialog({Key? key}) : super(key: key);

  @override
  State<PriceDialog> createState() => _PriceDialogState();
}

class _PriceDialogState extends State<PriceDialog>
    with SingleTickerProviderStateMixin {
  void backToPrev() {
    Constant.backToPrev(context);
  }

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            getVerSpace(FetchPixels.getPixelHeight(40)),
            getSvgImage("exchange_idea.svg",
                height: FetchPixels.getPixelHeight(118),
                width: FetchPixels.getPixelHeight(118)),
            getVerSpace(FetchPixels.getPixelHeight(27)),
            getCustomFont("Price Alert Created!", 22, Colors.black, 1,
                fontWeight: FontWeight.w700),
            getVerSpace(FetchPixels.getPixelHeight(8)),
            getPaddingWidget(
              EdgeInsets.symmetric(horizontal: FetchPixels.getPixelHeight(20)),
              getMultilineCustomFont(
                  "You will receive a notification as soon as the coin reaches the price set by you.",
                  15,
                  Colors.black,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                  txtHeight: FetchPixels.getPixelHeight(1.3)),
            ),
            getVerSpace(FetchPixels.getPixelHeight(30)),
            getButton(context, blueColor, "Ok", Colors.white, () {
              backToPrev();
              backToPrev();
            }, 16,
                weight: FontWeight.w600,
                buttonHeight: FetchPixels.getPixelHeight(60),
                borderRadius:
                    BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                insetsGeometry: EdgeInsets.symmetric(
                    horizontal: FetchPixels.getPixelHeight(30))),
            getVerSpace(FetchPixels.getPixelHeight(40)),
          ],
        ),
      ),
    );
  }
}
