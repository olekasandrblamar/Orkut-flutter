import 'package:orkut/app/data/data_file.dart';
import 'package:orkut/app/models/model_currency.dart';
import 'package:orkut/app/models/model_price_alert.dart';
import 'package:orkut/app/routes/app_routes.dart';
import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/constant.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreatePriceAlert extends StatefulWidget {
  const CreatePriceAlert({Key? key}) : super(key: key);

  @override
  State<CreatePriceAlert> createState() => _CreatePriceAlertState();
}

class _CreatePriceAlertState extends State<CreatePriceAlert> {
  void backToPrev() {
    Constant.backToPrev(context);
  }

  var horSpace = FetchPixels.getPixelHeight(20);
  List<ModelCurrency> currencyLists = DataFile.currencyList;
  String selectCurrency = 'BitCoin';
  String image = "btc.svg";
  TextEditingController priceController = TextEditingController();
  int alertSelect = 1;
  String alerttype = "Price Rises To";
  int priceselect = 1;
  String priceType = "+2%";
  List<ModelPriceAlert> priceAlertLists = DataFile.priceAlertList;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(
                vertical: FetchPixels.getPixelHeight(30), horizontal: horSpace),
            child: getButton(
                context, blueColor, "Create Price alert", Colors.white, () {
              if (alertSelect == 1) {
                setState(() {
                  alerttype = "Price Rises To";
                });
              } else {
                setState(() {
                  alerttype = "Price Drops To";
                });
              }
              priceAlertLists.add(ModelPriceAlert(
                  image, selectCurrency, alerttype, priceController.text));
              Constant.sendToNext(context, Routes.alertCreateRoute);
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
                  gettoolbarMenu(
                    context,
                    "back.svg",
                    () {
                      backToPrev();
                    },
                    istext: true,
                    title: "Create Price Alert",
                    fontsize: 24,
                    weight: FontWeight.w700,
                    textColor: Colors.black,
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(35)),
                  Expanded(
                      flex: 1,
                      child: ListView(
                        primary: true,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          getCustomFont("Currency", 15, Colors.black, 1,
                              fontWeight: FontWeight.w600),
                          getVerSpace(FetchPixels.getPixelHeight(8)),
                          SizedBox(
                            height: FetchPixels.getPixelHeight(56),
                            child: DropdownButtonFormField(
                              iconEnabledColor: Colors.white,
                              iconDisabledColor: Colors.white,
                              hint: getCustomFont(
                                  "Select Currency", 15, textColor, 1,
                                  fontWeight: FontWeight.w400),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: FetchPixels.getPixelHeight(16)),
                                  filled: true,
                                  fillColor: Colors.white,
                                  suffixIcon: Container(
                                    padding: EdgeInsets.all(
                                        FetchPixels.getPixelHeight(16)),
                                    child: getSvgImage("arrow_bottom.svg",
                                        width: FetchPixels.getPixelHeight(24),
                                        height: FetchPixels.getPixelHeight(24)),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        FetchPixels.getPixelHeight(12)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          FetchPixels.getPixelHeight(12)),
                                      borderSide: BorderSide(
                                          color: borderColor,
                                          width:
                                              FetchPixels.getPixelHeight(1))),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          FetchPixels.getPixelHeight(12)),
                                      borderSide: BorderSide(
                                          color: borderColor,
                                          width:
                                              FetchPixels.getPixelHeight(1))),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          FetchPixels.getPixelHeight(12)),
                                      borderSide: BorderSide(
                                          color: borderColor,
                                          width: FetchPixels.getPixelHeight(1)))),
                              items: currencyLists.map((e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: Row(
                                    children: [
                                      getSvgImage(e.image ?? "",
                                          width: FetchPixels.getPixelHeight(24),
                                          height:
                                              FetchPixels.getPixelHeight(24)),
                                      getHorSpace(
                                          FetchPixels.getPixelHeight(10)),
                                      getCustomFont(
                                          e.name ?? '', 16, Colors.black, 1,
                                          fontWeight: FontWeight.w400),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (ModelCurrency? value) {
                                setState(() {
                                  selectCurrency = value!.name ?? "";
                                  image = value.image ?? "";
                                });
                              },
                            ),
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(25)),
                          getCustomFont("Alert Type", 15, Colors.black, 1,
                              fontWeight: FontWeight.w600),
                          getVerSpace(FetchPixels.getPixelHeight(8)),
                          Row(
                            children: [
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    alertSelect = 1;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: FetchPixels.getPixelHeight(56),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          FetchPixels.getPixelHeight(12)),
                                      border: Border.all(
                                          color: borderColor,
                                          width:
                                              FetchPixels.getPixelHeight(1))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      getSvgImage(
                                          alertSelect == 1
                                              ? 'active_radio.svg'
                                              : "inactive_radio.svg",
                                          height:
                                              FetchPixels.getPixelHeight(24),
                                          width:
                                              FetchPixels.getPixelHeight(24)),
                                      getHorSpace(
                                          FetchPixels.getPixelHeight(10)),
                                      getCustomFont(
                                          "Price Rises To", 16, Colors.black, 1,
                                          fontWeight: FontWeight.w400)
                                    ],
                                  ),
                                ),
                              )),
                              getHorSpace(horSpace),
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    alertSelect = 2;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: FetchPixels.getPixelHeight(56),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          FetchPixels.getPixelHeight(12)),
                                      border: Border.all(
                                          color: borderColor,
                                          width:
                                              FetchPixels.getPixelHeight(1))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      getSvgImage(
                                          alertSelect == 2
                                              ? 'active_radio.svg'
                                              : "inactive_radio.svg",
                                          height:
                                              FetchPixels.getPixelHeight(24),
                                          width:
                                              FetchPixels.getPixelHeight(24)),
                                      getHorSpace(
                                          FetchPixels.getPixelHeight(10)),
                                      getMultilineCustomFont(
                                          "Price Drops To"
                                          "",
                                          16,
                                          Colors.black,
                                          fontWeight: FontWeight.w400)
                                    ],
                                  ),
                                ),
                              ))
                            ],
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(25)),
                          getCustomFont("Add Price", 15, Colors.black, 1,
                              fontWeight: FontWeight.w600),
                          getVerSpace(FetchPixels.getPixelHeight(8)),
                          getDefaultTextFiledWithLabel(
                              context, "Price", priceController,
                              withprefix: false,
                              image: "message.svg",
                              isEnable: false,
                              height: FetchPixels.getPixelHeight(56),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ]),
                          getVerSpace(FetchPixels.getPixelHeight(14)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  getCustomFont(
                                      "Current Price: ", 15, textColor, 1,
                                      fontWeight: FontWeight.w400),
                                  getCustomFont(
                                      "\$5464.51", 15, Colors.black, 1,
                                      fontWeight: FontWeight.w400)
                                ],
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        priceselect = 1;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: priceselect == 1
                                              ? const Color(0xFFEBF0FF)
                                              : Colors.white,
                                          border: priceselect == 1
                                              ? null
                                              : Border.all(
                                                  color: borderColor,
                                                  width: FetchPixels
                                                      .getPixelHeight(1)),
                                          borderRadius: BorderRadius.circular(
                                              FetchPixels.getPixelHeight(12))),
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              FetchPixels.getPixelHeight(13),
                                          vertical:
                                              FetchPixels.getPixelHeight(4)),
                                      child: getCustomFont(
                                          "+2%",
                                          15,
                                          priceselect == 1
                                              ? blueColor
                                              : textColor,
                                          1,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  getHorSpace(FetchPixels.getPixelHeight(6)),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        priceselect = 2;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: priceselect == 2
                                              ? const Color(0xFFEBF0FF)
                                              : Colors.white,
                                          border: priceselect == 2
                                              ? null
                                              : Border.all(
                                                  color: borderColor,
                                                  width: FetchPixels
                                                      .getPixelHeight(1)),
                                          borderRadius: BorderRadius.circular(
                                              FetchPixels.getPixelHeight(12))),
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              FetchPixels.getPixelHeight(13),
                                          vertical:
                                              FetchPixels.getPixelHeight(4)),
                                      child: getCustomFont(
                                          "+5%",
                                          15,
                                          priceselect == 2
                                              ? blueColor
                                              : textColor,
                                          1,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  getHorSpace(FetchPixels.getPixelHeight(6)),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        priceselect = 3;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: priceselect == 3
                                              ? const Color(0xFFEBF0FF)
                                              : Colors.white,
                                          border: priceselect == 3
                                              ? null
                                              : Border.all(
                                                  color: borderColor,
                                                  width: FetchPixels
                                                      .getPixelHeight(1)),
                                          borderRadius: BorderRadius.circular(
                                              FetchPixels.getPixelHeight(12))),
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              FetchPixels.getPixelHeight(13),
                                          vertical:
                                              FetchPixels.getPixelHeight(4)),
                                      child: getCustomFont(
                                          "+2%",
                                          15,
                                          priceselect == 3
                                              ? blueColor
                                              : textColor,
                                          1,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
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
}
