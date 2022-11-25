import 'package:orkut/app/routes/app_routes.dart';
import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/constant.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/material.dart';

class AlertCreateScreen extends StatefulWidget {
  const AlertCreateScreen({Key? key}) : super(key: key);

  @override
  State<AlertCreateScreen> createState() => _AlertCreateScreenState();
}

class _AlertCreateScreenState extends State<AlertCreateScreen> {
  void backToPrev() {
    Constant.backToPrev(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        backToPrev();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Container(
            padding:
                EdgeInsets.symmetric(vertical: FetchPixels.getPixelHeight(18)),
            child: GestureDetector(
              onTap: () {
                backToPrev();
              },
              child: getSvgImage("close.svg"),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getSvgImage("price_check.svg"),
              getVerSpace(FetchPixels.getPixelHeight(30)),
              getCustomFont("Price Alert Created!", 22, Colors.black, 1,
                  fontWeight: FontWeight.w700, textAlign: TextAlign.center),
              getVerSpace(FetchPixels.getPixelHeight(10)),
              getPaddingWidget(
                EdgeInsets.symmetric(
                    horizontal: FetchPixels.getPixelHeight(40)),
                getMultilineCustomFont(
                    "You will receive a notification as soon as the coin reaches the price set by you.",
                    15,
                    Colors.black,
                    fontWeight: FontWeight.w400,
                    txtHeight: FetchPixels.getPixelHeight(1.5),
                    textAlign: TextAlign.center),
              ),
              getVerSpace(FetchPixels.getPixelHeight(40)),
              getPaddingWidget(
                EdgeInsets.symmetric(
                    horizontal: FetchPixels.getPixelHeight(50)),
                getButton(context, blueColor, "Ok", Colors.white, () {
                  Constant.sendToNext(context, Routes.priceAlertRoute);
                }, 16,
                    weight: FontWeight.w600,
                    buttonHeight: FetchPixels.getPixelHeight(60),
                    borderRadius:
                        BorderRadius.circular(FetchPixels.getPixelHeight(15))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
