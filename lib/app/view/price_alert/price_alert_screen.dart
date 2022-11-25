import 'package:orkut/app/data/data_file.dart';
import 'package:orkut/app/models/model_price_alert.dart';
import 'package:orkut/app/routes/app_routes.dart';
import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/constant.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/material.dart';

class PriceAlertScreen extends StatefulWidget {
  const PriceAlertScreen({Key? key}) : super(key: key);

  @override
  State<PriceAlertScreen> createState() => _PriceAlertScreenState();
}

class _PriceAlertScreenState extends State<PriceAlertScreen> {
  void backToPrev() {
    Constant.sendToNext(context, Routes.settingRoute);
  }

  var horSpace = FetchPixels.getPixelHeight(20);
  List<ModelPriceAlert> priceAlertLists = DataFile.priceAlertList;

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(
                vertical: FetchPixels.getPixelHeight(30), horizontal: horSpace),
            child: getButton(
                context, blueColor, "Create Price alert", Colors.white, () {
              Navigator.pushNamed(context, Routes.createPriceAlertRoute)
                  .then((value) {
                setState(() {});
              });
            }, 16,
                weight: FontWeight.w600,
                borderRadius:
                    BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                buttonHeight: FetchPixels.getPixelHeight(60)),
          ),
          body: SafeArea(
            child: getPaddingWidget(
              EdgeInsets.symmetric(horizontal: horSpace),
              Column(
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(14)),
                  appBar(context),
                  getVerSpace(FetchPixels.getPixelHeight(29)),
                  priceAlertList()
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

  Expanded priceAlertList() {
    return Expanded(
        flex: 1,
        child: ListView.builder(
          primary: true,
          shrinkWrap: true,
          itemCount: priceAlertLists.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            ModelPriceAlert modelPriceAlert = priceAlertLists[index];
            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(
                                FetchPixels.getPixelHeight(16)))),
                    builder: (context) {
                      return Wrap(children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  FetchPixels.getPixelHeight(16)),
                              color: Colors.white),
                          padding: EdgeInsets.symmetric(
                              horizontal: FetchPixels.getPixelHeight(20)),
                          child: Column(
                            children: [
                              getVerSpace(FetchPixels.getPixelHeight(30)),
                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(
                                                FetchPixels.getPixelHeight(
                                                    14))),
                                        boxShadow: [
                                          BoxShadow(
                                              color: shadowColor,
                                              blurRadius: 23,
                                              offset: const Offset(0, 7))
                                        ]),
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            FetchPixels.getPixelHeight(16),
                                        vertical:
                                            FetchPixels.getPixelHeight(16)),
                                    child: Row(
                                      children: [
                                        getSvgImage(modelPriceAlert.image ?? "",
                                            width:
                                                FetchPixels.getPixelHeight(36),
                                            height:
                                                FetchPixels.getPixelHeight(36)),
                                        getHorSpace(
                                            FetchPixels.getPixelHeight(10)),
                                        getCustomFont(
                                            modelPriceAlert.name ?? "",
                                            15,
                                            Colors.black,
                                            1,
                                            fontWeight: FontWeight.w600)
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            FetchPixels.getPixelHeight(16),
                                        vertical:
                                            FetchPixels.getPixelHeight(16)),
                                    decoration: BoxDecoration(
                                        color: priceColor,
                                        borderRadius: BorderRadius.vertical(
                                            bottom: Radius.circular(
                                                FetchPixels.getPixelHeight(
                                                    14)))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        getCustomFont(
                                            modelPriceAlert.type ?? "",
                                            15,
                                            Colors.black,
                                            1,
                                            fontWeight: FontWeight.w400),
                                        getCustomFont(
                                            "\$${modelPriceAlert.price}",
                                            15,
                                            blueColor,
                                            1,
                                            fontWeight: FontWeight.w600)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              getVerSpace(FetchPixels.getPixelHeight(20)),
                              getButton(context, const Color(0xFFFEF0F0),
                                  "Delete", errorColor, () {
                                priceAlertLists.removeAt(index);
                                Constant.backToPrev(context);
                                setState(() {});
                              }, 16,
                                  weight: FontWeight.w600,
                                  buttonHeight: FetchPixels.getPixelHeight(60),
                                  borderRadius: BorderRadius.circular(
                                      FetchPixels.getPixelHeight(16))),
                              getVerSpace(FetchPixels.getPixelHeight(43)),
                            ],
                          ),
                        )
                      ]);
                    },
                    context: context);
              },
              child: Container(
                margin: EdgeInsets.only(bottom: FetchPixels.getPixelHeight(20)),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(
                                  FetchPixels.getPixelHeight(14))),
                          boxShadow: [
                            BoxShadow(
                                color: shadowColor,
                                blurRadius: 23,
                                offset: const Offset(0, 7))
                          ]),
                      padding: EdgeInsets.symmetric(
                          horizontal: FetchPixels.getPixelHeight(16),
                          vertical: FetchPixels.getPixelHeight(16)),
                      child: Row(
                        children: [
                          getSvgImage(modelPriceAlert.image ?? "",
                              width: FetchPixels.getPixelHeight(36),
                              height: FetchPixels.getPixelHeight(36)),
                          getHorSpace(FetchPixels.getPixelHeight(10)),
                          getCustomFont(
                              modelPriceAlert.name ?? "", 15, Colors.black, 1,
                              fontWeight: FontWeight.w600)
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: FetchPixels.getPixelHeight(16),
                          vertical: FetchPixels.getPixelHeight(16)),
                      decoration: BoxDecoration(
                          color: priceColor,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(
                                  FetchPixels.getPixelHeight(14)))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          getCustomFont(
                              modelPriceAlert.type ?? "", 15, Colors.black, 1,
                              fontWeight: FontWeight.w400),
                          getCustomFont(
                              "\$${modelPriceAlert.price}", 15, blueColor, 1,
                              fontWeight: FontWeight.w600)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget appBar(BuildContext context) {
    return gettoolbarMenu(
      context,
      "back.svg",
      () {
        backToPrev();
      },
      istext: true,
      title: "Price Alert",
      fontsize: 24,
      weight: FontWeight.w700,
      textColor: Colors.black,
    );
  }
}
