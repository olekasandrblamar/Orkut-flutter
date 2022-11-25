import 'dart:convert';

import 'package:orkut/app/data/data_file.dart';
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
import '../../../models/coin_list.dart';

class TabMarket extends StatefulWidget {
  const TabMarket({Key? key}) : super(key: key);

  @override
  State<TabMarket> createState() => _TabMarketState();
}

class _TabMarketState extends State<TabMarket> {
  var horspace = FetchPixels.getPixelHeight(20);
  TextEditingController searchController = TextEditingController();
  List<String> categoryLists = DataFile.categoryList;
  int select = 0;
  List<ModelTrend> newTrendList = DataFile.trendList;

  // onItemChanged(String value) {
  //   setState(() {
  //     newTrendList = DataFile.trendList
  //         .where((string) =>
  //             string.name!.toLowerCase().contains(value.toLowerCase()))
  //         .toList();
  //   });
  // }

  int length = 0;

  @override
  void initState() {
    super.initState();
    length = 30;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return Column(
      children: [
        getVerSpace(FetchPixels.getPixelHeight(14)),
        appBar(context),
        getVerSpace(FetchPixels.getPixelHeight(23)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getCustomFont("Market in ", 15, Colors.black, 1,
                fontWeight: FontWeight.w400),
            getCustomFont("", 15, blueColor, 1, fontWeight: FontWeight.w600),
            getCustomFont(" in last 24h", 15, Colors.black, 1,
                fontWeight: FontWeight.w400),
          ],
        ),
        getVerSpace(FetchPixels.getPixelHeight(20)),
        searchWidget(context),
        getVerSpace(FetchPixels.getPixelHeight(24)),
        categoryList(),
        getVerSpace(FetchPixels.getPixelHeight(24)),
        StreamBuilder<CoinList>(
            stream: getTrendingCoins(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const Text('Error!');
              } else {
                return markettrendList(snapshot.data!.coins!);
              }
            })
      ],
    );
  }

  Expanded markettrendList(List<Coins> trendCoinData) {
    return Expanded(
        child: AnimationLimiter(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: length,
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
                  PrefData.setTrendCurrency(trendCoinData[index].symbol ?? "");
                  var price = double.parse(
                      (trendCoinData[index].price).toStringAsFixed(2));
                  PrefData.setTrendPrice(price);
                  PrefData.setTrendProfit(
                      trendCoinData[index].priceChange1h.toString());
                  Constant.sendToNext(context, Routes.detailRoute);
                },
                child: Container(
                  margin: EdgeInsets.only(
                      top: index == 0 ? FetchPixels.getPixelHeight(5) : 0,
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
                              getCustomFont(trendCoinData[index].name ?? "", 15,
                                  Colors.black, 1,
                                  fontWeight: FontWeight.w600),
                              getVerSpace(FetchPixels.getPixelHeight(3)),
                              getCustomFont(trendCoinData[index].symbol ?? "",
                                  15, subtextColor, 1,
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
                                    horizontal: FetchPixels.getPixelHeight(6),
                                    vertical: FetchPixels.getPixelHeight(1)),
                                child: Row(
                                  children: [
                                    getSvgImage(trendCoinData[index]
                                            .priceChange1h!
                                            .toString()
                                            .contains('-')
                                        ? "error_icon.svg"
                                        : 'success_icon.svg'),
                                    getHorSpace(FetchPixels.getPixelHeight(4)),
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
              )),
            ),
          );
        },
      ),
    ));
  }

  SizedBox categoryList() {
    return SizedBox(
      height: FetchPixels.getPixelHeight(44),
      child: ListView.builder(
        primary: true,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categoryLists.length,
        itemBuilder: (context, index) {
          return Wrap(
            children: [
              GestureDetector(
                child: Container(
                  decoration: select == index
                      ? BoxDecoration(
                          color: blueColor,
                          boxShadow: [
                            BoxShadow(
                                color: shadowColor,
                                blurRadius: 23,
                                offset: const Offset(0, 7))
                          ],
                          borderRadius: BorderRadius.circular(
                              FetchPixels.getPixelHeight(14)))
                      : null,
                  padding: EdgeInsets.symmetric(
                      vertical: FetchPixels.getPixelHeight(11),
                      horizontal:
                          select == index ? FetchPixels.getPixelHeight(20) : 0),
                  margin: EdgeInsets.only(
                      right: FetchPixels.getPixelHeight(37),
                      left: index == 0 ? horspace : 0),
                  child: getCustomFont(categoryLists[index], 15,
                      select == index ? Colors.white : textColor, 1,
                      fontWeight:
                          select == index ? FontWeight.w600 : FontWeight.w400),
                ),
                onTap: () {
                  setState(() {
                    select = index;
                    if (index == 0) {
                      length = 30;
                    } else if (index == 1) {
                      length = 2;
                    } else if (index == 2) {
                      length = 4;
                    } else if (index == 3) {
                      length = 5;
                    }
                  });
                },
              )
            ],
          );
        },
      ),
    );
  }

  Widget searchWidget(BuildContext context) {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
      getSearchWidget(context, searchController, () {}, (value) {},
          withPrefix: true),
    );
  }

  Widget appBar(BuildContext context) {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: horspace),
      gettoolbarMenu(context, "back.svg", () {},
          istext: true,
          title: "Market Trend",
          fontsize: 24,
          weight: FontWeight.w500,
          textColor: Colors.black,
          isleftimage: false,
          isrightimage: true,
          rightimage: "more.svg"),
    );
  }

  Stream<CoinList> getTrendingCoins() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      try {
        var response = await http
            .get(Uri.parse('https://api.coinstats.app/public/v1/coins'));

        var decoded = jsonDecode(response.body);
        print(decoded);

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
