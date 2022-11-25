import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orkut/app/routes/app_routes.dart';
import 'package:orkut/base/constant.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../base/color_data.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  void backToPrev() {
    // Constant.backToPrev(context);
    Constant.sendToNext(context, Routes.homeScreenRoute);
  }

  var horSpace = FetchPixels.getPixelHeight(20);
  bool isSwitch = true;

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: getPaddingWidget(
              EdgeInsets.symmetric(horizontal: horSpace),
              Column(
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(14)),
                  appBar(context),
                  getVerSpace(FetchPixels.getPixelHeight(39)),
                  Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: AnimationLimiter(
                          child: Column(
                            children: AnimationConfiguration.toStaggeredList(
                              duration: const Duration(milliseconds: 200),
                              childAnimationBuilder: (widget) => SlideAnimation(
                                horizontalOffset: 44.0,
                                child: FadeInAnimation(child: widget),
                              ),
                              children: [
                                priceAlertButton(context),
                                getVerSpace(horSpace),
                                portfolioPriceAlertButton(),
                                getVerSpace(horSpace),
                                referAndEarnButton(),
                                getVerSpace(horSpace),
                                notificationButton(),
                                getVerSpace(horSpace),
                                helpButton(context),
                                getVerSpace(horSpace),
                                privacyButton(context),
                                getVerSpace(horSpace),
                                rateUsButton()
                              ],
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          backToPrev();
          return false;
        });
  }

  GestureDetector rateUsButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: FetchPixels.getPixelHeight(16),
            vertical: FetchPixels.getPixelHeight(16)),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: shadowColor,
                  blurRadius: 23,
                  offset: const Offset(0, 7))
            ],
            borderRadius:
                BorderRadius.circular(FetchPixels.getPixelHeight(12))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                getSvgImage("shield_check.svg"),
                getHorSpace(FetchPixels.getPixelHeight(16)),
                getCustomFont("Rate us", 15, Colors.black, 1,
                    fontWeight: FontWeight.w500)
              ],
            ),
            getSvgImage("arrow_right.svg")
          ],
        ),
      ),
    );
  }

  GestureDetector privacyButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Constant.sendToNext(context, Routes.privacyScreenroute);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: FetchPixels.getPixelHeight(16),
            vertical: FetchPixels.getPixelHeight(16)),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: shadowColor,
                  blurRadius: 23,
                  offset: const Offset(0, 7))
            ],
            borderRadius:
                BorderRadius.circular(FetchPixels.getPixelHeight(12))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                getSvgImage("shield_check.svg"),
                getHorSpace(FetchPixels.getPixelHeight(16)),
                getCustomFont("Terms & Privacy", 15, Colors.black, 1,
                    fontWeight: FontWeight.w500)
              ],
            ),
            getSvgImage("arrow_right.svg")
          ],
        ),
      ),
    );
  }

  GestureDetector helpButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Constant.sendToNext(context, Routes.helpScreenRoute);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: FetchPixels.getPixelHeight(16),
            vertical: FetchPixels.getPixelHeight(16)),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: shadowColor,
                  blurRadius: 23,
                  offset: const Offset(0, 7))
            ],
            borderRadius:
                BorderRadius.circular(FetchPixels.getPixelHeight(12))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                getSvgImage("info.svg"),
                getHorSpace(FetchPixels.getPixelHeight(16)),
                getCustomFont("Help & Support", 15, Colors.black, 1,
                    fontWeight: FontWeight.w500)
              ],
            ),
            getSvgImage("arrow_right.svg")
          ],
        ),
      ),
    );
  }

 GestureDetector notificationButton() {
    return
      GestureDetector(
        onTap: () {
          AlertDialog alert = AlertDialog(
            title: Icon(FontAwesomeIcons.question),
            content: getCustomFont("Coming soon", 14, Colors.black, 1),
          );

          // show the dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
    },
    child: Container(
      padding: EdgeInsets.symmetric(
          horizontal: FetchPixels.getPixelHeight(16),
          vertical: FetchPixels.getPixelHeight(16)),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: shadowColor, blurRadius: 23, offset: const Offset(0, 7))
          ],
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              getSvgImage("notification.svg"),
              getHorSpace(FetchPixels.getPixelHeight(16)),
              getCustomFont("Notifications", 15, Colors.black, 1,
                  fontWeight: FontWeight.w500)
            ],
          ),
          getSvgImage("arrow_right.svg")
        ],
      ),
    ),
      );
  }

  GestureDetector referAndEarnButton() {
    return
      GestureDetector(
        onTap: () {
          AlertDialog alert = AlertDialog(
            title: Icon(FontAwesomeIcons.question),
            content: getCustomFont("Coming soon", 14, Colors.black, 1),
          );

          // show the dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
    },
    child:Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: shadowColor, blurRadius: 23, offset: const Offset(0, 7))
          ],
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12))),
      padding: EdgeInsets.symmetric(
          horizontal: FetchPixels.getPixelHeight(16),
          vertical: FetchPixels.getPixelHeight(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getSvgImage("refer_earn.svg"),
                getHorSpace(FetchPixels.getPixelHeight(16)),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getCustomFont("Refer & Earn", 15, Colors.black, 1,
                          fontWeight: FontWeight.w500),
                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      getMultilineCustomFont(
                          "Get up to \$162 per referral", 15, textColor,
                          fontWeight: FontWeight.w400,
                          txtHeight: FetchPixels.getPixelHeight(1.3))
                    ],
                  ),
                )
              ],
            ),
          ),
          getSvgImage("arrow_right.svg")
        ],
      ),
    ),
      );
  }

  Container portfolioPriceAlertButton() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: shadowColor, blurRadius: 23, offset: const Offset(0, 7))
          ],
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12))),
      padding: EdgeInsets.symmetric(
          horizontal: FetchPixels.getPixelHeight(16),
          vertical: FetchPixels.getPixelHeight(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getSvgImage("price_alert.svg"),
                getHorSpace(FetchPixels.getPixelHeight(16)),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getCustomFont(
                          "Portfolio price alert", 15, Colors.black, 1,
                          fontWeight: FontWeight.w500),
                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      getMultilineCustomFont(
                          "Get price alerts for all coins on your portfolio",
                          15,
                          textColor,
                          fontWeight: FontWeight.w400,
                          txtHeight: FetchPixels.getPixelHeight(1.3))
                    ],
                  ),
                )
              ],
            ),
          ),
          CupertinoSwitch(
            value: isSwitch,
            onChanged: (value) {
              setState(() {
                isSwitch = value;
              });
            },
            activeColor: blueColor,
          )
        ],
      ),
    );
  }

  GestureDetector priceAlertButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AlertDialog alert = AlertDialog(
          title: Icon(FontAwesomeIcons.question),
          content: getCustomFont("Coming soon", 14, Colors.black, 1),
        );

        // show the dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: shadowColor,
                  blurRadius: 23,
                  offset: const Offset(0, 7))
            ],
            borderRadius:
                BorderRadius.circular(FetchPixels.getPixelHeight(12))),
        padding: EdgeInsets.symmetric(
            horizontal: FetchPixels.getPixelHeight(16),
            vertical: FetchPixels.getPixelHeight(16)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getSvgImage("price_alert.svg"),
                  getHorSpace(FetchPixels.getPixelHeight(16)),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getCustomFont("Price Alerts", 15, Colors.black, 1,
                            fontWeight: FontWeight.w500),
                        getVerSpace(FetchPixels.getPixelHeight(5)),
                        getMultilineCustomFont(
                            "Create customised price alerts", 15, textColor,
                            fontWeight: FontWeight.w400,
                            txtHeight: FetchPixels.getPixelHeight(1.3))
                      ],
                    ),
                  )
                ],
              ),
            ),
            getSvgImage("arrow_right.svg")
          ],
        ),
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return gettoolbarMenu(
      context,
      "back.svg",
      () {
        backToPrev();
      },
      istext: true,
      title: "Settings",
      fontsize: 24,
      weight: FontWeight.w700,
      textColor: Colors.black,
    );
  }
}
