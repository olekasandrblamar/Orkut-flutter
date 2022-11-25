import 'package:orkut/app/data/data_file.dart';
import 'package:orkut/app/routes/app_routes.dart';
import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/constant.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/material.dart';

import '../../models/intro_model.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  void backClick() {
    Constant.backToPrev(context);
  }

  ValueNotifier selectedPage = ValueNotifier(0);
  final _controller = PageController();

  List<ModelIntro> introLists = DataFile.introList;
  int select = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Stack(
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: FetchPixels.getPixelHeight(512),
                            color: introLists[select].color,
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.only(
                                top: FetchPixels.getPixelHeight(44),
                                bottom: FetchPixels.getPixelHeight(131.72)),
                          ),
                        ],
                      ),
                      Positioned(
                          top: FetchPixels.getPixelHeight(431),
                          left: FetchPixels.getPixelHeight(20),
                          right: FetchPixels.getPixelHeight(20),
                          child: Container(
                            height: FetchPixels.getPixelHeight(392),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    FetchPixels.getPixelHeight(20)),
                                boxShadow: [
                                  BoxShadow(
                                      color: shadowColor,
                                      blurRadius: 23,
                                      offset: const Offset(0, 10))
                                ]),
                          ))
                    ],
                  ),
                  PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: _controller,
                    onPageChanged: (value) {
                      selectedPage.value = value;
                      setState(() {
                        select = value;
                      });
                    },
                    itemCount: introLists.length,
                    itemBuilder: (context, index) {
                      ModelIntro introModel = introLists[index];
                      return Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: FetchPixels.getPixelHeight(512),
                                alignment: Alignment.topCenter,
                                padding: EdgeInsets.only(
                                    top: FetchPixels.getPixelHeight(44),
                                    bottom: FetchPixels.getPixelHeight(131.72)),
                                child: getAssetImage(introModel.image ?? ""),
                              )
                            ],
                          ),
                          Positioned(
                              top: FetchPixels.getPixelHeight(431),
                              left: FetchPixels.getPixelHeight(20),
                              right: FetchPixels.getPixelHeight(20),
                              child: SizedBox(
                                  height: FetchPixels.getPixelHeight(392),
                                  child: Column(
                                    children: [
                                      getVerSpace(
                                          FetchPixels.getPixelHeight(40)),
                                      getCustomFont(introModel.title ?? "", 24,
                                          Colors.black, 1,
                                          fontWeight: FontWeight.w700),
                                      getVerSpace(
                                          FetchPixels.getPixelHeight(18)),
                                      getPaddingWidget(
                                        EdgeInsets.symmetric(
                                            horizontal:
                                                FetchPixels.getPixelHeight(30)),
                                        getMultilineCustomFont(
                                            introModel.discription ?? "",
                                            16,
                                            Colors.black,
                                            fontWeight: FontWeight.w400,
                                            textAlign: TextAlign.center,
                                            txtHeight:
                                                FetchPixels.getPixelHeight(
                                                    1.3)),
                                      ),

                                      // getVerSpace(
                                      //     FetchPixels.getPixelHeight(30)),
                                    ],
                                  ))),
                        ],
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            introLists.length,
                            (position) {
                              return getPaddingWidget(
                                  EdgeInsets.symmetric(
                                      horizontal:
                                          FetchPixels.getPixelHeight(5)),
                                  getSvgImage(position == select
                                      ? "selected_dot.svg"
                                      : "dot.svg"));
                            },
                          ),
                        ),
                        getVerSpace(FetchPixels.getPixelHeight(38.12)),
                        getButton(
                            context,
                            blueColor,
                            select == 2 ? "Get Started" : 'Next',
                            Colors.white, () {
                          if (select <= 1) {
                            setState(() {
                              select = select + 1;
                            });
                          } else {
                            Constant.sendToNext(context, Routes.loginRoute);
                          }
                          _controller.animateToPage(select,
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInSine);
                        }, 16,
                            weight: FontWeight.w600,
                            buttonHeight: FetchPixels.getPixelHeight(60),
                            insetsGeometry: EdgeInsets.symmetric(
                                horizontal: FetchPixels.getPixelWidth(50)),
                            borderRadius: BorderRadius.circular(
                                FetchPixels.getPixelHeight(15))),
                        getVerSpace(FetchPixels.getPixelHeight(30)),
                        GestureDetector(
                          onTap: () {
                            Constant.sendToNext(context, Routes.loginRoute);
                          },
                          child: getCustomFont("Skip", 16, skipColor, 1,
                              fontWeight: FontWeight.w400),
                        ),
                        getVerSpace(FetchPixels.getPixelHeight(84))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          backClick();
          return false;
        });
  }
}
