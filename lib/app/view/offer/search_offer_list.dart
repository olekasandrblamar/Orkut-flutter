import 'package:orkut/app/data/data_file.dart';
import 'package:orkut/app/models/model_currency.dart';
import 'package:orkut/app/routes/app_routes.dart';
import 'package:orkut/app/view/drawer/mydrawer.dart';
import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/constant.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/model_offer.dart';
import '../../models/model_payment.dart';
import '../../models/model_portfolio.dart';

class SearchOfferListScreen extends StatefulWidget {
  const SearchOfferListScreen({Key? key}) : super(key: key);

  @override
  State<SearchOfferListScreen> createState() => SearchOfferListScreenState();
}

class SearchOfferListScreenState extends State<SearchOfferListScreen> {
  void backToPrev() {
    Constant.backToPrev(context);
  }

  var horSpace = FetchPixels.getPixelHeight(20);
  List<ModelCurrency> currencyLists = DataFile.currencyList;
  List<ModelPortfolio> portfolioLists = DataFile.portfolioList;
  List<ModelPayment> paymentLists = DataFile.paymentList;
  String selectCurrency = 'USD';
  String selectCryptoCurrency = 'BitCoin';
  String selectPaymentType = 'Paypal';
  List<String> Gateways=['Mobile Money','Mercadopage','Authorize .Net','Razor pay','Paytm','Paystack','instamojo','Stripe','Paypal','Wire bank','Skrill'];
  List<String> currencies=['USD'];

  String cryp_id='';
  String fiat_id='';
  String gateway_id='';
  String image = "btc.svg";

  bool _buy = true;
  bool _sell = false;
  TextEditingController priceController = TextEditingController();
  int offerSelect = 1;
  String offertype = "Offer Rises To";
  int priceselect = 1;
  String priceType = "+2%";
  List<Offers> offerLists = DataFile.offerList;
  TextEditingController currencyController=TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          key: _scaffoldKey,
          endDrawer: Mydrawer(),
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
         /* getVerSpace(FetchPixels.getPixelHeight(10))
            Container(
            padding: EdgeInsets.symmetric(
                vertical: FetchPixels.getPixelHeight(30), horizontal: horSpace),
            child: getButton(
                context, blueColor, "Search", Colors.bl, () {
              if (offerSelect == 1) {
                setState(() {
                  offertype = "Offer Rises To";
                });
              } else {
                setState(() {
                  offertype = "Offer Drops To";
                });
              }/*
              offerLists.add(ModelOffer(
                  image, selectCurrency, offertype, priceController.text));*/
              // Constant.sendToNext(context, Routes.);
            }, 16,
                weight: FontWeight.w600,
                borderRadius:
                BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                buttonHeight: FetchPixels.getPixelHeight(60)),
          ),*/
          body: SafeArea(
            child: getPaddingWidget(
              EdgeInsets.symmetric(horizontal: horSpace),
              Column(
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(14)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:[
                  Container(

                    width: 220,
                    height: 40,
                    child:
                  gettoolbarMenu(
                    context,
                    "back.svg",
                        () {
                      backToPrev();
                    },
                    istext: true,
                    title: "Search Offer List",
                    fontsize: 20,
                    weight: FontWeight.w700,
                    textColor: Colors.black,
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
                  getVerSpace(FetchPixels.getPixelHeight(35)),
                  Expanded(
                      flex: 1,
                      child: ListView(
                        primary: true,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Center(child: _slider()),
                          getCustomFont("Amount", 15, Colors.black, 1,
                            fontWeight: FontWeight.w600),
                          getVerSpace(FetchPixels.getPixelHeight(8)),

                          getDefaultTextFiledWithLabel(
                              context, "Enter Amount", currencyController,
                              withprefix: false,
                              image: "message.svg",
                              isEnable: false,
                              height: FetchPixels.getPixelHeight(60),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ]),
                          getVerSpace(FetchPixels.getPixelHeight(25)),
                          getCustomFont("Crypto-Currency", 15, Colors.black, 1,
                              fontWeight: FontWeight.w600),
                          getVerSpace(FetchPixels.getPixelHeight(8)),
                          SizedBox(
                            height: FetchPixels.getPixelHeight(56),
                            child: DropdownButtonFormField(
                              iconEnabledColor: Colors.white,
                              iconDisabledColor: Colors.white,
                              hint: getCustomFont(
                                  "Select Crypto Currency", 15, textColor, 1,
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
                                  selectCryptoCurrency = value!.name ?? "";
                                  image = value.image ?? "";
                                });
                                if(selectCryptoCurrency=='Bitcoin'){
                                  setState(() {
                                    cryp_id='9';
                                  });
                                }
                                else if(selectCryptoCurrency=='Ethereum'){
                                  setState(() {
                                    cryp_id='14';
                                  });
                                }
                                else if(selectCryptoCurrency=='Litecoin'){
                                  setState(() {
                                    cryp_id='15';
                                  });
                                }
                                else if(selectCryptoCurrency=='Binance coin'){
                                  setState(() {
                                    cryp_id='16';
                                  });
                                }
                              },
                            ),
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(25)),
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
                              items: currencies.map((e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: Row(
                                    children: [

                                      getHorSpace(
                                          FetchPixels.getPixelHeight(10)),
                                      getCustomFont(
                                          e?? '', 16, Colors.black, 1,
                                          fontWeight: FontWeight.w400),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectCurrency = value.toString();
                                  if(selectCurrency=="USD"){
                                    setState(() {
                                      fiat_id='1';
                                    });
                                  }
                                });
                              },
                            ),
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(25)),
                          getCustomFont("Payment Method", 15, Colors.black, 1,
                              fontWeight: FontWeight.w600),
                          getVerSpace(FetchPixels.getPixelHeight(8)),
                          SizedBox(
                            height: FetchPixels.getPixelHeight(56),
                            child: DropdownButtonFormField(
                              iconEnabledColor: Colors.white,
                              iconDisabledColor: Colors.white,
                              hint: getCustomFont(
                                  "Select Method", 15, textColor, 1,
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
                              items: Gateways.map((e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: Row(
                                    children: [
                                      getHorSpace(
                                          FetchPixels.getPixelHeight(10)),
                                      getCustomFont(
                                          e ?? '', 16, Colors.black, 1,
                                          fontWeight: FontWeight.w400),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectPaymentType = value.toString();
                                });
                                if(selectPaymentType==Gateways[0]){
                                  setState(() {
                                    gateway_id='2';
                                  });
                                }
                                else if(selectPaymentType==Gateways[1]){
                                  setState(() {
                                    gateway_id='7';
                                  });
                                }
                                else if(selectPaymentType==Gateways[2]){
                                  setState(() {
                                    gateway_id='8';
                                  });
                                }
                                else if(selectPaymentType==Gateways[3]){
                                  setState(() {
                                    gateway_id='9';
                                  });
                                }
                                else if(selectPaymentType==Gateways[4]){
                                  setState(() {
                                    gateway_id='11';
                                  });
                                }
                                else if(selectPaymentType==Gateways[5]){
                                  setState(() {
                                    gateway_id='12';
                                  });
                                }
                                else if(selectPaymentType==Gateways[6]){
                                  setState(() {
                                    gateway_id='13';
                                  });
                                }
                                else if(selectPaymentType==Gateways[7]){
                                  setState(() {
                                    gateway_id='14';
                                  });
                                }
                                else if(selectPaymentType==Gateways[8]){
                                  setState(() {
                                    gateway_id='15';
                                  });
                                }
                                else if(selectPaymentType==Gateways[9]){
                                  setState(() {
                                    gateway_id='19';
                                  });
                                }
                                else if(selectPaymentType==Gateways[10]){
                                  setState(() {
                                    gateway_id='21';
                                  });
                                }
                              },
                            ),
                          ),

                        ],
                      )),
                  getVerSpace(FetchPixels.getPixelHeight(14)),
                  Padding(
                    padding: EdgeInsets.all(FetchPixels.getPixelWidth(20)),
                    child: getButtonWithIcon(
                        context, blueColor, "Search", Colors.white,
                            () {
                          Constant.sendToNext(context, Routes.offerListRoute);
                        }, 18,
                        weight: FontWeight.bold,
                        borderRadius:
                        BorderRadius.circular(FetchPixels.getPixelHeight(12)),
                        buttonHeight: FetchPixels.getPixelHeight(48),
                        sufixIcon: true,
                        suffixImage: "arrow_right.svg",
                      suffix_color: Colors.white
                    ),
                  ),
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

}