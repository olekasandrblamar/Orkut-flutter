import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:orkut/app/models/model_portfolio.dart';
import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/constant.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/data_file.dart';
import '../../models/model_exchange.dart';
import '../converter/api.dart';
import '../converter/currency.dart';
import '../dialog/complete_dialog.dart';

class ExchangeScreen extends StatefulWidget {
  final Object? arguments;
  ExchangeScreen(this.arguments, {Key? key}) : super(key: key);

  @override
  State<ExchangeScreen> createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  void backToPrev() {
    Constant.backToPrev(context);
  }

  var horspace = FetchPixels.getPixelHeight(20);
  String dropdownValue = "USD";
  String dropdownValue2 = "BTC";
  String convertedAmount='' ;
  ModelPortfolio portfolio=    ModelPortfolio(1,"United States Dollar","USD","74.52","-0.24");
  ModelPortfolio portfolio2=         ModelPortfolio(2,"Bitcoin","BTC","54.52","-0.34");
  List<String> coins=[];
  List<ModelPortfolio> portfolioLists = DataFile.portfolioList;
  String? from;
  String? to;
  ExchangeModel? exchange;
  convert({required String? from, required String? to,}) async {
    // try {
    String url = "${ApiService.ENDPOINT}$from/$to";
    print(url);
    /// get the latest currency rate
    Response? resp = (await ApiService.getConvertedAmount(url));
    if (resp != null) {
      var respJson=jsonDecode(resp.body);
      print(respJson);
      exchange=ExchangeModel.fromJson(respJson);
      print(exchange!.rate);
      convertedAmount=exchange!.rate!.toString();
      setState(() {
      });
    }
  }
  getC() async{
    await convert(from: from, to: to,  );
  }
  @override
  initState() {
    super.initState();
    from = portfolio.currency;
    to = portfolio2.currency;
    getC();
        for (var v in portfolioLists) {
          coins.add(v.currency);
        }
  }
  checkFrom(newValue) async {
    for (var element in portfolioLists) {
      if (newValue == element.currency) {
        from = element.currency;
        portfolio = element;
      }
    }
    await(convert(from: from, to: to));
    setState(() {
      dropdownValue = newValue!;
    });
  }
  checkTo(newValue) async {
    for (var element in portfolioLists) {
      if (newValue == element.currency) {
        to = element.currency;
        portfolio2 = element;
      }
    }
    await(convert(from: from, to: to));
    setState(() {
      dropdownValue2 = newValue!;
    });
  }
  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: getPaddingWidget(
              EdgeInsets.symmetric(horizontal: horspace),
              Column(
                children: [
                  getVerSpace(horspace),
                  appBar(context),


                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  Expanded(
                      flex: 1,
                      child: ListView(
                        primary: true,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: shadowColor,
                                      blurRadius: 23,
                                      offset: const Offset(0, 10))
                                ],
                                borderRadius: BorderRadius.circular(
                                    FetchPixels.getPixelHeight(14))),
                            padding: EdgeInsets.only(
                                left: horspace,
                                right: horspace,
                                top: horspace,
                                bottom: horspace),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // getSvgImage(portfolio.currency!,
                                    //     width: FetchPixels.getPixelHeight(50),
                                    //     height: FetchPixels.getPixelHeight(50)),
                                    getHorSpace(FetchPixels.getPixelHeight(12)),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            DropdownButton<String>(
                                              value: dropdownValue,underline: SizedBox(),
                                              onChanged: (String? newValue) {
                                                checkFrom(newValue);
                                              },
                                              items: coins.map<DropdownMenuItem<String>>((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: getCustomFont(value, 15,
                                                      Colors.black, 1,
                                                      fontWeight: FontWeight.w600),
                                                );
                                              }).toList(),
                                            ),
                                            /*getCustomFont(portfolio.name!, 15,
                                                Colors.black, 1,
                                                fontWeight: FontWeight.w600),
                                            getHorSpace(
                                                FetchPixels.getPixelHeight(3)),
                                            getSvgImage("bottom.svg")*/
                                          ],
                                        ),
                                        getHorSpace(
                                            FetchPixels.getPixelHeight(3)),
                                        getCustomFont(
                                            portfolio.currency!.toString(), 15, subtextColor, 1,
                                            fontWeight: FontWeight.w400),
                                        getHorSpace(
                                            FetchPixels.getPixelHeight(5)),
                                        getCustomFont(
                                            "\$ 1.0" , 18, Colors.black, 1,
                                            fontWeight: FontWeight.w600),
                                      ],
                                    )
                                  ],
                                ),
                                Wrap(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFE7F9EF),
                                          borderRadius: BorderRadius.circular(
                                              FetchPixels.getPixelHeight(21))),
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                          FetchPixels.getPixelHeight(6),
                                          vertical:
                                          FetchPixels.getPixelHeight(1)),
                                      child: Row(
                                        children: [
                                          double.parse(portfolio.price!)>0 ?getSvgImage("up.svg"):getSvgImage("down.svg"),
                                          getHorSpace(
                                              FetchPixels.getPixelHeight(4)),
                                          getCustomFont(
                                              "${portfolio.price!}%", 13, successColor, 1,
                                              fontWeight: FontWeight.w400)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          getVerSpace(horspace),
                          getSvgImage("transfer.svg",
                              width: FetchPixels.getPixelHeight(50),
                              height: FetchPixels.getPixelHeight(50)),
                          getVerSpace(horspace),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: shadowColor,
                                      blurRadius: 23,
                                      offset: const Offset(0, 10))
                                ],
                                borderRadius: BorderRadius.circular(
                                    FetchPixels.getPixelHeight(14))),
                            padding: EdgeInsets.only(
                                left: horspace,
                                right: horspace,
                                top: horspace,
                                bottom: horspace),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // getSvgImage(portfolio2.currency!,
                                    //     width: FetchPixels.getPixelHeight(50),
                                    //     height: FetchPixels.getPixelHeight(50)),
                                    getHorSpace(FetchPixels.getPixelHeight(12)),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            DropdownButton<String>(
                                              value: dropdownValue2,
                                              onChanged: (String? newValue) {
                                                checkTo(newValue);

                                              },underline: SizedBox(),
                                              items: coins.map<DropdownMenuItem<String>>((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: getCustomFont(value, 15,
                                                      Colors.black, 1,
                                                      fontWeight: FontWeight.w600),
                                                );
                                              }).toList(),
                                            ),
                                            /*getCustomFont(portfolio2.name!, 15,
                                                Colors.black, 1,
                                                fontWeight: FontWeight.w600),
                                            getHorSpace(
                                                FetchPixels.getPixelHeight(3)),
                                            getSvgImage("bottom.svg")*/
                                          ],
                                        ),
                                        getHorSpace(
                                            FetchPixels.getPixelHeight(3)),
                                        getCustomFont(
                                            portfolio2.currency!.toString(), 15, subtextColor, 1,
                                            fontWeight: FontWeight.w400),
                                        getHorSpace(
                                            FetchPixels.getPixelHeight(5)),
                                        getCustomFont(
                                            "\$${convertedAmount!}", 18, Colors.black, 1,
                                            fontWeight: FontWeight.w600),
                                      ],
                                    )
                                  ],
                                ),
                                Wrap(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFE7F9EF),
                                          borderRadius: BorderRadius.circular(
                                              FetchPixels.getPixelHeight(21))),
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                          FetchPixels.getPixelHeight(6),
                                          vertical:
                                          FetchPixels.getPixelHeight(1)),
                                      child: Row(
                                        children: [
                                          double.parse(portfolio2.price!)>0 ?getSvgImage("up.svg"):getSvgImage("down.svg"),
                                          getHorSpace(
                                              FetchPixels.getPixelHeight(4)),
                                          getCustomFont(
                                              "${portfolio2.price!}%", 13, successColor, 1,
                                              fontWeight: FontWeight.w400)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          /*Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: shadowColor,
                                      blurRadius: 23,
                                      offset: const Offset(0, 10))
                                ],
                                borderRadius: BorderRadius.circular(
                                    FetchPixels.getPixelHeight(14))),
                            padding: EdgeInsets.only(
                                left: horspace,
                                right: horspace,
                                top: horspace,
                                bottom: horspace),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getSvgImage("usd.svg",
                                        width: FetchPixels.getPixelHeight(50),
                                        height: FetchPixels.getPixelHeight(50)),
                                    getHorSpace(FetchPixels.getPixelHeight(12)),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            getCustomFont(
                                                "United States Dollar",
                                                15,
                                                Colors.black,
                                                1,
                                                fontWeight: FontWeight.w600),
                                            getHorSpace(
                                                FetchPixels.getPixelHeight(3)),
                                            getSvgImage("bottom.svg")
                                          ],
                                        ),
                                        getHorSpace(
                                            FetchPixels.getPixelHeight(3)),
                                        getCustomFont(
                                            "USD", 15, subtextColor, 1,
                                            fontWeight: FontWeight.w400),
                                        getHorSpace(
                                            FetchPixels.getPixelHeight(5)),
                                        getCustomFont(
                                            "\$${exchange?.info?.rate??'loading'}", 18, Colors.black, 1,
                                            fontWeight: FontWeight.w600),
                                      ],
                                    )
                                  ],
                                ),
                                Wrap(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFE7F9EF),
                                          borderRadius: BorderRadius.circular(
                                              FetchPixels.getPixelHeight(21))),
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              FetchPixels.getPixelHeight(6),
                                          vertical:
                                              FetchPixels.getPixelHeight(1)),
                                      child: Row(
                                        children: [
                                          getSvgImage("down.svg"),
                                          getHorSpace(
                                              FetchPixels.getPixelHeight(4)),
                                          getCustomFont(
                                              "1.3%", 13, successColor, 1,
                                              fontWeight: FontWeight.w400)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),*/
                          getVerSpace(FetchPixels.getPixelHeight(40)),
                          getButton(
                              context, blueColor, "Exchange", Colors.white, () {

                            showDialog(
                              builder: (context) {
                                return const CompleteDialog();
                              },
                              context: context,
                              barrierDismissible: true,
                            );
                          }, 16,
                              weight: FontWeight.w600,
                              borderRadius: BorderRadius.circular(
                                  FetchPixels.getPixelHeight(15)),
                              buttonHeight: FetchPixels.getPixelHeight(60))
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

  Widget appBar(BuildContext context) {
    return gettoolbarMenu(context, "back.svg", () {
      backToPrev();
    },
        istext: true,
        title: "Exchange",
        fontsize: 24,
        weight: FontWeight.w400,
        textColor: Colors.black);
  }
}
