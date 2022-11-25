import 'package:orkut/app/data/data_file.dart';
import 'package:orkut/app/models/model_item.dart';
import 'package:orkut/app/view/drawer/mydrawer.dart';
import 'package:orkut/app/view/home/tab/tab_offers.dart';
import 'package:orkut/app/view/home/tab/tab_timeline.dart';
import 'package:orkut/app/view/home/tab/tab_home.dart';
import 'package:orkut/app/view/home/tab/tab_profile.dart';
import 'package:orkut/app/view/offer/offer_list.dart';
import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/constant.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:flutter/material.dart';
import '../../../base/widget_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int position = 0;

  void close() {
    Constant.closeApp();
  }

  List<Widget> tabList = [
    const TabHome(),
    const OfferListScreen(),
    const TabTimeline(),
    const TabProfile(),
  ];
  List<ModelItem> itemLists = DataFile.itemList;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: tabList[position],
          ),
          bottomNavigationBar: bottomNavigationBar(),
        ),
        onWillPop: () async {
          close();
          return false;
        });
  }

  Container bottomNavigationBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: FetchPixels.getPixelHeight(20)),
      height: FetchPixels.getPixelHeight(80),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: shadowColor, blurRadius: 23, offset: const Offset(0, -2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List<Widget>.generate(itemLists.length, (index) {
          ModelItem modelItem = itemLists[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                position = index;
              });
            },
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(seconds: 4),
                  height: FetchPixels.getPixelHeight(55),
                  width: FetchPixels.getPixelHeight(55),
                  decoration: position == index
                      ? BoxDecoration(
                          color: position == index
                              ? blueColor
                              : Colors.transparent,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: shadowColor,
                              blurRadius: 18,
                              offset: const Offset(
                                0,
                                9,
                              ),
                            ),
                          ],
                        )
                      : null,
                  child: AnimatedPadding(
                    duration: const Duration(
                      seconds: 4,
                    ),
                    padding: EdgeInsets.all(FetchPixels.getPixelHeight(11)),
                    child: getSvgImage(modelItem.image ?? "",
                        color: position == index ? Colors.white : null),
                  ),
                ),
                AnimatedCrossFade(
                  crossFadeState: position == index
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 500),
                  firstChild: Container(),
                  secondChild: AnimatedContainer(
                    duration: const Duration(
                      seconds: 4,
                    ),
                    child: Row(
                      children: [
                        getHorSpace(FetchPixels.getPixelHeight(8)),
                        getCustomFont(
                          modelItem.name ?? '',
                          16,
                          Colors.black,
                          1,
                          fontWeight: FontWeight.w500,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
