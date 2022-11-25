import 'package:orkut/app/data/data_file.dart';
import 'package:orkut/app/models/model_portfolio.dart';
import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class TabTransaction extends StatefulWidget {
  const TabTransaction({Key? key}) : super(key: key);

  @override
  State<TabTransaction> createState() => _TabTransactionState();
}

class _TabTransactionState extends State<TabTransaction> {
  var horspace = FetchPixels.getPixelHeight(20);
  List<ModelPortfolio> portfolioLists = DataFile.portfolioList;
  bool isSwitch = true;

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return Column(
      children: [
        getVerSpace(FetchPixels.getPixelHeight(14)),
        appBar(context),
        getVerSpace(FetchPixels.getPixelHeight(39)),
        Expanded(
            flex: 1,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: AnimationLimiter(
                child: getPaddingWidget(
                  EdgeInsets.symmetric(horizontal: horspace),
                  Column(
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 200),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        horizontalOffset: 44.0,
                        child: FadeInAnimation(child: widget),
                      ),
                      children: [
                        currentValueWidget(),
                        getVerSpace(horspace),
                        totalBalanceWidget(context),
                        getVerSpace(horspace),
                        priceAlertWidget(),
                        getVerSpace(FetchPixels.getPixelHeight(24)),
                        transactionList()
                      ],
                    ),
                  ),
                ),
              ),
            ))
      ],
    );
  }

  Container priceAlertWidget() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: shadowColor, blurRadius: 23, offset: const Offset(0, 7))
          ],
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14))),
      height: FetchPixels.getPixelHeight(71),
      padding: EdgeInsets.symmetric(
        horizontal: FetchPixels.getPixelHeight(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getCustomFont("Portfolio price alert", 15, Colors.black, 1,
              fontWeight: FontWeight.w600),
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

  Container totalBalanceWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horspace, vertical: horspace),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: shadowColor, blurRadius: 23, offset: const Offset(0, 7))
          ],
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14))),
      child: Column(
        children: [
          getCustomFont("Total Balance", 15, Colors.black, 1,
              fontWeight: FontWeight.w400),
          getVerSpace(FetchPixels.getPixelHeight(6)),
          getCustomFont("\$0.00", 18, blueColor, 1,
              fontWeight: FontWeight.w600),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          getButtonWithIcon(
              context, buttonColor, "Deposit INR", Colors.black, () {}, 15,
              weight: FontWeight.w400,
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(12)),
              buttonHeight: FetchPixels.getPixelHeight(48),
              sufixIcon: true,
              suffixImage: "arrow_right.svg")
        ],
      ),
    );
  }

  Container currentValueWidget() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: shadowColor, blurRadius: 23, offset: const Offset(0, 7))
          ],
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14))),
      child: Column(
        children: [
          getPaddingWidget(
            EdgeInsets.symmetric(horizontal: FetchPixels.getPixelHeight(35)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    getVerSpace(FetchPixels.getPixelHeight(20)),
                    getCustomFont("Current value", 15, textColor, 1,
                        fontWeight: FontWeight.w400),
                    getVerSpace(FetchPixels.getPixelHeight(6)),
                    getCustomFont("\$25.56", 18, Colors.black, 1,
                        fontWeight: FontWeight.w600),
                    getVerSpace(FetchPixels.getPixelHeight(20)),
                  ],
                ),
                Container(
                  width: FetchPixels.getPixelHeight(1),
                  color: deviderColor,
                  height: FetchPixels.getPixelHeight(95),
                ),
                Column(
                  children: [
                    getVerSpace(FetchPixels.getPixelHeight(20)),
                    getCustomFont("Invested value", 15, textColor, 1,
                        fontWeight: FontWeight.w400),
                    getVerSpace(FetchPixels.getPixelHeight(6)),
                    getCustomFont("\$30.86", 18, Colors.black, 1,
                        fontWeight: FontWeight.w600),
                    getVerSpace(FetchPixels.getPixelHeight(20)),
                  ],
                ),
              ],
            ),
          ),
          Container(height: FetchPixels.getPixelHeight(1), color: deviderColor),
          getVerSpace(FetchPixels.getPixelHeight(19)),
          getPaddingWidget(
            EdgeInsets.symmetric(horizontal: horspace),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getCustomFont("Gain / Loss", 15, textColor, 1,
                    fontWeight: FontWeight.w400),
                Wrap(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFFE7F9EF),
                          borderRadius: BorderRadius.circular(
                              FetchPixels.getPixelHeight(21))),
                      padding: EdgeInsets.symmetric(
                          horizontal: FetchPixels.getPixelHeight(6),
                          vertical: FetchPixels.getPixelHeight(1)),
                      child: Row(
                        children: [
                          getSvgImage("down.svg"),
                          getHorSpace(FetchPixels.getPixelHeight(4)),
                          getCustomFont('23.4%', 15, successColor, 1,
                              fontWeight: FontWeight.w400)
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          getVerSpace(FetchPixels.getPixelHeight(20)),
        ],
      ),
    );
  }

  ListView transactionList() {
    return ListView.builder(
      primary: true,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: portfolioLists.length,
      itemBuilder: (context, index) {
        ModelPortfolio modelPortfolio = portfolioLists[index];
        return Container(
          margin: EdgeInsets.only(bottom: FetchPixels.getPixelHeight(20)),
          padding: EdgeInsets.only(
              left: FetchPixels.getPixelHeight(16),
              right: FetchPixels.getPixelHeight(16),
              top: FetchPixels.getPixelHeight(16),
              bottom: FetchPixels.getPixelHeight(16)),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: shadowColor,
                    blurRadius: 23,
                    offset: const Offset(0, 10))
              ],
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(14))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  getHorSpace(FetchPixels.getPixelHeight(12)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getCustomFont(
                          modelPortfolio.balance ?? "", 15, Colors.black, 1,
                          fontWeight: FontWeight.w400),
                      getVerSpace(FetchPixels.getPixelHeight(4)),
                      getCustomFont(
                          modelPortfolio.price ?? "",
                          15,
                          modelPortfolio.price![0] == "-"
                              ? errorColor
                              : successColor,
                          1,
                          fontWeight: FontWeight.w400)
                    ],
                  )
                ],
              ),
              getCustomFont("\$${modelPortfolio.price}", 18, Colors.black, 1,
                  fontWeight: FontWeight.w600)
            ],
          ),
        );
      },
    );
  }

  Widget appBar(BuildContext context) {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: horspace),
      gettoolbarMenu(context, "back.svg", () {},
          istext: true,
          title: "Transaction",
          fontsize: 24,
          weight: FontWeight.w500,
          textColor: Colors.black,
          isleftimage: false,
          isrightimage: true,
          rightimage: "more.svg"),
    );
  }
}
