import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:orkut/app/view/drawer/mydrawer.dart';

import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/pref_data.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../data/data_file.dart';
import '../../models/model_offer.dart';
import '../../models/model_trade.dart';
class Mytrades extends StatefulWidget {
  const Mytrades({Key? key}) : super(key: key);

  @override
  State<Mytrades> createState() => MytradesState();
}

class MytradesState extends State<Mytrades> {
  var horspace = FetchPixels.getPixelHeight(20);
  List<Offers> offerLists = DataFile.offerList;
  List<String> categoryLists = DataFile.timelineCategoryList;
  int select = 0;
  String device_token="";
  void backToPrev() {
    Constant.backToPrev(context);
  }
  final _scaffoldKey = GlobalKey<ScaffoldState>();
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
    print(response.body);
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
    return
      WillPopScope(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            endDrawer: Mydrawer(),
            key: _scaffoldKey,
            body: SafeArea(
              child:Stack(
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


                ],
              ),
            ),
          ),
          onWillPop: () async {
            backToPrev();
            return false;
          }
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
            () {
          backToPrev();
        },
        istext: true,
        title: "My trades",
        fontsize: 20,
        weight: FontWeight.w400,
        textColor: Colors.black,
        isleftimage: true,
        isrightimage: true,
        rightimage: "more.svg",
        rightFunction: (){
          _scaffoldKey.currentState?.openEndDrawer();
        }
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
                    14,
                    Colors.black,
                    1,
                    fontWeight: FontWeight.w600,
                  ),
                  getCustomFont(
                    "Type/Fee/Duration",
                    12,
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
                    14,
                    Colors.black,
                    1,
                    fontWeight: FontWeight.w600,
                  ),
                  getCustomFont(
                    trade.type,
                    12,
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
                    14,
                    Colors.black,
                    1,
                    fontWeight: FontWeight.w600,
                  ),
                  getVerSpace(
                    FetchPixels.getPixelHeight(5),
                  ),
                  getCustomFont(
                    trade.amount,
                    12,
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
                    14,
                    Colors.black,
                    1,
                    fontWeight: FontWeight.w600,
                  ),
                  getVerSpace(
                    FetchPixels.getPixelHeight(5),
                  ),
                  getCustomFont(
                    trade.status==1? 'active' :'inactive',
                    12,
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
                    14,
                    Colors.black,
                    1,
                    fontWeight: FontWeight.w600,
                  ),
                  getVerSpace(
                    FetchPixels.getPixelHeight(5),
                  ),
                  getCustomFont(
                    "xyz",
                    12,
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
}
