import 'dart:io';

import 'package:orkut/app/data/data_file.dart';
import 'package:orkut/app/models/model_deposits.dart';
import 'package:orkut/app/models/model_offer.dart';
import 'package:orkut/app/models/model_seller.dart';
import 'package:orkut/app/models/model_trade.dart';
import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import '../../../../base/pref_data.dart';
import '../../../routes/app_routes.dart';

class TabOffers extends StatefulWidget {
  const TabOffers({Key? key}) : super(key: key);

  @override
  State<TabOffers> createState() => _TabOffersState();
}

class _TabOffersState extends State<TabOffers> {
  var horspace = FetchPixels.getPixelHeight(20);
  List<Offers> offerLists = DataFile.offerList;
  List<String> categoryLists = DataFile.timelineCategoryList;
  int select = 0;
  String device_token="";
 @override
 void initState(){
   super.initState();
   fetchdata();
   Future<String> _futuretoken=PrefData.getToken();
    _futuretoken.then((value)async {
     setState(() {
       device_token=value;
     });
   },
   );
 }

  Stream<List<ModelTrade>> fetchdata() async*{
    final response=await http.get(Uri.parse('https://orkt.one/api/my-trades'),
        headers: {
          HttpHeaders.acceptHeader:'application/json',
          HttpHeaders.authorizationHeader:'Bearer '+device_token
        }
    );
    if(response.statusCode==200){
      List<ModelTrade> trade_response=tradefromjson(response.body);
      yield trade_response;
    }
    else{
      throw Exception('Failed to fetch data');
    }
  }
  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getVerSpace(FetchPixels.getPixelHeight(14)),
            appBar(
              context,
            ),
            getVerSpace(FetchPixels.getPixelHeight(23)),
            StreamBuilder<List<ModelTrade>>(
                stream: fetchdata(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child:CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Text('Error!');
                  } else {
                    return tradeList(snapshot.data!);
                  }
                }
            ),
          ],
        ),
        floatingActionButton(),

      ],
    );
  }

  void openUserDetails(height, Offers offer) {
    showModalBottomSheet<void>(
      context: context,
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SizedBox(
          height: height * 0.85,
          child: offerUserScreen(offer.user_id),
        );
      },
    );
  }

  Expanded tradeList(List<ModelTrade> tradelist) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tradelist.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 800),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (BuildContext context, double position, child) {
                    return Transform.scale(
                      scale: position,
                      child: child,
                    );
                  },
                  child: tradeCard(
                    tradelist[index],
                    onPress: () {},
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: horspace),
      gettoolbarMenu(
        context,
        "back.svg",
        () {},
        istext: true,
        title: "Trade Requests",
        fontsize: 24,
        weight: FontWeight.w400,
        textColor: Colors.black,
        isleftimage: false,
        isrightimage: true,
        rightimage: "more.svg",
      ),
    );
  }
  Widget tradeCard(ModelTrade trade, {onPress}) {
    return Container(
      padding: EdgeInsets.all(
        FetchPixels.getPixelHeight(36),
      ),
      margin: EdgeInsets.only(
        left: FetchPixels.getPixelWidth(
          30,
        ),
        right: FetchPixels.getPixelWidth(
          30,
        ),
        bottom: FetchPixels.getPixelWidth(
          20,
        ),
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: shadowColor, blurRadius: 23, offset: const Offset(0, 7))
        ],
        gradient: const LinearGradient(
          stops: [0.02, 0.02],
          colors: [
            Colors.green,
            Colors.white,
          ],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            FetchPixels.getPixelWidth(20),
          ),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getCustomFont(
                    "Trade Code",
                    18,
                    Colors.black,
                    1,
                    fontWeight: FontWeight.w600,
                  ),
                  getCustomFont(
                    "Type/Fee/Duration",
                    15,
                    textColor,
                    1,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getCustomFont(
                    trade.code,
                    18,
                    Colors.black,
                    1,
                    fontWeight: FontWeight.w600,
                  ),
                  getCustomFont(
                    trade.type,
                    15,
                    textColor,
                    1,
                  ),
                ],
              ),
            ],
          ),
          getVerSpace(
            FetchPixels.getPixelHeight(20),
          ),
          Container(
            height: FetchPixels.getPixelHeight(1),
            color: textColor.withOpacity(0.2),
          ),
          getVerSpace(
            FetchPixels.getPixelHeight(20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getCustomFont(
                    "Amount/Rates",
                    18,
                    Colors.black,
                    1,
                    fontWeight: FontWeight.w600,
                  ),
                  getVerSpace(
                    FetchPixels.getPixelHeight(5),
                  ),
                  getCustomFont(
                    trade.amount,
                    16,
                    textColor,
                    1,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getCustomFont(
                    "Status",
                    18,
                    Colors.black,
                    1,
                    fontWeight: FontWeight.w600,
                  ),
                  getVerSpace(
                    FetchPixels.getPixelHeight(5),
                  ),
                  getCustomFont(
                    trade.status==1? 'active' :'inactive',
                    16,
                    textColor,
                    1,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getCustomFont(
                    "Action",
                    18,
                    Colors.black,
                    1,
                    fontWeight: FontWeight.w600,
                  ),
                  getVerSpace(
                    FetchPixels.getPixelHeight(5),
                  ),
                  getCustomFont(
                    "xyz",
                    16,
                    textColor,
                    1,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget tradeRequestCard(ModelTrade trade, {onPress}) {
    return Container(
      padding: EdgeInsets.all(
        FetchPixels.getPixelHeight(24),
      ),
      margin: EdgeInsets.only(
        left: FetchPixels.getPixelWidth(
          30,
        ),
        right: FetchPixels.getPixelWidth(
          30,
        ),
        bottom: FetchPixels.getPixelWidth(
          20,
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: shadowColor, blurRadius: 23, offset: const Offset(0, 7))
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(
            FetchPixels.getPixelWidth(20),
          ),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getCustomFont(
              trade.code,
              20,
              Colors.black,
              1,
              fontWeight: FontWeight.w600,
            ),
            getCustomFont(
              "Requested By",
              16,
              textColor,
              1,
            ),
            getCustomFont(
              "Type/Fee/Duration",
              16,
              textColor,
              1,
            ),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            getCustomFont(
              trade.amount,
              20,
              Colors.redAccent,
              1,
              fontWeight: FontWeight.w600,
            ),
            getCustomFont(
              trade.status==1? 'active' :'inactive',
              16,
              textColor,
              1,
            ),
            getCustomFont(
              "Action",
              16,
              textColor,
              1,
            ),
          ],
        )
      ]),
    );
  }
  Widget floatingActionButton() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
        right: 10,
      ),
      child: ElevatedButton(
        onPressed: () {Navigator.pushNamed(context, Routes.createTradeRequestRoute);
            },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.yellow[700]),
          shape:MaterialStateProperty.resolveWith((states) => CircleBorder(),),
          padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.all(
          FetchPixels.getPixelWidth(15),)
          ),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  Widget offerUserScreen(String seller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 30,
            top: 30,
            bottom: 10,
          ),
          child: Column(
            children: [
              getSvgImage(
                seller.toString(),
                width: 100,
                height: 100,
              ),
              getVerSpace(20),
              getCustomFont(
                "About ${seller.toString()}",
                20,
                Colors.black,
                1,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget offerCard(height, Offers offer, {onPress}) {
    return Container(
      padding: EdgeInsets.all(
        FetchPixels.getPixelHeight(24),
      ),
      margin: EdgeInsets.only(
        left: FetchPixels.getPixelWidth(
          30,
        ),
        right: FetchPixels.getPixelWidth(
          30,
        ),
        bottom: FetchPixels.getPixelWidth(
          20,
        ),
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: shadowColor, blurRadius: 23, offset: const Offset(0, 7))
        ],
        gradient: const LinearGradient(
          stops: [0.02, 0.02],
          colors: [
            Colors.green,
            Colors.white,
          ],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            FetchPixels.getPixelWidth(20),
          ),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getSvgImage(
                    offer.user_id.toString(),
                    width: 30,
                    height: 30,
                  ),
                  getHorSpace(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getCustomFont(
                        offer.currency,
                        18,
                        Colors.black,
                        1,
                        fontWeight: FontWeight.w600,
                      ),
                      getCustomFont(
                        "From: ${offer.user_id.toString()}",
                        15,
                        textColor,
                        1,
                      ),
                      getVerSpace(5),
                      RatingBar.builder(
                        initialRating: 4.5,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        tapOnlyMode: true,
                        wrapAlignment: WrapAlignment.start,
                        itemCount: 5,
                        itemPadding: EdgeInsets.only(
                          right: FetchPixels.getPixelWidth(1),
                        ),
                        itemSize: 20,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: "#FFB500".toColor(),
                        ),
                        unratedColor: "#9B9B9B".toColor(),
                        onRatingUpdate: (rating) {},
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.arrow_upward,
                        color: "#FFB500".toColor(),
                        size: 16,
                      ),
                      getCustomFont(
                        "0%",
                        14,
                        "#FFB500".toColor(),
                        1,
                      ),
                    ],
                  ),
                  getHorSpace(5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getCustomFont(
                        "${offer.price} USD",
                        18,
                        Colors.black,
                        1,
                        fontWeight: FontWeight.w600,
                      ),
                      getCustomFont(
                        "Limit: 1.00-10.00",
                        16,
                        textColor,
                        1,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          getVerSpace(
            FetchPixels.getPixelHeight(20),
          ),
          Container(
            height: FetchPixels.getPixelHeight(1),
            color: textColor.withOpacity(0.2),
          ),
          getVerSpace(
            FetchPixels.getPixelHeight(20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getCustomFont(
                    "Pay With",
                    18,
                    Colors.black,
                    1,
                    fontWeight: FontWeight.w600,
                  ),
                  getVerSpace(
                    FetchPixels.getPixelHeight(5),
                  ),
                  getCustomFont(
                    offer.payWith,
                    16,
                    textColor,
                    1,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getCustomFont(
                    "Duration",
                    18,
                    Colors.black,
                    1,
                    fontWeight: FontWeight.w600,
                  ),
                  getVerSpace(
                    FetchPixels.getPixelHeight(5),
                  ),
                  getCustomFont(
                    "${offer.duration} mins",
                    16,
                    textColor,
                    1,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getCustomFont(
                    "Price type",
                    18,
                    Colors.black,
                    1,
                    fontWeight: FontWeight.w600,
                  ),
                  getVerSpace(
                    FetchPixels.getPixelHeight(5),
                  ),
                  getCustomFont(
                    offer.priceType.toString(),
                    16,
                    textColor,
                    1,
                  ),
                ],
              ),
            ],
          ),
          getVerSpace(
            FetchPixels.getPixelHeight(30),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getButton(
                context,
                Colors.transparent,
                "Details",
                "#FFB500".toColor(),
                () {
                  openUserDetails(height, offer);
                },
                15,
                buttonHeight: 30,
                buttonWidth: 70,
                borderColor: "#FFB500".toColor(),
                borderWidth: FetchPixels.getPixelWidth(1),
                isBorder: true,
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              getHorSpace(
                FetchPixels.getPixelWidth(20),
              ),
              getButton(
                context,
                "#FFB500".toColor(),
                "Buy",
                Colors.white,
                () {},
                15,
                buttonHeight: 30,
                buttonWidth: 70,
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget myOfferCard(Offers offer, {onPress}) {
    return Container(
      padding: EdgeInsets.all(
        FetchPixels.getPixelHeight(24),
      ),
      margin: EdgeInsets.only(
        left: FetchPixels.getPixelWidth(
          30,
        ),
        right: FetchPixels.getPixelWidth(
          30,
        ),
        bottom: FetchPixels.getPixelWidth(
          20,
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: shadowColor, blurRadius: 23, offset: const Offset(0, 7))
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(
            FetchPixels.getPixelWidth(20),
          ),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        child: InkWell(
          onTap: () {},
          child: Row(children: [
            getSvgImage(
             offer.user_id.toString(),
            ),
            getHorSpace(
              FetchPixels.getPixelWidth(10),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getCustomFont(
                  offer.user_id.toString(),
                  18,
                  Colors.black,
                  1,
                  fontWeight: FontWeight.w500,
                ),
                getCustomFont(
                  "Buy",
                  16,
                  textColor,
                  1,
                ),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                getCustomFont(
                  "${offer.price} USD",
                  18,
                  Colors.black,
                  1,
                  fontWeight: FontWeight.w600,
                ),
                getCustomFont(
                  "01-06-22",
                  16,
                  textColor,
                  1,
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }

  Widget myDepositCard(ModelDeposits deposit, {onPress}) {
    return Container(
      padding: EdgeInsets.all(
        FetchPixels.getPixelHeight(24),
      ),
      margin: EdgeInsets.only(
        left: FetchPixels.getPixelWidth(
          30,
        ),
        right: FetchPixels.getPixelWidth(
          30,
        ),
        bottom: FetchPixels.getPixelWidth(
          20,
        ),
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: shadowColor, blurRadius: 23, offset: const Offset(0, 7))
        ],
        gradient: const LinearGradient(
          stops: [0.02, 0.02],
          colors: [
            Colors.green,
            Colors.white,
          ],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            FetchPixels.getPixelWidth(20),
          ),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: [
        Row(
          children: [
            getSvgImage(deposit.currency.name),
            getHorSpace(
              FetchPixels.getPixelWidth(10),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getCustomFont(
                  deposit.currency.name,
                  18,
                  Colors.black,
                  1,
                  fontWeight: FontWeight.w600,
                ),
                getCustomFont(
                  "${deposit.price} ${deposit.currency.name}",
                  16,
                  textColor,
                  1,
                ),
              ],
            )
          ],
        ),
        getVerSpace(
          FetchPixels.getPixelHeight(20),
        ),
        Container(
          height: FetchPixels.getPixelHeight(1),
          color: textColor.withOpacity(0.2),
        ),
        getVerSpace(
          FetchPixels.getPixelHeight(20),
        ),
        Row(
          children: [
            Expanded(
              child: getButton(
                context,
                blueColor,
                "Get Deposit Address",
                Colors.white,
                () {},
                16,
                buttonHeight: 35,
                borderRadius: BorderRadius.circular(10),
                weight: FontWeight.w500,
              ),
            ),
            getHorSpace(
              FetchPixels.getPixelWidth(10),
            ),
            Expanded(
              child: getButton(
                context,
                Colors.lightBlue,
                "Existing Address",
                Colors.white,
                () {},
                16,
                buttonHeight: 35,
                borderRadius: BorderRadius.circular(10),
                weight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ]),
    );
  }

  Widget withdrawCard(ModelDeposits deposit, {onPress}) {
    return Container(
      padding: EdgeInsets.all(
        FetchPixels.getPixelHeight(24),
      ),
      margin: EdgeInsets.only(
        left: FetchPixels.getPixelWidth(
          30,
        ),
        right: FetchPixels.getPixelWidth(
          30,
        ),
        bottom: FetchPixels.getPixelWidth(
          20,
        ),
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: shadowColor, blurRadius: 23, offset: const Offset(0, 7))
        ],
        gradient: const LinearGradient(
          stops: [0.02, 0.02],
          colors: [
            Colors.green,
            Colors.white,
          ],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            FetchPixels.getPixelWidth(20),
          ),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: [
        Row(
          children: [
            getSvgImage(deposit.currency.name),
            getHorSpace(
              FetchPixels.getPixelWidth(10),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getCustomFont(
                  deposit.currency.name,
                  18,
                  Colors.black,
                  1,
                  fontWeight: FontWeight.w600,
                ),
                getCustomFont(
                  "${deposit.price} ${deposit.currency.name}",
                  16,
                  textColor,
                  1,
                ),
              ],
            )
          ],
        ),
        getVerSpace(
          FetchPixels.getPixelHeight(20),
        ),
        Container(
          height: FetchPixels.getPixelHeight(1),
          color: textColor.withOpacity(0.2),
        ),
        getVerSpace(
          FetchPixels.getPixelHeight(20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getButton(
              context,
              blueColor,
              "Withdraw",
              Colors.white,
              () {},
              16,
              buttonHeight: 40,
              buttonWidth: 160,
              borderRadius: BorderRadius.circular(10),
              weight: FontWeight.w500,
            ),
          ],
        ),
      ]),
    );
  }
}
