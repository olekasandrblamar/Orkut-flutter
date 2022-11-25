import 'dart:convert';
import 'dart:io';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:orkut/app/data/data_file.dart';
import 'package:orkut/app/models/model_currency.dart';

import 'package:orkut/app/routes/app_routes.dart';
import 'package:orkut/app/view/drawer/mydrawer.dart';
import 'package:orkut/app/view/extra_screens/select_trade.dart';
import 'package:orkut/app/view/extra_screens/start_trade.dart';
import 'package:orkut/app/view/profile/about_profile.dart';
import 'package:orkut/app/view/trade_request/create_trade_request.dart';
import 'package:orkut/app/view/trade_request/p2p_trading.dart';
import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/constant.dart';
import 'package:orkut/base/pref_data.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../../models/model_offer.dart';
import '../../models/model_payment.dart';
import '../../models/model_portfolio.dart';
import '../../models/model_seller.dart';

class OfferListScreen extends StatefulWidget {
  const OfferListScreen({Key? key}) : super(key: key);

  @override
  State<OfferListScreen> createState() => OfferListScreenState();
}

class OfferListScreenState extends State<OfferListScreen> {
  void backToPrev() {
    Constant.backToPrev(context);
  }
@override
void initState(){
    super.initState();
    setState(() {
      type='buy';
    });
}
  var horSpace = FetchPixels.getPixelHeight(20);
  bool _buy = true;
  bool _sell = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Offers> datalist=[];
  bool isdata=false;
  String type='';
  Stream<List<Offers>> fetchdata(String type) async*{
      final response=await http.get(Uri.parse('https://orkt.one/api/offer-list?type=$type&page=1'),
          headers: {
            HttpHeaders.acceptHeader:'application/json',
          }
      );

      if(response.statusCode==200){
        List<Offers> offers_response=offersfromjson(response.body);

        yield offers_response;
      }
      else{
        throw Exception('Failed to fetch data');
      }
  }






  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          key: _scaffoldKey,
          endDrawer: Mydrawer(),
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                getVerSpace(FetchPixels.getPixelHeight(14)),
                appBar(context),
                Center(child: _slider()),
                getVerSpace(FetchPixels.getPixelHeight(35)),
               streamBuilder(type),
              ],
            ),
          ),floatingActionButton: floatingActionButton(),
        ),
        onWillPop: () async {
          backToPrev();
          return false;
        });
  }

  Widget appBar(BuildContext context) {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: 10),
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
        Container(
        width: FetchPixels.getPixelWidth(270),
        height: 40,
         child: Center(child:getCustomFont("Offer list", 25, Colors.black, 1)),
      ),
          IconButton(onPressed: (){
            _scaffoldKey.currentState!.openEndDrawer();

          },

              icon:Icon(Icons.more_vert,
                size: 40,
              )
          ),
      ],
        ),
    );
  }
  Widget floatingActionButton() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
        right: 10,
      ),
      child: ElevatedButton(
        onPressed: () {Navigator.pushNamed(context, Routes.createOfferRoute);
        },
        style:  ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) => buttonColor),
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
                  getNetworkImage(
                    offer.photo,
                    width: 50,
                    height: 50,
                  ),
                  getHorSpace(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getCustomFont(
                        offer.currency,
                        12,
                        Colors.black,
                        1,
                        fontWeight: FontWeight.w600,
                      ),
                      getCustomFont(
                        "From: ${offer.user_id.toString()}",
                        12,
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
                        itemSize: 17,
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
                        size: 13,
                      ),
                      getCustomFont(
                        "0%",
                        10,
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
                        9,
                        Colors.black,
                        1,
                        fontWeight: FontWeight.w600,
                      ),
                      getCustomFont(
                        "Limit: ${double.parse(offer.minimum)}-${double.parse(offer.maximum)}",
                        10,
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
                    12,
                    Colors.black,
                    1,
                    fontWeight: FontWeight.w600,
                  ),
                  getVerSpace(
                    FetchPixels.getPixelHeight(5),
                  ),
                  getCustomFont(
                    offer.payWith,
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
                    "Duration",
                    12,
                    Colors.black,
                    1,
                    fontWeight: FontWeight.w600,
                  ),
                  getVerSpace(
                    FetchPixels.getPixelHeight(5),
                  ),
                  getCustomFont(
                    "${offer.duration} mins",
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
                    "Price type",
                    12,
                    Colors.black,
                    1,
                    fontWeight: FontWeight.w600,
                  ),
                  getVerSpace(
                    FetchPixels.getPixelHeight(5),
                  ),
                  getCustomFont(
                    offer.priceType.toString(),
                    12,
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
               blueColor,
                    () {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutProfileScreen(offer.name,offer.photo,offer.user_id)));
                },
                12,
                buttonHeight: 30,
                buttonWidth: 70,
                borderColor: blueColor,
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
                blueColor,
                type,
                Colors.white,
                    () {
                      print(offer.type);
                  print(offer.cryp_id);
                  print(offer.fiat_id);
                      print(offer.price);
                      print(offer.fixed_rate);
                      print(offer.user_id);
                      print(offer.code);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>P2PTrading(offer.type,offer.cryp_id,offer.fiat_id,offer.user_id,offer.price,offer.minimum,offer.maximum,offer.currency,offer.terms,offer.instructions,offer.photo,offer.code)));
                    },
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
        return Container(
          height: 400,
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children:[
            getNetworkImage(offer.photo),
            getHorSpace(FetchPixels.getPixelHeight(20),),
          getCustomFont(offer.currency, 28, blueColor, 1),
            getHorSpace(FetchPixels.getPixelHeight(20),),
            getCustomFont("From "+offer.user_id, 18, Colors.black, 1),
            getHorSpace(FetchPixels.getPixelHeight(20),),
            getCustomFont("Rate "+offer.fixed_rate, 18, Colors.black, 1),
            getHorSpace(FetchPixels.getPixelHeight(20),),
            getCustomFont("Limit: ${offer.minimum}-${offer.maximum}", 18, Colors.black, 1),
            getHorSpace(FetchPixels.getPixelHeight(20),),

        ]
        ),
        );
      },
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


  Widget _slider(){
    return Container(
        width: 130,

        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            color:Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(children: [
          TextButton(
              onPressed: () {
                setState(() {
                  _buy = true;
                  _sell = false;
                  setState(() {
                    type='buy';
                  });
                });

              },
              child: getCustomFont('Buy', 18, !_buy?Colors.grey:Colors.white, 1),// child: Text("Buy",style:TextStyle(color:Colors.grey)),
              style: ButtonStyle(padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.all(0)
              ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.white))
                  ),
                  backgroundColor: MaterialStateProperty.all(_buy
                      ? blueColor
                      : Colors.white)
              )
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  _sell = true;
                  _buy = false;
                  setState(() {
                    type='sell';
                  });
                });

              },
              child: getCustomFont('Sell', 18, _buy?Colors.grey:Colors.white, 1),
              style: ButtonStyle(padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.all(0)
              ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.white))
                  ),
                  backgroundColor: MaterialStateProperty.all(_sell
                      ? blueColor
                      : Colors.white)
              )
          ),
        ]));
  }
StreamBuilder streamBuilder(String type){
    return  StreamBuilder<List<Offers>>(
        stream: fetchdata(type),
        builder: (context,snapshot){
          if (!snapshot.hasData) {
            return const Center(child:CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Text('Error!');
          } else {

            return  Expanded(
                flex: 1,
                child: ListView.builder(itemBuilder: (context, index) {
                  return offerCard(140, snapshot.data![index]);
                },
                  itemCount: snapshot.data!.length,
                  primary: true,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                ));
          }
        }
    );
}

}