import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orkut/app/view/extra_screens/Chat_screen.dart';
import 'package:orkut/app/view/review_screen.dart';
import 'package:orkut/base/color_data.dart';

import '../../../base/constant.dart';
import '../../../base/pref_data.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';



class Trade_details extends StatefulWidget {
  final String   type_trade;
  final String     crypid;
  final String       fiatid;
  final String       id;
  final String       price;
  final String       fiat_amount;
  final String       currency;
  final String name;
  final String photo;
  final String offer_user_id;
  final String offer_terms;
  final String trade_instruction;
  Trade_details(this.type_trade,this.crypid,this.fiatid,this.id,this.price,this.fiat_amount,this.currency,this.name,this.photo,this.offer_user_id,this.offer_terms,this.trade_instruction);
  @override
  State<Trade_details> createState() => _Trade_detailsState();
}
class _Trade_detailsState extends State<Trade_details> {
  String type='';
  String cryp_id='';
  String fiat_id='';
  String fiat_amount='';
  String offer_user_id='';
  String price='';
  String currency='';
  String trade_id='';
  String offer_terms='';
  String trade_instructions='';
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
    type=widget.type_trade;
    cryp_id=widget.crypid;
    fiat_id=widget.fiatid;
    fiat_amount=widget.fiat_amount;
    offer_user_id=widget.offer_user_id;
    price=widget.price;
    currency=widget.currency;
    trade_id=widget.id;
   offer_terms=widget.offer_terms;
   trade_instructions=widget.trade_instruction;
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
        getVerSpace(FetchPixels.getPixelHeight(14)),
    appBar(context),
    getVerSpace(FetchPixels.getPixelHeight(35)),
         Padding(
           padding:EdgeInsets.all(40),
         child:Container(
            height: 200,
            decoration:BoxDecoration(
              color: Colors.white,
                borderRadius:BorderRadius.circular(20) ,
              boxShadow: [
                BoxShadow(
                  color:shadowColor,
                  blurRadius: 15,
                  spreadRadius: 18,
                ),
              ]
            ),
            padding: EdgeInsets.all(30),
            child: Center(child:Column(
              children: [
                getCustomFont("\$${fiat_amount}  ${currency}", 25, orangeColor, 1),
             type=="sell"? getCustomFont("will be added to your account.\nPlease make the payment to collect", 15, Colors.black, 5)
                 :
             getCustomFont("will be deducted from your wallet.\nPlease wait for payment before releasing asset", 15, Colors.black, 5),
              ],
            ),
            ),
          ),
        ),
          Padding(
            padding: EdgeInsets.all(20),
            child:  Container(
              decoration:BoxDecoration(
                  color: Colors.white,
                  borderRadius:BorderRadius.circular(12) ,
                  boxShadow: [
                    BoxShadow(
                      color:shadowColor,
                      blurRadius: 15,
                      spreadRadius: 18,
                    ),
                  ]
              ),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getCustomFont("Offer terms", 14,Colors.black, 1),
                  IconButton(onPressed: (){
                    opentermsModal(500);
                  }, icon: Icon(Icons.arrow_downward)),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child:  Container(
              decoration:BoxDecoration(
                  color: Colors.white,
                  borderRadius:BorderRadius.circular(12) ,
                  boxShadow: [
                    BoxShadow(
                      color:shadowColor,
                      blurRadius: 15,
                      spreadRadius: 18,
                    ),
                  ]
              ),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getCustomFont("Trade instructions", 14,Colors.black, 1),
                  IconButton(onPressed: (){
                    opentradeinstruction(500);
                  }, icon: Icon(Icons.arrow_downward)),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child:  Container(
              decoration:BoxDecoration(
                  color: Colors.white,
                  borderRadius:BorderRadius.circular(12) ,
                  boxShadow: [
                    BoxShadow(
                      color:shadowColor,
                      blurRadius: 15,
                      spreadRadius: 18,
                    ),
                  ]
              ),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getCustomFont("Chat", 14,Colors.black, 1),
                  IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Chat_screen(widget.name,widget.photo,trade_id)));
                  }, icon: Icon(Icons.arrow_downward)),
                ],
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(20),
          child:  Container(
              width: FetchPixels.getWidthPercentSize(45),
          child: getButtonWithIcon(
              context, blueColor, type=="sell"?"Payment done":"Release asset", Colors.white,
                  () async{
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewScreen(trade_id,offer_user_id)));
              }, 15,
              weight: FontWeight.bold,
              borderRadius:
              BorderRadius.circular(FetchPixels.getPixelHeight(12)),
              buttonHeight: FetchPixels.getPixelHeight(48),
              sufixIcon: true,
              suffixImage: "arrow_right.svg",
            suffix_color: Colors.white,
          ),
        )

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
  Widget appBar(BuildContext context) {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          Container(

            width: 320,
            height: 40,
            child:
            gettoolbarMenu(
              context,
              "back.svg",
                  () {
                backToPrev();
              },
              istext: true,
              title: "Trade Details",
              fontsize: 24,
              weight: FontWeight.w700,
              textColor: Colors.black,
              isleftimage: true,
            ),
          ),
        ],
      ),
    );
  }
  void opentermsModal(height) {
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
          child: Container(
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(FontAwesomeIcons.wandSparkles),
                getCustomFont("Offer Terms", 17, blueColor,1),
                getCustomFont(offer_terms, 13, Colors.black, 1),
              ],
            ),
          ),
        );
      },
    );
  }
  void opentradeinstruction(height) {
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
          child: Container(
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(FontAwesomeIcons.chalkboardUser),
                getCustomFont("Trade instruction", 17, blueColor,1),
                getCustomFont(trade_instructions, 13, Colors.black, 1),
              ],
            ),
          ),
        );
      },
    );
  }
}
