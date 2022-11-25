import 'dart:convert';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orkut/app/view/extra_screens/trade_details.dart';

import '../../../base/constant.dart';
import '../../../base/pref_data.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import 'package:orkut/base/color_data.dart';
import 'package:http/http.dart' as http;
import '../../data/data_file.dart';
import '../../models/model_offer.dart';
import '../../routes/app_routes.dart';
import '../drawer/mydrawer.dart';

class CreateTradeRequest extends StatefulWidget {
  final String   type_trade;
  final String     crypid;
  final String       fiatid;
  final String       user_id;
  final String       price;
  final String       minimum;
  final String       maximum;
  final String      currency;
  final String      offer_terms;
  final String trade_instruction;
final String code;
  final String photo;
  CreateTradeRequest(this.type_trade,this.crypid,this.fiatid,this.user_id,this.price,this.minimum,this.maximum,this.currency,this.offer_terms,this.trade_instruction,this.photo,this.code);
  @override
  State<CreateTradeRequest> createState() => _CreateTradeRequestState();
}

class _CreateTradeRequestState extends State<CreateTradeRequest> {
  var horspace = FetchPixels.getPixelHeight(20);

  TextEditingController payController = TextEditingController();
  TextEditingController receiveController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String type='';
  String cryp_id='';
  String fiat_id='';
  String price='';
  String minimum='';
  String maximum='';
  String currency='';
  String name_user='';
  String terms='';
  String instructions='';
  String trade_id='';
  final fiat_amount_controller=TextEditingController();
  String device_token="";
  @override
  void initState(){
    super.initState();
    type=widget.type_trade;
    cryp_id=widget.crypid;
    fiat_id=widget.fiatid;
    price=widget.price;
    minimum=widget.minimum;
    maximum=widget.maximum;
    currency=widget.currency;

    terms=widget.offer_terms;
    instructions=widget.trade_instruction;
    setState(() {
      issubmit=false;
    });
    Future<String> _futuretoken=PrefData.getToken();
    _futuretoken.then((value)async {
      setState(() {
        device_token=value;
      });
    });
  }
  String status='';
String message='';
  String error='';
  String offer_user_id='';
  Future<void> createtraderequest(
      String type,
      String cryp_id,
      String fiat_id,
      String fixed_rate,
      String offer_id,
      String price,
      ) async{
    final response=await http.post(
      Uri.parse('https://orkt.one/api/create-trade-request'),
      headers: {
        HttpHeaders.acceptHeader:'application/json',
        HttpHeaders.authorizationHeader:'Bearer '+device_token,
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, dynamic>{
        'type':type,
        'crypto_id':cryp_id,
        'fiat_id':fiat_id,
        'fiat_amount':fixed_rate,
        'crypto_amount':price,
        'offer_id':offer_id,
      }),
    );
    print(response.body);
   setState(() {
     message=jsonDecode(response.body)['message'].toString();
     if(message=="Trading has been started"){
       trade_id=jsonDecode(response.body)['trade']['id'].toString();
       offer_user_id=jsonDecode(response.body)['trade']['offer_user_id'].toString();
     }
     status=jsonDecode(response.body)['status'].toString();
     error= jsonDecode(response.body)['status'].toString();
   });
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Mydrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              getVerSpace(FetchPixels.getPixelHeight(14)),
              appBar(
                context,

              ),
              getVerSpace(FetchPixels.getPixelHeight(23)),
              getTradeCard(),
              getPaddingWidget(
                EdgeInsets.symmetric(horizontal: horspace),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getCustomFont("About this Seller", 18, Colors.black, 1,
                        fontWeight: FontWeight.w600),
                  ],
                ),
              ),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              getAboutSellerCard(),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              getPaddingWidget(
                EdgeInsets.symmetric(horizontal: horspace),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getCustomFont("About this Offer", 18, Colors.black, 1,
                        fontWeight: FontWeight.w600),
                  ],
                ),
              ),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              getAboutOfferCard(),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              getPaddingWidget(
                EdgeInsets.symmetric(horizontal: horspace),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getCustomFont("Offer Terms", 18, Colors.black, 1,
                        fontWeight: FontWeight.w600),
                  ],
                ),
              ),
              getVerSpace(FetchPixels.getPixelHeight(20)),
        Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(horspace)
          ),
          margin: EdgeInsets.all(FetchPixels.getPixelHeight(horspace)),
          child: getPaddingWidget(
            EdgeInsets.symmetric(horizontal: horspace,vertical: horspace),Row(
              children: [
                Text(terms),
              ],
            ))),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              getPaddingWidget(
                EdgeInsets.symmetric(horizontal: horspace),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getCustomFont("Trade Instructions", 18, Colors.black, 1,
                        fontWeight: FontWeight.w600),
                  ],
                ),
              ),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(horspace)
                  ),
                  margin: EdgeInsets.all(FetchPixels.getPixelHeight(horspace)),
                  child: getPaddingWidget(
                      EdgeInsets.symmetric(horizontal: horspace,
                          vertical: horspace),Row(
                    children: [
                      Text(instructions),
                    ],
                  ))),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              getPaddingWidget(
                EdgeInsets.symmetric(horizontal: horspace),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getCustomFont("Reviews", 18, Colors.black, 1,
                        fontWeight: FontWeight.w600),
                  ],
                ),
              ),
              getVerSpace(FetchPixels.getPixelHeight(20)),
getReviewCard()
            ],
          ),
        ),



      ),
    );
  }

  Widget appBar(BuildContext context) {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: horspace),
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
        Container(
        width:FetchPixels.getPixelWidth(270),
        height: 40,
        child:
      gettoolbarMenu(
        context,
        "back.svg",
            () {
          Navigator.pop(context);
        },
        istext: true,
        title: "  Create Trade Requests",
        fontsize: 20,
        weight: FontWeight.w400,
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
  bool issubmit=false;
  Widget getTradeCard(){
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(horspace)
      ),
      margin: EdgeInsets.all(FetchPixels.getPixelHeight(horspace)),
      child: getPaddingWidget(
        EdgeInsets.all(horspace),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            Center(
              child: type=='sell'?getCustomFont("How much do you want to Buy?",
                  14, Colors.green, 1,
                  fontWeight: FontWeight.w700)
                  :
              getCustomFont("How much do you want to Sell?",
                  14, Colors.green, 1,
                  fontWeight: FontWeight.w700),
            ),
            getVerSpace(horspace),
            Row(
              children: [
              type=='sell'?  getCustomFont(""
                    "I will Pay",
                    12, Colors.grey, 1,
                    fontWeight: FontWeight.normal):
              getCustomFont(""
                  "I will Sell",
                  12, Colors.grey, 1,
                  fontWeight: FontWeight.normal)
              ],
            ),
            getDefaultTextFiledWithLabel(
                context, "${minimum}-${maximum}      USD", fiat_amount_controller,
                fontSize: 12,
                withprefix: false,

                suffiximage: "message.svg",
                image: "message.svg",
                isEnable: false,
                height: FetchPixels.getPixelHeight(60),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ]),
            getVerSpace(horspace),
            Row(
              children: [
                getCustomFont("And Receive",
                    18, Colors.grey, 1,
                    fontWeight: FontWeight.normal),
              ],
            ),
            getDefaultTextFiledWithLabel(
                context, "${price}   ${widget.code}", receiveController,
                fontSize: 12,
                withprefix: false,
                image: "message.svg",
                isEnable: false,
                height: FetchPixels.getPixelHeight(60),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ]),
            getVerSpace(horspace),

            Container(
              width: FetchPixels.getWidthPercentSize(30),
              child: getButtonWithIcon(
                  context, blueColor,issubmit==false?"Submit":"Wait", Colors.white,
                      () async{
                         setState(() {
                           issubmit=true;
                         });
                           await createtraderequest(type, cryp_id, fiat_id, fiat_amount_controller.text,widget.user_id, price);
                           print(message);
                                          if(message=="Trading has been started") {
                                            setState(() {
                                              issubmit=false;
                                            });
                                            AlertDialog alert = AlertDialog(
                                              title:  Icon(FontAwesomeIcons.solidCircleCheck),
                                              content: Container(
                                                height: 200,
                                                child:Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Text(message+"\nGo to trade details"),
                                                 getButtonWithIcon(context, blueColor, "Trade details", Colors.white,(){
                                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>Trade_details(type, cryp_id, fiat_id ,trade_id, price, fiat_amount_controller.text,currency,name_user,widget.photo,offer_user_id,terms,instructions)));

                                                 },15,
                                                 buttonHeight: 50,
                                                   buttonWidth: 140
                                                 )
                                                ],
                                              ),
                                              ),
                                            );

                                            // show the dialog
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return alert;
                                              },
                                            );
                                          }
                                          else{
                                            setState(() {
                                              issubmit=false;
                                            });
                                            AlertDialog alert = AlertDialog(
                                              title: Icon(FontAwesomeIcons.circleExclamation),
                                              content: Text(message+error),
                                            );
                                            // show the dialog
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return alert;
                                              },
                                            );
                                          }
                    }, 15,
                  weight: FontWeight.bold,
                  borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(12)),
                  buttonHeight: FetchPixels.getPixelHeight(48),
                  sufixIcon: true,
                  suffixImage: "arrow_right.svg",
                suffix_color: Colors.white,
              )
            )
            // offerList()
          ],
        ),
      ),
    );
  }
  Widget getAboutSellerCard(){
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(horspace)
      ),
      margin: EdgeInsets.all(FetchPixels.getPixelHeight(horspace)),
      child: getPaddingWidget(
        EdgeInsets.all(horspace),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

          Row(children: [
            profileImageWidget(),
            getHorSpace(FetchPixels.getPixelWidth(10)),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getCustomFont(name_user, 18, Colors.black, 1,
                    fontWeight: FontWeight.w600),
                RatingBar.builder(
                  initialRating: 5,
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
            Expanded(child: SizedBox())

          ],),
            getVerSpace(horspace),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.check_circle,color: Colors.green,),
                    getHorSpace(horspace),
                    getCustomFont("KYC Verified",
                        13, Colors.grey, 1,
                        fontWeight: FontWeight.normal),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.check_circle,color: Colors.green,),
                    getHorSpace(horspace),
                    getCustomFont("Email Verified",
                        13, Colors.grey, 1,
                        fontWeight: FontWeight.normal),
                  ],
                ),
              ],
            ),

            getVerSpace(horspace),
            Row(
              children: [
                Icon(Icons.highlight_remove_outlined,color: Colors.red,),
                getHorSpace(horspace),
                getCustomFont("Phone Number Not Verified",
                    13, Colors.grey, 1,
                    fontWeight: FontWeight.normal),
              ],
            ),
            getVerSpace(horspace),

            // offerList()
          ],
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

  Widget getAboutOfferCard(){
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(horspace)
      ),
      margin: EdgeInsets.all(FetchPixels.getPixelHeight(horspace)),
      child: getPaddingWidget(
        EdgeInsets.all(horspace),
        Column(crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            Row(
              children: [
                getCustomFont("Seller Rate", 15, Colors.black, 1,
                    fontWeight: FontWeight.w600),
              ],
            ),
            getCustomFont(price,
                13, Colors.grey, 1,
                fontWeight: FontWeight.normal),
            getCustomFont("Trade limit", 15, Colors.black, 1,
                fontWeight: FontWeight.w600),
            getCustomFont("${minimum}-${maximum}",
                13, Colors.grey, 1,
                fontWeight: FontWeight.normal),
            getCustomFont("Trade Duration", 15, Colors.black, 1,
                fontWeight: FontWeight.w600),
            getCustomFont("2 Minutes",
                13, Colors.grey, 1,
                fontWeight: FontWeight.normal),
            getVerSpace(horspace),

            // offerList()
          ],
        ),
      ),
    );
  }

  Widget profileImageWidget() {
    return getAssetImage("profile_photo.png",
        height: FetchPixels.getPixelHeight(50),
        width: FetchPixels.getPixelHeight(50));
  }

  Widget getReviewCard(){
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(horspace)
      ),
      margin: EdgeInsets.all(FetchPixels.getPixelHeight(horspace)),
      child: getPaddingWidget(
        EdgeInsets.all(horspace),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            Row(children: [
              profileImageWidget(),
              getHorSpace(FetchPixels.getPixelWidth(10)),
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getCustomFont(name_user, 18, Colors.black, 1,
                      fontWeight: FontWeight.w600),
                  RatingBar.builder(
                    initialRating: 5,
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
                  SizedBox(
                    width: FetchPixels.width/1.5,
                    child: getCustomFont("On the insert ta, the gakkery inckude items that are desigbed ti ciirduba with the verall look of your document",
                        13, Colors.grey, 3,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              Expanded(child: SizedBox())

            ],),

            getVerSpace(horspace),

            // offerList()
          ],
        ),
      ),
    );
  }
/*
  Expanded offerList() {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tradesList.length,
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
                  child: tradeRequestCard(
                    tradesList[index],
                    onPress: () {},
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }*/
}


