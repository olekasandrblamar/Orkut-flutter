import 'dart:convert';
import 'dart:io';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orkut/app/data/data_file.dart';
import 'package:orkut/app/models/model_currency.dart';
import 'package:orkut/app/routes/app_routes.dart';
import 'package:orkut/app/view/offer/my-offers.dart';
import 'package:orkut/base/color_data.dart';
import 'package:orkut/base/constant.dart';
import 'package:orkut/base/resizer/fetch_pixels.dart';
import 'package:orkut/base/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../../../base/pref_data.dart';
import '../../models/model_offer.dart';
import '../../models/model_payment.dart';
import '../../models/model_portfolio.dart';
import '../drawer/mydrawer.dart';

class CreateOfferScreen extends StatefulWidget {
  const CreateOfferScreen({Key? key}) : super(key: key);

  @override
  State<CreateOfferScreen> createState() => _CreateOfferScreenState();
}

class _CreateOfferScreenState extends State<CreateOfferScreen> {
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
  List<String> data=[];
  bool iscreate=false;
final crypto_id_controller=TextEditingController();
  final gateway_id_controller=TextEditingController();
  final fiat_id_controller=TextEditingController();
  final price_type_controller=TextEditingController();
  final fixed_rate_controller=TextEditingController();
  final margin_controller=TextEditingController();
  final minimum_controller=TextEditingController();
  final maximum_id_controller=TextEditingController();
  final trade_duration_controller=TextEditingController();
  final offer_terms_controller=TextEditingController();
  final trade_instructions_controller=TextEditingController();
  final type_controller=TextEditingController();
  final status_controller=TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
String errors='';
bool is_create=false;
String message='';
  Future<void> postdata(
      String type,
      String cryp_id,
      String gateway_id,
      String fiat_id,
      String price_type,
      String fixed_rate,
      String margin,
      String minimum,
      String maximum,
      String trade_duration,
      String offer_terms,
      String trade_insntruction,
      String status,
      ) async{
    Future<String> _futuretoken=PrefData.getToken();
    String device_token="";
    await  _futuretoken.then((value)async {
      setState(() {
        device_token=value;
      });
    },
    );

    final response=await http.post(
      Uri.parse('https://orkt.one/api/create-offer'),
      headers: {
        HttpHeaders.acceptHeader:'application/json',
        HttpHeaders.authorizationHeader:'Bearer '+device_token,
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, dynamic>{
         'type':type,
         'cryp_id' :cryp_id,
        'gateway_id':gateway_id,
         'fiat_id':fiat_id,
      'price_type':price_type,
         'fixed_rate':fixed_rate,
         'margin':margin,
        'minimum':minimum,
        'maximum':maximum,
         'trade_duration':trade_duration,
         'offer_terms':offer_terms,
         'trade_instructions':trade_insntruction,
        'status':status,
      }),
    );
    print(response.statusCode);
    print(response.body);
      setState(() {
        message= jsonDecode(response.body)['message'].toString();
        errors=jsonDecode(response.body)['errors'].toString();
      });

  }
List<String> crypto_currencies=['Bitcoin','Ethereum','Litecoin','Binance coin'];
  List<String> currencies=['USD'];
String default_Crypto='Bitcoin';
  List<String> Gateways=['Mobile Money','Mercadopage','Authorize .Net','Razor pay','Paytm','Paystack','instamojo','Stripe','Paypal','Wire bank','Skrill'];
  String default_gateway='Paypal';
String cryp_id='';
String gateway_id='';
String fiat_id='';
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
                    title: "Create Offer",
                    fontsize: 24,
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
                          getCustomFont("Type", 15, Colors.black, 1,
                              fontWeight: FontWeight.w600),
                          getVerSpace(FetchPixels.getPixelHeight(8)),
                          getDefaultTextFiledWithLabel(
                            context, "Type",type_controller,
                            withprefix: false,
                            suffiximage: "message.svg",
                            image: "message.svg",
                            isEnable: false,
                            height: FetchPixels.getPixelHeight(60),
                          ),
                          getCustomFont("Cryptocurrency", 15, Colors.black, 1,
                              fontWeight: FontWeight.w600),
                          getVerSpace(FetchPixels.getPixelHeight(8)),
                          SizedBox(
                            height: FetchPixels.getPixelHeight(56),
                            child: DropdownButtonFormField(
                              iconEnabledColor: Colors.white,
                              iconDisabledColor: Colors.white,
                              hint: getCustomFont(
                                  "Select Cryptocurrency", 15, textColor, 1,
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
                          getCustomFont("Payment Method", 15, Colors.black, 1,
                              fontWeight: FontWeight.w600),
                          getVerSpace(FetchPixels.getPixelHeight(8)),
                      SizedBox(
                        height: FetchPixels.getPixelHeight(56),
                        child: DropdownButtonFormField(
                          iconEnabledColor: Colors.white,
                          iconDisabledColor: Colors.white,
                          hint: getCustomFont(
                              "Select Payment Method", 15, textColor, 1,
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
                              default_gateway = value.toString();
                            });
                            if(default_gateway==Gateways[0]){
                              setState(() {
                                gateway_id='2';
                              });
                            }
                            else if(default_gateway==Gateways[1]){
                              setState(() {
                                gateway_id='7';
                              });
                            }
                            else if(default_gateway==Gateways[2]){
                              setState(() {
                                gateway_id='8';
                              });
                            }
                            else if(default_gateway==Gateways[3]){
                              setState(() {
                                gateway_id='9';
                              });
                            }
                            else if(default_gateway==Gateways[4]){
                              setState(() {
                                gateway_id='11';
                              });
                            }
                            else if(default_gateway==Gateways[5]){
                              setState(() {
                                gateway_id='12';
                              });
                            }
                            else if(default_gateway==Gateways[6]){
                              setState(() {
                                gateway_id='13';
                              });
                            }
                            else if(default_gateway==Gateways[7]){
                              setState(() {
                                gateway_id='14';
                              });
                            }
                            else if(default_gateway==Gateways[8]){
                              setState(() {
                                gateway_id='15';
                              });
                            }
                            else if(default_gateway==Gateways[9]){
                              setState(() {
                                gateway_id='19';
                              });
                            }
                            else if(default_gateway==Gateways[10]){
                              setState(() {
                                gateway_id='21';
                              });
                            }
                          },
                        ),
                      ),
                          getVerSpace(FetchPixels.getPixelHeight(14)),
                          getCustomFont("Fiat Currency", 15, Colors.black, 1,
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
                                          e ?? '', 16, Colors.black, 1,
                                          fontWeight: FontWeight.w400),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectCurrency = value.toString();
                                });
                               if(selectCurrency=="USD"){
                               setState(() {
                               fiat_id='1';
                               });
                               }
                               },
                            ),
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(25)),
                          getCustomFont("Price type", 15, Colors.black, 1,
                              fontWeight: FontWeight.w600),
                          getVerSpace(FetchPixels.getPixelHeight(8)),
                          getDefaultTextFiledWithLabel(
                            context, "Price type",price_type_controller,
                            withprefix: false,
                            suffiximage: "message.svg",
                            image: "message.svg",
                            isEnable: false,
                            height: FetchPixels.getPixelHeight(60),
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(25)),
                          getCustomFont("Fixed rate", 15, Colors.black, 1,
                              fontWeight: FontWeight.w600),
                          getVerSpace(FetchPixels.getPixelHeight(8)),
                          getDefaultTextFiledWithLabel(
                            context, "Fixed rate",fixed_rate_controller,
                            withprefix: false,
                            suffiximage: "message.svg",
                            image: "message.svg",
                            isEnable: false,
                            height: FetchPixels.getPixelHeight(60),
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(25)),
                          getCustomFont("Offer Trade Limit", 15, Colors.black, 1,
                              fontWeight: FontWeight.w600),
                          getVerSpace(FetchPixels.getPixelHeight(25)),
                          getDefaultTextFiledWithLabel(
                            context, "minimum",minimum_controller,
                            withprefix: false,
                            suffiximage: "message.svg",
                            image: "message.svg",
                            isEnable: false,
                            height: FetchPixels.getPixelHeight(60),
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(15)),
                          getDefaultTextFiledWithLabel(
                            context, "maximum",maximum_id_controller,
                            withprefix: false,
                            suffiximage: "message.svg",
                            image: "message.svg",
                            isEnable: false,
                            height: FetchPixels.getPixelHeight(60),
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(25)),
                          getCustomFont("Offer Rate", 15, Colors.black, 2,
                              fontWeight: FontWeight.w600),
                          getVerSpace(FetchPixels.getPixelHeight(8)),

                          getDefaultTextFiledWithLabel(
                            context, "Offer Margin %", margin_controller,
                            withprefix: false,
                            image: "message.svg",
                            isEnable: false,
                            height: FetchPixels.getPixelHeight(60),
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(25)),
                          getCustomFont("Trade Duration", 15, Colors.black, 1,
                              fontWeight: FontWeight.w600),
                          getVerSpace(FetchPixels.getPixelHeight(8)),
                          getDefaultTextFiledWithLabel(
                            context, "Trade duration", trade_duration_controller,
                            withprefix: false,
                            image: "message.svg",
                            isEnable: false,
                            height: FetchPixels.getPixelHeight(60),
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(25)),
                          getCustomFont("Offer Terms", 15, Colors.black, 2,
                              fontWeight: FontWeight.w600),
                          getVerSpace(FetchPixels.getPixelHeight(8)),

                          getDefaultTextFiledWithLabel(
                              context, "Type Here", offer_terms_controller,
                              withprefix: false,
                              image: "message.svg",
                              isEnable: false,
                              height: FetchPixels.getPixelHeight(60),
                              ),
                          getVerSpace(FetchPixels.getPixelHeight(25)),
                          getCustomFont("Trade Instructions", 15, Colors.black, 3,
                              fontWeight: FontWeight.w600),
                          getVerSpace(FetchPixels.getPixelHeight(8)),

                          getDefaultTextFiledWithLabel(
                              context, "Type Here", trade_instructions_controller,
                              withprefix: false,
                              image: "message.svg",
                              isEnable: false,
                              height: FetchPixels.getPixelHeight(60),
                              ),
                          getVerSpace(FetchPixels.getPixelHeight(25)),
                          getCustomFont("Offer Status", 15, Colors.black, 1,
                              fontWeight: FontWeight.w600),
                          getVerSpace(FetchPixels.getPixelHeight(8)),
                          getDefaultTextFiledWithLabel(
                            context, "Status", status_controller,
                            withprefix: false,
                            image: "message.svg",
                            isEnable: false,
                            height: FetchPixels.getPixelHeight(60),
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(25)),
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.all(FetchPixels.getPixelWidth(20)),
                    child: iscreate==true ?
                      CircularProgressIndicator()
                  :
              getButtonWithIcon(
                        context, blueColor, is_create==false?"Create Offer":"wait", Colors.white,
                            () async{
                          setState(() {
                            is_create=true;
                          });
                          await postdata(type_controller.text,cryp_id,gateway_id,fiat_id,price_type_controller.text,fixed_rate_controller.text,margin_controller.text,minimum_controller.text,maximum_id_controller.text,trade_duration_controller.text,offer_terms_controller.text,trade_instructions_controller.text,status_controller.text);
                              if(message=="Offer has been created"){
                                setState(() {
                                  is_create=false;
                                });
                                AlertDialog alert = AlertDialog(
                                  title: Icon(FontAwesomeIcons.circleCheck),
                                  content:
                                  Container(
                                    height: 200,
                                    child:Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(message+"\nGo to my offers"),
                                        getButtonWithIcon(context, blueColor, "My offer", Colors.white,(){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Myoffers()));
                                        },15,
                                            buttonHeight: 50,
                                            buttonWidth: 140,
                                            sufixIcon: true,
                                            suffixImage: "arrow_right.svg",
                                            suffix_color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  },
                                );
                              }
                              else{
                                setState(() {
                                  is_create=false;
                                });
                                AlertDialog alert = AlertDialog(
                                  title: Icon(FontAwesomeIcons.circleExclamation),
                                  content:
                                  Text("Oops!\n"+message+" "+errors),
                                );
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  },
                                );
                              }
                            }, 18,
                        weight: FontWeight.bold,
                        borderRadius:
                        BorderRadius.circular(FetchPixels.getPixelHeight(12)),
                        buttonHeight: FetchPixels.getPixelHeight(48),
                        sufixIcon: true,
                        suffixImage: "arrow_right.svg",
                suffix_color: Colors.white,
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
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
          Row(
            children: [
              getCustomFont('Min', 18,  Colors.grey , 1),
              getHorSpace(horSpace),
              TextButton(
                  onPressed: () {
                  },
                  child: getCustomFont('USD', 18,  Colors.grey , 1),
                  style: TextButton.styleFrom(padding:EdgeInsets.all(0),
                  shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.white)),elevation: 5,
                  backgroundColor: Colors.white
                            )
              ),
            ],
          ),
          Container(width: 1,color: Colors.grey,height: 10,),
          Row(
            children: [
              getCustomFont('Max', 18,  Colors.grey , 1),
              getHorSpace(horSpace),
              TextButton(
                  onPressed: () {

                  },
                  child: getCustomFont('USD', 18,  Colors.grey , 1),
                  style: TextButton.styleFrom(padding:EdgeInsets.all(0),
                  shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.white)),elevation: 5,
                  backgroundColor: Colors.white
                            )




              ),
            ],
          ),
        ]));
  }
}
