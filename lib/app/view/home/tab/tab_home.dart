import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:orkut/app/data/data_file.dart';
import 'package:orkut/app/models/model_exchange.dart';
import 'package:orkut/app/models/model_news.dart';
import 'package:orkut/app/models/model_slider.dart';
import 'package:orkut/app/routes/app_routes.dart';
import 'package:orkut/app/view/drawer/mydrawer.dart';
import 'package:orkut/app/view/extra_screens/deposit.dart';
import 'package:orkut/app/view/extra_screens/withdraw.dart';
import 'package:orkut/app/view/home/exchange_screen.dart';
import 'package:orkut/app/view/home/market_trend_screen.dart';
import 'package:orkut/app/view/offer/create_offer.dart';
import 'package:orkut/app/view/offer/search_offer_list.dart';
import 'package:orkut/app/view/trade_request/trade_requests.dart';
import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/constant.dart';
import 'package:orkut/base/pref_data.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import '../../../models/coin_list.dart';
import '../../../models/model_portfolio.dart';
import '../../../models/model_seller.dart';
import '../../../models/model_trend.dart';
import 'package:orkut/base/constant.dart';

import '../../converter/api.dart';

class TabHome extends StatefulWidget {
  const TabHome({Key? key}) : super(key: key);

  @override
  State<TabHome> createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  var horspace = FetchPixels.getPixelHeight(20);
  ValueNotifier selectedPage = ValueNotifier(0);
  final _controller = PageController();
  List<ModelPortfolio> portfolioLists = DataFile.portfolioList;
 // List<ModelSeller> sellerLists = DataFile.sellerList;
  List<ModelTrend> trendLists = DataFile.trendList;
  List<ModelNews> newsLists = DataFile.newsList;
  List<String> actions = DataFile.homeActions;
  List<ModelSlider> sliders = DataFile.sliderList;
  var select = 0;
  List<String?> convertedValues=[];
  Future<String?> convert({
    required String? from,
  }) async {
    try {
      String url = "${ApiService.ENDPOINT}$from/USD";
      String convertedAmount='';
      ExchangeModel exchange;

      print(url);
      /// get the latest currency rate
      Response? resp = (await ApiService.getConvertedAmount(url));
      if (resp != null) {
        var respJson=jsonDecode(resp.body);
        print(respJson);
        exchange=ExchangeModel.fromJson(respJson);

        print(exchange.rate);
        convertedAmount=exchange.rate!.toString();
        return convertedAmount;

        // double unitValue = double.parse(jsonDecode(resp.body)[to].toString());
        // value = amount * unitValue;
      }
    } catch (err) {
      if (kDebugMode) {
        print("convert err $err");
      }
      return null;
    }
    return null;
  }

  getConverted()async{
    for (var element in portfolioLists) {
      String? a=await convert(from: element!.currency);
      convertedValues.add(a);
    }
    setState(() {

    });
  }
String device_token='';
  String firstName = "";
  String lastName = "";
  String email = "";
  String phoneNo = "";
  Future<void> getData() async {
    firstName = await PrefData.getFirstName();
    lastName = await PrefData.getLastName();
    email = await PrefData.getEmail();
    phoneNo = await PrefData.getPhoneNo();
  }
  @override
  void initState() {
    super.initState();
    Future<String> _futuretoken=PrefData.getToken();
    _futuretoken.then((value)async {
      setState(() {
        device_token=value;
      });
    },
    );
    getData().then((value) {
      setState(() {});
    });
    getConverted();
    // fetchdata();
    // fetch_portfolio();
    fetch_profile();
    getTrendingCoins();
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return Stack(
      children: [
        Container(
          color: blueColor,
          padding: EdgeInsets.only(top: FetchPixels.getPixelHeight(268)),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
            child: Column(
          children: [
            getVerSpace(FetchPixels.getPixelHeight(20)),
            appBar(context),
            getVerSpace(FetchPixels.getPixelHeight(20)),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: AnimationLimiter(
                  child: Column(
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 200),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        verticalOffset: 44.0,
                        child: FadeInAnimation(child: widget),
                      ),
                      children: [
                        Container(
                          height: FetchPixels.getPixelHeight(68),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  FetchPixels.getPixelHeight(14))),
                          margin: EdgeInsets.symmetric(horizontal: horspace),
                          padding: EdgeInsets.symmetric(horizontal: horspace),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              getCustomFont("Total Worth", 12, Colors.black, 1,
                                  fontWeight: FontWeight.w600),
                              getCustomFont("\$410.26", 16, blueColor, 1,
                                  fontWeight: FontWeight.w600)
                            ],
                          ),
                        ),
                        getVerSpace(FetchPixels.getPixelHeight(19)),
                        SizedBox(
                          height: FetchPixels.getPixelHeight(160),
                          child: buildPageView(),
                        ),
                        getVerSpace(FetchPixels.getPixelHeight(17)),
                        indicator(),
                        getVerSpace(FetchPixels.getPixelHeight(30)),
                        actionList(),
                        getVerSpace(FetchPixels.getPixelHeight(20)),
                        GestureDetector(
                            onTap:(){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>Trade_requests()));
                        },
                            child: buildMyTradeListButton()),
                        getVerSpace(FetchPixels.getPixelHeight(35)),
                        getPaddingWidget(
                          EdgeInsets.symmetric(horizontal: horspace),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              getCustomFont("Best Sellers", 15, Colors.black, 1,
                                  fontWeight: FontWeight.w600),
                            ],
                          ),
                        ),
                        getVerSpace(FetchPixels.getPixelHeight(12)),
                        StreamBuilder<List<ModelSeller>>(
                            stream: fetchdata(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Text("");
                              }

                              if (snapshot.hasError) {
                                return const Text('Error!');
                              } else {
                                return sellerList(snapshot.data!);
                              }
                            }
                        ),
                        getPaddingWidget(
                          EdgeInsets.symmetric(horizontal: horspace),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              getCustomFont("Portfolio", 15, Colors.black, 1,
                                  fontWeight: FontWeight.w600),
                              GestureDetector(
                                onTap: () {
                                  Constant.sendToNext(
                                      context, Routes.portfolioRoute);
                                },
                                child: getCustomFont(
                                    "View all", 12, subtextColor, 1,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                        getVerSpace(FetchPixels.getPixelHeight(13)),
                        StreamBuilder<List<ModelPortfolio>>(
                            stream: fetch_portfolio(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Text("");
                              }
                              if (snapshot.hasError) {
                                return const Text('Error!');
                              } else {
                                return portfolioList(snapshot.data);
                              }
                            }
                        ),
                        getVerSpace(FetchPixels.getPixelHeight(13)),
                        getPaddingWidget(
                          EdgeInsets.symmetric(horizontal: horspace),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              getCustomFont("Market Trend", 15, Colors.black, 1,
                                  fontWeight: FontWeight.w600),
                              GestureDetector(
                                onTap: () {
                                  Constant.sendToNext(
                                      context, Routes.marketTrendRoute);
                                },
                                child: getCustomFont(
                                    "View all", 12, subtextColor, 1,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                        getVerSpace(FetchPixels.getPixelHeight(12)),
                        StreamBuilder<CoinList>(
                            stream: getTrendingCoins(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }
                              if (snapshot.hasError) {
                                return const Text('Error!');
                              } else {
                                return marketTrendList(snapshot.data!.coins!);
                              }
                            }),
                        getVerSpace(FetchPixels.getPixelHeight(4)),
                        getPaddingWidget(
                          EdgeInsets.symmetric(horizontal: horspace),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              getCustomFont("News", 15, Colors.black, 1,
                                  fontWeight: FontWeight.w600),
                              GestureDetector(
                                onTap: () {
                                  Constant.sendToNext(
                                      context, Routes.marketTrendRoute);
                                },
                                child: getCustomFont(
                                    "View all", 12, subtextColor, 1,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                        getVerSpace(FetchPixels.getPixelHeight(12)),
                        newsList()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ))
      ],
    );
  }

  Container buildMyTradeListButton() {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromRGBO(251, 192, 45, 1),
          boxShadow: [
            BoxShadow(
                color: shadowColor, blurRadius: 23, offset: const Offset(0, 7))
          ],
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14))),
      padding: EdgeInsets.symmetric(
        vertical: FetchPixels.getPixelHeight(11),
        horizontal: FetchPixels.getPixelHeight(20),
      ),
      child: getCustomFont(
        "Trade Requests",
        12,
        Colors.white,
        1,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  SizedBox actionList() {
    return SizedBox(
      height: FetchPixels.getPixelHeight(44),
      child: ListView.builder(
        primary: true,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: actions.length,
        itemBuilder: (context, index) {
          return Wrap(
            children: [
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: shadowColor,
                                blurRadius: 23,
                                offset: const Offset(0, 7))
                          ],
                          borderRadius: BorderRadius.circular(
                              FetchPixels.getPixelHeight(14),
                          ),
                      border: Border.all(color: blueColor)
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: FetchPixels.getPixelHeight(11),
                      horizontal: FetchPixels.getPixelWidth(20)),
                  margin: EdgeInsets.only(
                      right: 10,
                  ),
                  child: getCustomFont(actions[index], 15,
                       blueColor, 1,
                      fontWeight:
                          select == index ? FontWeight.w600 : FontWeight.w400),
                ),
                onTap: () {
                 if(index==0){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchOfferListScreen()));
                 }
                 else if(index==1){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchOfferListScreen()));
                 }
                 else if(index==2){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>Deposit()));
                 }
                 else if(index==3){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>Withdraw()));
                 }
                },
              ),
            ],
          );
        },
      ),
    );
  }

  SizedBox newsList() {
    return SizedBox(
      height: FetchPixels.getPixelHeight(235),
      child: ListView.builder(
        itemCount: newsLists.length,
        primary: false,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          ModelNews modelNews = newsLists[index];
          return Container(
            margin: EdgeInsets.only(
                right: FetchPixels.getPixelHeight(16),
                left: index == 0 ? FetchPixels.getPixelHeight(20) : 0),
            child: Column(
              children: [
                getAssetImage(modelNews.image,
                    width: FetchPixels.getPixelHeight(295),
                    height: FetchPixels.getPixelHeight(158)),
                Container(
                  width: FetchPixels.getPixelHeight(295),
                  padding: EdgeInsets.only(
                      left: FetchPixels.getPixelHeight(14),
                      top: FetchPixels.getPixelHeight(14),
                      bottom: FetchPixels.getPixelHeight(18)),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: shadowColor,
                            blurRadius: 23,
                            offset: const Offset(0, 7))
                      ],
                      borderRadius: BorderRadius.vertical(
                          bottom:
                              Radius.circular(FetchPixels.getPixelHeight(14)))),
                  child: getCustomFont(modelNews.name, 14, Colors.black, 1,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  ListView marketTrendList(List<Coins> trendCoinData) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: 4,
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            PrefData.setTrendName(trendCoinData[index].name ?? "");
            PrefData.setTrendImage(trendCoinData[index].icon ?? "");
            PrefData.setTrendCurrency(trendCoinData[index].symbol ?? "");
            PrefData.setTrendPrice(trendCoinData[index].price ?? 0.00);
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
                borderRadius:
                    BorderRadius.circular(FetchPixels.getPixelHeight(14))),
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
                        getCustomFont(trendCoinData[index].name ?? "", 12,
                            Colors.black, 1,
                            fontWeight: FontWeight.w600),
                        getVerSpace(FetchPixels.getPixelHeight(3)),
                        getCustomFont(trendCoinData[index].symbol ?? "", 12,
                            subtextColor, 1,
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
                                      .priceChange1h
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
                                      .priceChange1h
                                      .toString()
                                      .contains('-')
                                  ? "error_icon.svg"
                                  : 'success_icon.svg'),
                              getHorSpace(FetchPixels.getPixelHeight(4)),
                              getCustomFont(
                                  trendCoinData[index].priceChange1h.toString(),
                                  12,
                                  trendCoinData[index]
                                          .priceChange1h
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
        );
      },
    );
  }
  Expanded portfolioList(List<ModelPortfolio>? data) {
    return Expanded(
        flex: 1,
        child: AnimationLimiter(
          child: ListView.builder(
            primary: true,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: data?.length,
            itemBuilder: (context, index) {
              ModelPortfolio modelPortfolio = data![index];
              return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 200),
                  child: SlideAnimation(
                      verticalOffset: 44.0,
                      child: FadeInAnimation(
                          child: GestureDetector(
                            onTap: (){
                              // Constant.sendToNext(context, Routes.exchangeRoute);
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
                                  bottom: FetchPixels.getPixelHeight(16)),
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
                                      getSvgImage(modelPortfolio.id.toString() ?? "",
                                          height: FetchPixels.getPixelHeight(50),
                                          width: FetchPixels.getPixelHeight(50)),
                                      getHorSpace(FetchPixels.getPixelHeight(12)),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          getCustomFont(modelPortfolio.currency ?? "", 12,
                                              Colors.black, 1,
                                              fontWeight: FontWeight.w600),
                                          getVerSpace(FetchPixels.getPixelHeight(3)),
                                          getCustomFont(modelPortfolio.code ?? "",
                                              12, skipColor, 1,
                                              fontWeight: FontWeight.w400)
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      getCustomFont("\$${modelPortfolio.balance}", 12,
                                          Colors.black, 1,
                                          fontWeight: FontWeight.w600),
                                      getVerSpace(FetchPixels.getPixelHeight(5)),
                                      Wrap(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color:
                                                modelPortfolio.price! == "-"
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
                                                getSvgImage(
                                                    modelPortfolio.price! == "-"
                                                        ? "error_icon.svg"
                                                        : "success_icon.svg"),
                                                getHorSpace(
                                                    FetchPixels.getPixelHeight(4)),
                                                getCustomFont(
                                                    modelPortfolio.price?? '',
                                                    13,
                                                    modelPortfolio.price![0] == "-"
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
        ));
  }
  SizedBox sellerList(List<ModelSeller> sellerLists) {
    return SizedBox(
      height: FetchPixels.getPixelHeight(88),
      width: FetchPixels.getPixelHeight(500),
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: sellerLists.length,
        itemBuilder: (context, index) {
          ModelSeller modelSeller = sellerLists[index];
          return Container(
            margin: EdgeInsets.only(
                bottom: FetchPixels.getPixelHeight(25),
                right: FetchPixels.getPixelHeight(25),
                left: index == 0 ? FetchPixels.getPixelHeight(20) : 0),
            child:Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage:NetworkImage('https://orkt.one/assets/images/'+modelSeller.image),radius: 30,)
              ],
            ),
          );
        },
      ),
    );
  }

  Row indicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (position) {
          return getPaddingWidget(
              EdgeInsets.symmetric(horizontal: FetchPixels.getPixelHeight(5)),
              getSvgImage(position == selectedPage.value
                  ? "blue_selcted.svg"
                  : "dot.svg"));
        },
      ),
    );
  }

  PageView buildPageView() {
    return PageView.builder(
      controller: _controller,
      onPageChanged: (value) {
        setState(() {
          selectedPage.value = value;
        });
      },
      itemCount: sliders.length,
      itemBuilder: (context, index) {
        return Stack(
          alignment: Alignment.centerRight,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: FetchPixels.getPixelHeight(21)),
              margin: EdgeInsets.symmetric(horizontal: horspace),
              decoration: BoxDecoration(
                  color: const Color(0xFFECF4FF),
                  borderRadius:
                      BorderRadius.circular(FetchPixels.getPixelHeight(14))),
              child: SizedBox(
                width: FetchPixels.getPixelHeight(217),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getVerSpace(FetchPixels.getPixelHeight(22)),
                    SizedBox(
                      width: FetchPixels.getPixelWidth(149),
                      child: getMultilineCustomFont(
                          sliders[index].name, 18, Colors.black,
                          fontWeight: FontWeight.w700,
                          txtHeight: FetchPixels.getPixelHeight(1.3)),
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(11)),
                    getMultilineCustomFont(
                        sliders[index].description, 13, Colors.black,
                        fontWeight: FontWeight.w400,
                        txtHeight: FetchPixels.getPixelHeight(1.3)),
                    getVerSpace(FetchPixels.getPixelHeight(11)),
                    Row(
                      children: [
                        SizedBox(
                          height: 35,
                          child: TextButton(onPressed: (){
                              if(index==0){
                              //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ExchangeScreen(null)));
                              }
                              else if(index==1){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Deposit()));
                              }
                              else if(index==2){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateOfferScreen()));
                              }
                        },
                          child:
                        getCustomFont(sliders[index].btnText, 14, blueColor, 1,
                            fontWeight: FontWeight.w600),
                        ),
                        ),
                        getHorSpace(FetchPixels.getPixelHeight(4)),
                        getSvgImage("right_arrow.svg"),
                      ],
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(19)),
                  ],
                ),
              ),
            ),
            Positioned(
              child: SizedBox(
                height: FetchPixels.getPixelHeight(160),
                width: FetchPixels.getPixelHeight(246),
                child: getAssetImage(
                  sliders[index].image,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget appBar(BuildContext context) {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: horspace),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
       //    Container(
       //      width: 45,
       // height: 45,
       // child: IconButton(onPressed: (){
       //   Scaffold.of(context).openDrawer();
       //  }, icon: Icon(Icons.menu),
       //    iconSize: 30,
       //  color: Theme.of(context).primaryColorLight,
       //  ),
       //    ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder<void>(
                  stream: fetch_profile(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return getCustomFont("Hello, $firstName", 15, Colors.white, 1,
                          fontWeight: FontWeight.w400);
                    }
                    if (snapshot.hasError) {
                      return const Text('Error!');
                    } else {
                      return  getCustomFont("Hello, $firstName", 15, Colors.white, 1,
                          fontWeight: FontWeight.w400);
                    }
                  }
              ),
              getVerSpace(FetchPixels.getPixelHeight(4)),
              getCustomFont("Manage Crypto", 20, Colors.white, 1,
                  fontWeight: FontWeight.w700)
            ],
          ),
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Constant.sendToNext(context, Routes.marketTrendRoute);
                  },
                  child: getSvgImage("search.svg", color: Colors.white)),
              getHorSpace(FetchPixels.getPixelHeight(18)),
              GestureDetector(
                onTap: () {
                  Constant.sendToNext(context, Routes.myProfileRoute);
                },
                child: getAssetImage("profile_image.png",
                    width: FetchPixels.getPixelHeight(40),
                    height: FetchPixels.getPixelHeight(40)),
              )
            ],
          )
        ],
      ),
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
  Stream<List<ModelPortfolio>> fetch_portfolio() async*{
    final response=await http.get(Uri.parse('https://orkt.one/api/portfolio'),
        headers: {
          HttpHeaders.acceptHeader:'application/json',
          HttpHeaders.authorizationHeader:'Bearer '+device_token
        }
    );

    if(response.statusCode==200){
      List<ModelPortfolio> portfolio_response=portfoliofromjson(response.body);

      yield portfolio_response;
    }
    else{
      throw Exception('Failed to fetch data');
    }
  }
  Stream<List<ModelSeller>> fetchdata() async*{
    final response=await http.get(Uri.parse('https://orkt.one/api/best-sellers'),
        headers: {
          HttpHeaders.acceptHeader:'application/json',
          HttpHeaders.authorizationHeader:'Bearer '+device_token
        }
    );
    print(response.body);
    print(response.statusCode);
    if(response.statusCode==200){
      List<ModelSeller> seller_response=sellerfromjson(response.body);
      yield seller_response;
    }
    else{
      throw Exception('Failed to fetch data');
    }
  }
  Stream<void> fetch_profile() async*{
    final response=await http.get(Uri.parse('https://orkt.one/api/user'),
        headers: {
          HttpHeaders.acceptHeader:'application/json',
          HttpHeaders.authorizationHeader:'Bearer '+device_token,
        }
    );
     if(response.statusCode==200){
      PrefData.setFirstName(jsonDecode(response.body)['name']);
      PrefData.setEmail(jsonDecode(response.body)['email']);
      PrefData.setPhoneNo(jsonDecode(response.body)['phone']);
    }
    else{
      throw Exception('Failed to fetch data');
    }
  }
}
