import 'dart:convert';
import 'dart:io';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/pref_data.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../models/model_offer.dart';
import '../../models/model_payment.dart';
import '../../models/model_portfolio.dart';
import '../../models/model_seller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../routes/app_routes.dart';
import '../drawer/mydrawer.dart';
class Myoffers extends StatefulWidget {
  const Myoffers({Key? key}) : super(key: key);

  @override
  State<Myoffers> createState() => _MyoffersState();
}

class _MyoffersState extends State<Myoffers> {
  void backToPrev() {
    Constant.backToPrev(context);
  }
  String device_token="";
  @override
  void initState(){
    super.initState();
    Future<String> _futuretoken=PrefData.getToken();
     _futuretoken.then((value)async {
      setState(() {
        device_token=value;
      });
    },
    );
  }
  var horSpace = FetchPixels.getPixelHeight(20);
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Offers> datalist=[];
  bool isdata=false;
  Stream<List<Offers>> fetchdata() async*{
    final response=await http.get(Uri.parse('https://orkt.one/api/my-offers'),
        headers: {
          HttpHeaders.acceptHeader:'application/json',
          HttpHeaders.authorizationHeader: 'Bearer '+device_token,
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

                getVerSpace(FetchPixels.getPixelHeight(35)),
             streamBuilder(),
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
            child:
            gettoolbarMenu(
              context,
              "back.svg",
                  () {
                backToPrev();
              },
              istext: true,
              title: "My offers",
              fontsize: 24,
              weight: FontWeight.w700,
              textColor: Colors.black,
              isleftimage: true,
            ),
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
          backgroundColor: MaterialStateProperty.resolveWith((states) => blueColor),
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
                  getNetworkImage(offer.photo,
                    width: 50,
                    height: 50,
                  ),
                  getHorSpace(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getCustomFont(
                        offer.currency,
                        13,
                        Colors.black,
                        1,
                        fontWeight: FontWeight.w600,
                      ),
                      getCustomFont(
                        "From: ${offer.user_id}",
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
                        12,
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
                  openUserDetails(height, offer);
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
                "Buy",
                Colors.white,
                    () {},
                12,
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
        return  Container(
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
  StreamBuilder streamBuilder(){
    return  StreamBuilder<List<Offers>>(
        stream: fetchdata(),
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


