import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:orkut/base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/pref_data.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';



class Trade_start extends StatefulWidget {
  final String   type_trade;
  final String     crypid;
  final String       fiatid;
  final String       fixedrate;
  final String       user_id;
  final String       price;
  Trade_start(this.type_trade,this.crypid,this.fiatid,this.fixedrate,this.user_id,this.price);
  @override
  State<Trade_start> createState() => _Trade_startState();
}

class _Trade_startState extends State<Trade_start> {

  String type='';
  String cryp_id='';
  String fiat_id='';
  String fixed_rate='';
  String user_id='';
  String price='';
  final chat_controller=TextEditingController();
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
   fixed_rate=widget.fixedrate;
   user_id=widget.user_id;
   price=widget.price;
  }

  Future<String> createtraderequest(
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

    if(response.statusCode==200){
      return '';
    }
    else{
      throw Exception('Failed to send  data');
    }
  }




  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                getVerSpace(FetchPixels.getPixelHeight(14)),
                appBar(context),
                getVerSpace(FetchPixels.getPixelHeight(35)),
          getCustomFont("Total amount:$price ", 25, orangeColor, 1,),

          getPaddingWidget(
            EdgeInsets.symmetric(horizontal: 10),
                  Container(
                    height: FetchPixels.getPixelHeight(500),
                  ) ,
          ),

                getDefaultTextFiledWithLabel(
                  context, "Type Here......",chat_controller,
                  withprefix: false,
                  withSufix: true,
                  image: "message.svg",
                  suffiximage: "send.svg",
                  isEnable: false,
                  height: FetchPixels.getPixelHeight(60),
                ),
                getVerSpace(FetchPixels.getPixelHeight(35)),
                getVerSpace(FetchPixels.getPixelHeight(35)),
                getButton(
                  context,
                  const Color.fromRGBO(251, 192, 45, 1),
                  "Complete trade",
                  Colors.black,
                      ()async {
                    print(type);
                    print(cryp_id);
                    print(fiat_id);
                    print(fixed_rate);
                    print(user_id);
                    print(price);
                    await   createtraderequest(type, cryp_id, fiat_id, fixed_rate, user_id, price);
                  },
                  18,
                  buttonWidth: FetchPixels.getPixelWidth(140),
                  weight: FontWeight.w600,
                  borderRadius: BorderRadius.circular(
                    FetchPixels.getPixelHeight(15),
                  ),
                  buttonHeight: FetchPixels.getPixelHeight(60),
                ),
              ],
            ),
          ),
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
              title: "Trade start",
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
  
  
  
}
