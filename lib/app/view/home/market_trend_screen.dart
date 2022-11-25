import 'dart:convert';
import 'dart:developer';

import 'package:orkut/app/models/model_trend.dart';
import 'package:orkut/app/routes/app_routes.dart';
import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/constant.dart';
import 'package:orkut/base/pref_data.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import '../../data/data_file.dart';
import '../../models/coin_list.dart';

class MarketTrendScreen extends StatefulWidget {
  const MarketTrendScreen({Key? key}) : super(key: key);

  @override
  State<MarketTrendScreen> createState() => _MarketTrendScreenState();
}

class _MarketTrendScreenState extends State<MarketTrendScreen> {
  void backToPrev() {
    Constant.backToPrev(context);
  }

  var horspace = FetchPixels.getPixelHeight(20);
  TextEditingController searchController = TextEditingController();

  List<ModelTrend> newTrendList = List.from(DataFile.trendList);

  onItemChanged(String value) {
    setState(() {
      newTrendList = DataFile.trendList
          .where((string) =>
              string.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                getVerSpace(FetchPixels.getPixelHeight(20)),
                appBar(context),
                getVerSpace(FetchPixels.getPixelHeight(30)),
                getPaddingWidget(
                  EdgeInsets.symmetric(horizontal: horspace),
                  Container(
                    alignment: Alignment.center,
                    height: FetchPixels.getPixelHeight(49),
                    decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(
                            FetchPixels.getPixelHeight(16))),
                    child: getRichText("Market ", Colors.black, FontWeight.w400,
                        16, "", blueColor, FontWeight.w600, 16, "in last 24h"),
                  ),
                ),
                getVerSpace(FetchPixels.getPixelHeight(20)),
                Expanded(
                  child: StreamBuilder<CoinList>(
                      stream: getTrendingCoins(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        if (snapshot.hasError) {
                          return const Text('Error!');
                        } else {
                          return marketTrendList(snapshot.data!.coins!);
                        }
                      }),
                )
              ],
            ),
          ),
        ),
        onWillPop: () async {
          backToPrev();
          return false;
        });
  }

  AnimationLimiter marketTrendList(List<Coins> trendCoinData) {
    return AnimationLimiter(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: trendCoinData.length,
        primary: false,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 200),
              child: SlideAnimation(
                  verticalOffset: 44.0,
                  child: FadeInAnimation(
                      child: GestureDetector(
                    onTap: () {
                      PrefData.setTrendName(trendCoinData[index].name ?? "");
                      PrefData.setTrendImage(trendCoinData[index].icon ?? "");
                      PrefData.setTrendCurrency(
                          trendCoinData[index].symbol ?? "");
                      var price = double.parse(
                          (trendCoinData[index].price).toStringAsFixed(2));
                      PrefData.setTrendPrice(price);
                      PrefData.setTrendProfit(
                          trendCoinData[index].priceChange1h.toString());
                      Constant.sendToNext(context, Routes.detailRoute);
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          left: horspace,
                          right: horspace,
                          bottom: FetchPixels.getPixelHeight(20)),
                      padding: EdgeInsets.only(
                          left: FetchPixels.getPixelHeight(16),
                          right: FetchPixels.getPixelHeight(16),
                          top: FetchPixels.getPixelHeight(16),
                          bottom: FetchPixels.getPixelHeight(18)),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.network(
                                trendCoinData[index].icon!,
                                width: FetchPixels.getPixelHeight(50),
                                height: FetchPixels.getPixelHeight(50),
                              ),
                              getHorSpace(FetchPixels.getPixelHeight(12)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getCustomFont(trendCoinData[index].name ?? "",
                                      15, Colors.black, 1,
                                      fontWeight: FontWeight.w600),
                                  getVerSpace(FetchPixels.getPixelHeight(3)),
                                  getCustomFont(
                                      trendCoinData[index].symbol ?? "",
                                      15,
                                      subtextColor,
                                      1,
                                      fontWeight: FontWeight.w400)
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: [
                              getCustomFont(
                                  "\$${double.parse((trendCoinData[index].price).toStringAsFixed(3))}",
                                  15,
                                  Colors.black,
                                  1,
                                  fontWeight: FontWeight.w600),
                              getVerSpace(FetchPixels.getPixelHeight(5)),
                              Wrap(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: trendCoinData[index]
                                                .priceChange1h!
                                                .toString()
                                                .contains('-')
                                            ? errorbg
                                            : successBg,
                                        borderRadius: BorderRadius.circular(
                                            FetchPixels.getPixelHeight(21))),
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            FetchPixels.getPixelHeight(6),
                                        vertical:
                                            FetchPixels.getPixelHeight(1)),
                                    child: Row(
                                      children: [
                                        getSvgImage(trendCoinData[index]
                                                .priceChange1h!
                                                .toString()
                                                .contains('-')
                                            ? "error_icon.svg"
                                            : 'success_icon.svg'),
                                        getHorSpace(
                                            FetchPixels.getPixelHeight(4)),
                                        getCustomFont(
                                            trendCoinData[index]
                                                .priceChange1h
                                                .toString(),
                                            13,
                                            trendCoinData[index]
                                                    .priceChange1h!
                                                    .toString()
                                                    .contains('-')
                                                ? errorColor
                                                : successColor,
                                            1,
                                            fontWeight: FontWeight.w400)
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ))));
        },
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: horspace),
      gettoolbarMenu(
          context,
          "back.svg",
          () {
            backToPrev();
          },
          istext: true,
          title: "Market Trend",
          fontsize: 24,
          weight: FontWeight.w400,
          textColor: Colors.black,
          isrightimage: true,
          rightFunction: () {
            Constant.sendToNext(context, Routes.tabMarketRoute);
          },
          rightimage: "search.svg"),
    );
  }

  Stream<CoinList> getTrendingCoins() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      try {
        var response = await http.get(Uri.parse('https://api.coinstats.app/public/v1/coins'));

        var decoded = jsonDecode(response.body);
        if (response.statusCode != 200) {
          yield CoinList();
        } else {
          yield CoinList.fromJson(jsonDecode(response.body));
        }
      } on Exception catch (e) {
        print(e.toString());
      }
    }
  }
}
